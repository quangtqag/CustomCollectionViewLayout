//
//  UIColor+Ext.m
//  ExpandingCollectionView2
//
//  Created by Quang Tran on 5/24/17.
//  Copyright © 2017 Quang Tran. All rights reserved.
//

#import "UIColor+Ext.h"

@implementation UIColor (Ext)

+(UIColor *)randomColor {
  CGFloat r = arc4random_uniform(255) / 255.0;
  CGFloat g = arc4random_uniform(255) / 255.0;
  CGFloat b = arc4random_uniform(255) / 255.0;
  return [UIColor colorWithRed:r green:g blue:b alpha:1];
}

@end
