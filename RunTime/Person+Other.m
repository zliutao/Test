//
//  Person+Other.m
//  RunTime
//
//  Created by wujh on 16/4/19.
//  Copyright © 2016年 南京. All rights reserved.
//

#import "Person+Other.h"

char *const ASSOCITION_INFO = "ASSOCITION_INFO";
@implementation Person (Other)

- (void)setMoney:(NSString *)money{

    objc_setAssociatedObject(self, ASSOCITION_INFO, money, OBJC_ASSOCIATION_RETAIN_NONATOMIC);


}

- (NSString *)money{

    NSString *m = objc_getAssociatedObject(self, ASSOCITION_INFO);
    return m;

}


@end
