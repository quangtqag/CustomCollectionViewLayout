//
//  MyCollectionViewLayout.m
//  ExpandingCollectionView2
//
//  Created by Quang Tran on 5/24/17.
//  Copyright © 2017 Quang Tran. All rights reserved.
//

#import "CardCollectionViewLayout.h"

@interface CardCollectionViewLayout()

@property(nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *cache;
@property(nonatomic, readonly) NSInteger numberOfItems;
@property(nonatomic, readonly) CGFloat cellHeight;
@property(nonatomic, readonly) CGFloat collectionViewWidth;
@property(nonatomic, readonly) CGFloat collectionViewHeight;

@end

@implementation CardCollectionViewLayout

const CGFloat kWidthRatio = 0.625;
const CGFloat kNonFeaturedScale = 0.8;
const CGFloat kNonFeaturedAlpha = 0.6;

-(CGFloat)nonFeaturedScale {
  return kNonFeaturedScale;
}

-(NSInteger)numberOfItems {
  return [self.collectionView numberOfItemsInSection:0];
}

-(CGFloat)cellHeight {
  return self.collectionView.bounds.size.height;
}

-(CGFloat)cellWidth {
  return self.collectionView.bounds.size.width * kWidthRatio;
}

-(CGFloat)collectionViewWidth {
  return self.collectionView.bounds.size.width;
}

-(CGFloat)collectionViewHeight {
  return self.collectionView.bounds.size.height;
}

-(CGSize)collectionViewContentSize {
  return CGSizeMake(self.cellWidth * self.numberOfItems + self.collectionViewWidth - self.cellWidth,
                    self.cellHeight);
}

-(NSInteger)featuredItemIndex {
  return (NSInteger)(self.collectionView.contentOffset.x / self.cellWidth);
}

-(CGFloat)nextItemPercentageOffset {
  return self.collectionView.contentOffset.x / self.cellWidth - [self featuredItemIndex];
}

-(void)prepareLayout {
  [super prepareLayout];
  
  if (self.cache == nil) {
    self.cache = [NSMutableArray new];
  }
  else {
    [self.cache removeAllObjects];
  }
  
  CGFloat paddingLeft = (self.collectionViewWidth - self.cellWidth) / 2;
  
  for (int i = 0; i < self.numberOfItems; i++) {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.frame = CGRectMake(i * self.cellWidth + paddingLeft,
                                  0,
                                  self.cellWidth,
                                  self.cellHeight);
    // Only 2 cell change scale and alpha are featured cell and sibling cell
    // When move: featured cell will decrease alpha and scale
    // While that sibling cell will increase alpha and scale
    // Remaining cells will have alpha and scale lowest that set by a constant
    if (i == [self featuredItemIndex]) {
      CGFloat scale = 1 - ((1 - kNonFeaturedScale) * [self nextItemPercentageOffset]);
      attributes.transform = CGAffineTransformMakeScale(scale, scale);
      attributes.alpha = 1 - ((1 - kNonFeaturedAlpha) * [self nextItemPercentageOffset]);
    }
    else if (i == [self featuredItemIndex] + 1
             || i == [self featuredItemIndex] - 1) {
      CGFloat scale = kNonFeaturedScale + ((1 - kNonFeaturedScale) * [self nextItemPercentageOffset]);
      attributes.transform = CGAffineTransformMakeScale(scale, scale);
      attributes.alpha = kNonFeaturedAlpha + ((1 - kNonFeaturedAlpha) * [self nextItemPercentageOffset]);
    }
    else {
      CGFloat scale = kNonFeaturedScale;
      attributes.transform = CGAffineTransformMakeScale(scale, scale);
      attributes.alpha = kNonFeaturedAlpha;
    }
    
    [self.cache addObject:attributes];
  }
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
  NSMutableArray<UICollectionViewLayoutAttributes *> *layoutAttributes = [NSMutableArray new];
  for (UICollectionViewLayoutAttributes *attributes in self.cache) {
    if (CGRectIntersectsRect(attributes.frame, rect)) {
      [layoutAttributes addObject:attributes];
    }
  }
  return layoutAttributes;
}

// Return nearest cell position
-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
  NSInteger itemIndex = roundf(proposedContentOffset.x / self.cellWidth);
  CGFloat xOffset = itemIndex * self.cellWidth;
  return CGPointMake(xOffset, 0);
}

// Make prepareLayout func alway called when user drad card
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
  return YES;
}

@end
