//
//  CardCell.m
//  ExpandingCollectionView2
//
//  Created by Quang Tran on 5/24/17.
//  Copyright © 2017 Quang Tran. All rights reserved.
//

#import "BgCell.h"

@interface BgCell()

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@end

@implementation BgCell

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
  self = [super initWithCoder:coder];
  if (self) {
    
  }
  return self;
}

-(void)setImg:(UIImage *)img {
  self.bgImageView.image = img;
}

@end
