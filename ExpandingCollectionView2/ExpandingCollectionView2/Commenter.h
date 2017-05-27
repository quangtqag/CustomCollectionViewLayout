//
//  Commenter.h
//  ExpandingCollectionView2
//
//  Created by Quang Tran on 5/25/17.
//  Copyright © 2017 Quang Tran. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Commenter : NSObject

@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *comment;
@property(nonatomic, strong) NSString *avatarName;
@property(nonatomic, strong) NSString *commentDate;

+(Commenter*)commenterWithDict:(NSDictionary*)dict;
+(NSArray<Commenter*>*)commentersWithDictArray:(NSArray<NSDictionary*>*)arr;

@end
