//
//  Commenter.m
//  ExpandingCollectionView2
//
//  Created by Quang Tran on 5/25/17.
//  Copyright © 2017 Quang Tran. All rights reserved.
//

#import "Commenter.h"

@implementation Commenter

+(Commenter*)commenterWithDict:(NSDictionary*)dict {
  Commenter *c = [Commenter new];
  c.name = dict[@"name"];
  c.comment = dict[@"comment"];
  c.avatarName = dict[@"avatarName"];
  c.commentDate = dict[@"commentDate"];
  return c;
}

+(NSArray<Commenter*>*)commentersWithDictArray:(NSArray<NSDictionary*>*)arr {
  NSMutableArray<Commenter*> *returnedArr = [NSMutableArray new];
  for (NSDictionary *dict in arr) {
    [returnedArr addObject:[Commenter commenterWithDict:dict]];
  }
  return returnedArr;
}

@end
