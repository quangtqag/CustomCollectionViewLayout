//
//  MyCollectionViewLayout.h
//  ExpandingCollectionView2
//
//  Created by Quang Tran on 5/24/17.
//  Copyright © 2017 Quang Tran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardCollectionViewLayout : UICollectionViewLayout

@property(assign, readonly) CGFloat cellWidth;
@property(assign, readonly) CGFloat nonFeaturedScale;

@end
