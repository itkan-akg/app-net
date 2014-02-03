//
//  MBPostsViewController.m
//  App.NetClient
//
//  Created by Ankit Kumar Gupta on 23/01/14.
//  Copyright (c) 2014 MoldedBits. All rights reserved.
//

#import "MBPostsViewController.h"
#import "MBPostCell.h"
#import "MBPostBusinessLayer.h"
#import "MBPostViewObject.h"
#import "MBProgressHUD.h"

#define MIN_ROW_HEIGHT 115.0f //default cell height from storyboard

@interface MBPostsViewController ()
@property (nonatomic, strong) NSArray* arrayOfPosts;
@property (nonatomic, strong) MBPostCell *sizingCell;
@end

@implementation MBPostsViewController
{
    __strong MBPostBusinessLayer *_postBusinessLayer;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /*
	 * create a cell instance to use for auto layout sizing
     * will be needed for dynamic row height
	 */
	self.sizingCell = [self.tableView dequeueReusableCellWithIdentifier:@"PostCellIdentifier"];
	self.sizingCell.hidden = YES;
	[self.tableView addSubview:self.sizingCell];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self loadPosts:^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    _postBusinessLayer = nil;
}

#pragma mark - Table view data source

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] init];
    
    [headerView setBackgroundColor:[UIColor clearColor]];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    CGFloat height = CGFLOAT_MIN;
    
    //to avoid content overlapping with status bar on iOS 7+
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
        height = 20.0f; //standard height of status bar.
    }
    
    return height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ([self arrayOfPosts] ? [[self arrayOfPosts] count]:0);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PostCellIdentifier";
    MBPostCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    MBPostViewObject *postViewObject = self.arrayOfPosts[indexPath.row];
    cell.usernameLabel.text = postViewObject.username;
    cell.postText.text = postViewObject.text;
    
    //fetching asynchronously in background, to avoid blocking the main thread.
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSURL *imageURL = [NSURL URLWithString:postViewObject.imageURLString];
        NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
        
        if (imageData) {
            //UI actions have to be performed onto the main thread.
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([tableView indexPathForCell:cell].row == indexPath.row) {
                    cell.userImageView.image = [UIImage imageWithData:imageData];
                }
            });
        }
    });
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat calculatedHeight = CGFLOAT_MIN;
    
    if (self.arrayOfPosts && self.sizingCell) {
        self.sizingCell.frame = CGRectMake(CGFLOAT_MIN, CGFLOAT_MIN, CGRectGetWidth(self.tableView.bounds), CGFLOAT_MIN);
        MBPostViewObject *postViewObject = self.arrayOfPosts[indexPath.row];
        self.sizingCell.usernameLabel.text = postViewObject.username;
        self.sizingCell.postText.text = postViewObject.text;
        
        [self.sizingCell setNeedsLayout];
        [self.sizingCell layoutIfNeeded];
        
        calculatedHeight = [self.sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        calculatedHeight = MAX(calculatedHeight,MIN_ROW_HEIGHT);
    }
	return calculatedHeight;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return MIN_ROW_HEIGHT;
}

#pragma mark - UI actions
- (IBAction)refreshPosts:(UIRefreshControl *)sender
{
    [self loadPosts:^{
        [sender endRefreshing];
    }];
 }

#pragma mark - private methods

- (MBPostBusinessLayer*)postBusinessLayer
{
    //lazy loading
    if (!_postBusinessLayer) {
        _postBusinessLayer = [[MBPostBusinessLayer alloc] init];
    }
    
    return _postBusinessLayer;
}

- (void)loadPosts:(void(^)(void))completionBlock
{
    [[self postBusinessLayer] fetchNewPosts:^(NSArray *arrayOfResult) {
        
        //ensuring that we are on main thread for UI operations
        dispatch_async(dispatch_get_main_queue(), ^{
            self.arrayOfPosts = arrayOfResult;
            [self.tableView reloadData];
            
            if (completionBlock) {
                completionBlock();
            }
        });
    }];
}

@end
