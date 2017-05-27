//
//  MyCollectionViewLayout.m
//  ExpandingCollectionView2
//
//  Created by Quang Tran on 5/24/17.
//  Copyright © 2017 Quang Tran. All rights reserved.
//

#import "BgCollectionViewLayout.h"

@interface BgCollectionViewLayout()

@property(nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *cache;
@property(nonatomic, readonly) NSInteger numberOfItems;
@property(nonatomic, readonly) CGFloat cellHeight;
@property(nonatomic, readonly) CGFloat collectionViewWidth;
@property(nonatomic, readonly) CGFloat collectionViewHeight;

@end

@implementation BgCollectionViewLayout

-(NSInteger)numberOfItems {
  return [self.collectionView numberOfItemsInSection:0];
}

-(CGFloat)collectionViewWidth {
  return self.collectionView.bounds.size.width;
}

-(CGFloat)collectionViewHeight {
  return self.collectionView.bounds.size.height;
}

-(CGSize)collectionViewContentSize {
  return CGSizeMake(self.offsetWidth * self.numberOfItems + self.collectionViewWidth,
                    self.cellHeight);
}

-(NSInteger)featuredItemIndex {
  return (NSInteger)(self.collectionView.contentOffset.x / self.offsetWidth);
}

-(CGFloat)nextItemPercentageOffset {
  return self.collectionView.contentOffset.x / self.offsetWidth - [self featuredItemIndex];
}

-(void)prepareLayout {
  [super prepareLayout];
  
  if (self.cache == nil) {
    self.cache = [NSMutableArray new];
  }
  else {
    [self.cache removeAllObjects];
  }
  
  CGFloat cellHeight = self.collectionView.bounds.size.height;
  
  // The cell width will extend 2 sides with a constant
  CGFloat cellWidth = self.offsetWidth + self.collectionView.bounds.size.width + self.offsetWidth;
  
  for (int i = 0; i < self.numberOfItems; i++) {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.frame = CGRectMake(i * self.offsetWidth - self.offsetWidth,
                                  0,
                                  cellWidth,
                                  cellHeight);
    attributes.zIndex = -i;

    if (i == [self featuredItemIndex]) {
      attributes.alpha = 1 - [self nextItemPercentageOffset];
    }
    else if (i == [self featuredItemIndex] + 1) {
      attributes.alpha = [self nextItemPercentageOffset];
    }
    else {
      attributes.alpha = 0;
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

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
  return YES;
}

@end
