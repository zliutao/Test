//
//  Person.h
//  RunTime
//
//  Created by wujh on 16/4/19.
//  Copyright © 2016年 南京. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject<NSCoding>

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *sex;
@property (nonatomic,copy) NSString *job;
@property (nonatomic,copy) NSString *native;
@property (nonatomic,copy) NSString *education;
@property (nonatomic,assign) int age;
@property (nonatomic,assign) float height;
- (void)eat;
- (void)sleep;
- (void)work;

@end
