//
//  CommenterCell.m
//  ExpandingCollectionView2
//
//  Created by Quang Tran on 5/25/17.
//  Copyright © 2017 Quang Tran. All rights reserved.
//

#import "CommenterCell.h"

@interface CommenterCell()

@property (weak, nonatomic) IBOutlet UIImageView *faceImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation CommenterCell

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
  self = [super initWithCoder:coder];
  if (self) {
    
  }
  return self;
}

-(void)setCommenter:(Commenter *)c {
  self.faceImageView.image = [UIImage imageNamed:c.avatarName];
  self.nameLabel.text = c.name;
  self.descLabel.text = c.comment;
  self.dateLabel.text = c.commentDate;
}

-(void)layoutSubviews {
  self.faceImageView.layer.cornerRadius = self.faceImageView.bounds.size.width/2;
  self.faceImageView.layer.masksToBounds = YES;
}

@end
