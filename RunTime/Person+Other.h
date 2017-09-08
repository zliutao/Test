//
//  Person+Other.h
//  RunTime
//
//  Created by wujh on 16/4/19.
//  Copyright © 2016年 南京. All rights reserved.
//


#import "Person.h"
#import <objc/runtime.h>
@interface Person (Other)

@property (nonatomic ,copy) NSString *money;
@property (nonatomic ,copy) NSString *fat;
@property (nonatomic ,copy) NSString *height;
@property (nonatomic ,copy) NSString *man;
@property (nonatomic ,copy) NSString *black;
@property (nonatomic ,copy) NSString *weight;
@property (nonatomic ,copy) NSString *beautiful;
@property (nonatomic ,copy) NSString *ugly;

@property (nonatomic ,copy) NSString *six;

- (id)initWithDictionary :(NSDictionary *)dic;
@end
