//
//  Course.m
//  ExpandingCollectionView2
//
//  Created by Quang Tran on 5/25/17.
//  Copyright © 2017 Quang Tran. All rights reserved.
//

#import "Course.h"

@implementation Course

+(Course*)courseWithDict:(NSDictionary *)dict {
  Course *c = [Course new];
  c.title = dict[@"title"];
  c.authorName = dict[@"authorName"];
  c.authorAvatarName = dict[@"authorAvatarName"];
  c.desc = dict[@"desc"];
  c.featuredImageName = dict[@"featuredImageName"];
  c.views = [dict[@"views"] integerValue];
  c.comments = [dict[@"comments"] integerValue];
  c.likes = [dict[@"likes"] integerValue];
  c.commenters = [Commenter commentersWithDictArray:dict[@"commenters"]];
  return c;
}

+(NSArray<Course*>*)coursesWithDictArray:(NSArray<NSDictionary*>*)arr {
  NSMutableArray<Course*> *returnedArr = [NSMutableArray new];
  for (NSDictionary *dict in arr) {
    [returnedArr addObject:[Course courseWithDict:dict]];
  }
  return returnedArr;
}

@end
