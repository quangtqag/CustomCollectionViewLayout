//
//  main.m
//  ExpandingCollectionView2
//
//  Created by Quang Tran on 5/24/17.
//  Copyright © 2017 Quang Tran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "QTouchposeApplication.h"

int main(int argc, char * argv[]) {
  @autoreleasepool {
//      return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    return UIApplicationMain(argc,
                             argv,
                             NSStringFromClass([QTouchposeApplication class]),
                             NSStringFromClass([AppDelegate class]));
  }
}
