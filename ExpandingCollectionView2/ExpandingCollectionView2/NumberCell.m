//
//  NumberCell.m
//  ExpandingCollectionView2
//
//  Created by Quang Tran on 5/24/17.
//  Copyright © 2017 Quang Tran. All rights reserved.
//

#import "NumberCell.h"

@implementation NumberCell

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

-(void)setNumber:(NSInteger)number {
  self.numberLabel.text = [NSString stringWithFormat:@"%ld", number];
  
}

@end
