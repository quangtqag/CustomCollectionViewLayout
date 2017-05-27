//
//  CardCell.m
//  ExpandingCollectionView2
//
//  Created by Quang Tran on 5/24/17.
//  Copyright © 2017 Quang Tran. All rights reserved.
//

#import "CardCell.h"

@interface CardCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *featuredImageView;
@property (weak, nonatomic) IBOutlet UIImageView *faceImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIImageView *eyeImageView;
@property (weak, nonatomic) IBOutlet UILabel *viewLabel;
@property (weak, nonatomic) IBOutlet UIImageView *commentImageView;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *heartImageView;
@property (weak, nonatomic) IBOutlet UILabel *likeLabel;

@end

@implementation CardCell

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self config];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
  self = [super initWithCoder:coder];
  if (self) {
    [self config];
  }
  return self;
}

-(void)setCourse:(Course *)c {
  self.featuredImageView.image = [UIImage imageNamed:c.featuredImageName];
  self.titleLabel.text = c.title;
  self.faceImageView.image = [UIImage imageNamed:c.authorAvatarName];
  self.nameLabel.text = c.authorName;
  self.descLabel.text = c.desc;
  self.viewLabel.text = [NSString stringWithFormat:@"%ld", c.views];
  self.commentLabel.text = [NSString stringWithFormat:@"%ld", c.comments];
  self.likeLabel.text = [NSString stringWithFormat:@"%ld", c.likes];
}

-(void)config {
  self.contentView.layer.cornerRadius = 5;
  self.contentView.layer.masksToBounds = YES;
  self.contentView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
  self.contentView.layer.borderWidth = 0.5;
  
  self.layer.masksToBounds = NO;
  self.layer.shadowOffset = CGSizeMake(10, 15);
  self.layer.shadowRadius = 10;
  self.layer.shadowOpacity = 0.5;
  self.backgroundColor = [UIColor clearColor];
}

-(void)layoutSubviews {
  self.faceImageView.layer.cornerRadius = self.faceImageView.bounds.size.width/2;
  self.faceImageView.layer.masksToBounds = YES;
  
  UIColor *iconTintColor = [UIColor lightGrayColor];
  UIImage *eyeImg = [[UIImage imageNamed:@"eye"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  self.eyeImageView.image = eyeImg;
  self.eyeImageView.tintColor = iconTintColor;
  
  UIImage *commentImg = [[UIImage imageNamed:@"comment"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  self.commentImageView.image = commentImg;
  self.commentImageView.tintColor = iconTintColor;
  
  UIImage *heartImg = [[UIImage imageNamed:@"heart"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  self.heartImageView.image = heartImg;
  self.heartImageView.tintColor = iconTintColor;
}

@end
