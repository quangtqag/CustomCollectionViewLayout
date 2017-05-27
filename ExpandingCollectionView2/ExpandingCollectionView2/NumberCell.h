//
//  NumberCell.h
//  ExpandingCollectionView2
//
//  Created by Quang Tran on 5/24/17.
//  Copyright © 2017 Quang Tran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NumberCell : UICollectionViewCell
@property(nonatomic, assign) NSInteger number;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@end
