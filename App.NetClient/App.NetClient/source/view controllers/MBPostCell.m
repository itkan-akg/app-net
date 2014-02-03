//
//  MBPostCell.m
//  App.NetClient
//
//  Created by Ankit Kumar Gupta on 23/01/14.
//  Copyright (c) 2014 MoldedBits. All rights reserved.
//

#import "MBPostCell.h"

@implementation MBPostCell
-(void)awakeFromNib {
    self.imageView.layer.cornerRadius = 10.0f;
    self.imageView.layer.masksToBounds = YES;
}

-(void)prepareForReuse {
    [super prepareForReuse];
    self.usernameLabel.text = nil;
    self.postText.text = nil;
    self.userImageView.image = [UIImage imageNamed:@"user"];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    self.postText.preferredMaxLayoutWidth = CGRectGetWidth(self.postText.bounds);
}

@end
