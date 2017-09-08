//
//  Person.m
//  RunTime
//
//  Created by wujh on 16/4/19.
//  Copyright © 2016年 南京. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>
@implementation Person

- (void)encodeWithCoder:(NSCoder *)aCoder{
    unsigned int count;
    objc_property_t *propertys = class_copyPropertyList([self class], &count);
    for (int i = 0; i<count; i++) {
        objc_property_t property = propertys[i];
        const char*name = property_getName(property);
        NSString *key = [NSString stringWithUTF8String:name];
        NSString *propertyValue = [self valueForKey:key];
        [aCoder encodeObject:propertyValue forKey:key];
        
        
    }

    free(propertys);
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{

    if (self = [super init]) {
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([self class], &count);
        
        for (int i = 0; i<count; i++) {
            Ivar iva = ivars[i];
            const char*name = ivar_getName(iva);
            NSString *kry = [NSString stringWithUTF8String:name];
            
            id value = [aDecoder decodeObjectForKey:kry];
            
            [self setValue:value forKey:kry];
        }
        
        free(ivars);
    }


    return self;

}
@end
