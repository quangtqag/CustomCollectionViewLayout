//
//  CardAnimator.m
//  ExpandingCollectionView2
//
//  Created by Quang Tran on 5/25/17.
//  Copyright © 2017 Quang Tran. All rights reserved.
//

#import "CardPresentAnimationController.h"

@implementation CardPresentAnimationController

static const NSTimeInterval duration = 0.5;
static const CGFloat offsetTop = 44;
static const CGFloat offsetLeftRight = 20;

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
  return duration;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
  
  UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
  UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
  
  CGRect initialFrame = self.originFrame;
  CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
  finalFrame = CGRectInset(finalFrame, offsetLeftRight, 0);
  finalFrame.origin.y = offsetTop;
  finalFrame.size.height -= offsetTop;
  toVC.view.frame = initialFrame;
  toVC.view.layer.masksToBounds = YES;
  // Force recalculate layout
  [toVC.view layoutIfNeeded];
  
  UIView *containerView = transitionContext.containerView;
  [containerView addSubview:fromVC.view];
  [containerView addSubview:toVC.view];
  
  [UIView animateWithDuration:duration
                   animations:^{
                     toVC.view.frame = finalFrame;
                     [toVC.view layoutIfNeeded];
                   }
                   completion:^(BOOL finished) {
                     [transitionContext completeTransition:YES];
                     
                     // After animated, from view auto disappear (perhaps a bug from frameword), so just re-add it
                     [containerView addSubview:fromVC.view];
                     [containerView sendSubviewToBack:fromVC.view];
                   }];
}

@end
