//
//  CardAnimator.h
//  ExpandingCollectionView2
//
//  Created by Quang Tran on 5/25/17.
//  Copyright © 2017 Quang Tran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CardDismissAnimationController : NSObject<UIViewControllerAnimatedTransitioning>

@property(nonatomic, assign) CGRect destinationFrame;

@end
