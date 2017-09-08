//
//  UIControl+ZLTBlock.m
//  RunTime
//
//  Created by wujh on 16/4/19.
//  Copyright © 2016年 南京. All rights reserved.
//

#import "UIControl+ZLTBlock.h"
#import <objc/runtime.h>
static const void*zlt = "zlt";
  const void*nameKey = "nameKey";
@implementation UIControl (ZLTBlock)

- (void)setCallBack:(ZLTBlock)callBack{

    objc_setAssociatedObject(self, zlt, callBack, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self removeTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    
    if (callBack) {
        [self addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }


}

- (ZLTBlock)callBack{

    return objc_getAssociatedObject(self, zlt);
   
    

}

- (void)click:(UIButton *)sender{
    if (self.callBack) {
        
        self.callBack(sender);
       
    }
}

- (void)setName:(NSString *)name{
  
    objc_setAssociatedObject(self, nameKey, name, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString*)name{

    return objc_getAssociatedObject(self, nameKey);
}

@end
