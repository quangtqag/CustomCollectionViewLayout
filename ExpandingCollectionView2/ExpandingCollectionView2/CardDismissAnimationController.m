//
//  CardAnimator.m
//  ExpandingCollectionView2
//
//  Created by Quang Tran on 5/25/17.
//  Copyright © 2017 Quang Tran. All rights reserved.
//

#import "CardDismissAnimationController.h"

@implementation CardDismissAnimationController

static const NSTimeInterval duration = 0.5;

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
  return duration;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
  
  UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
  UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
  
  CGRect finalFrame = self.destinationFrame;
  
  UIView *containerView = transitionContext.containerView;
  [containerView addSubview:toVC.view];
  [containerView addSubview:fromVC.view];
  
  [fromVC.view layoutIfNeeded];
  
  [UIView animateWithDuration:duration
                   animations:^{
                     fromVC.view.frame = finalFrame;
                     [fromVC.view layoutIfNeeded];
                   }
                   completion:^(BOOL finished) {
                     [fromVC.view removeFromSuperview];
                     [transitionContext completeTransition:YES];
                   }];
}

@end
