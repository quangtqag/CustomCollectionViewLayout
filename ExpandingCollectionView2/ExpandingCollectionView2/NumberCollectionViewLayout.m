//
//  NumberCollectionViewLayout.m
//  ExpandingCollectionView2
//
//  Created by Quang Tran on 5/24/17.
//  Copyright © 2017 Quang Tran. All rights reserved.
//

#import "NumberCollectionViewLayout.h"

@interface NumberCollectionViewLayout()

@property(nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *cache;
@property(nonatomic, readonly) NSInteger numberOfItems;
@property(nonatomic, readonly) CGFloat cellWidth;
@property(nonatomic, readonly) CGFloat collectionViewWidth;
@property(nonatomic, readonly) CGFloat collectionViewHeight;

@end


@implementation NumberCollectionViewLayout

-(NSInteger)numberOfItems {
  return [self.collectionView numberOfItemsInSection:0];
}

-(CGFloat)cellWidth {
  return self.collectionView.bounds.size.width;
}

-(CGFloat)collectionViewWidth {
  return self.collectionView.bounds.size.width;
}

-(CGFloat)cellHeight {
  return self.collectionView.bounds.size.height / 3;
}

-(CGFloat)collectionViewHeight {
  return self.collectionView.bounds.size.height;
}

-(CGSize)collectionViewContentSize {
  return CGSizeMake(self.cellWidth,
                    self.cellHeight * (self.numberOfItems + 2));
}

-(NSInteger)featuredItemIndex {
  return (NSInteger)(self.collectionView.contentOffset.y / self.cellHeight);
}

-(CGFloat)nextItemPercentageOffset {
  return self.collectionView.contentOffset.y / self.cellHeight - [self featuredItemIndex];
}

-(void)prepareLayout {
  [super prepareLayout];
  
  if (self.cache == nil) {
    self.cache = [NSMutableArray new];
  }
  else {
    [self.cache removeAllObjects];
  }
  
  for (int i = 0; i < self.numberOfItems; i++) {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.frame = CGRectMake(0,
                                  (i + 1) * self.cellHeight,
                                  self.cellWidth,
                                  self.cellHeight);
    
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

-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
  NSInteger itemIndex = roundf(proposedContentOffset.y / self.cellHeight);
  CGFloat yOffset = itemIndex * self.cellHeight;
  return CGPointMake(0, yOffset);
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
  return YES;
}

@end
