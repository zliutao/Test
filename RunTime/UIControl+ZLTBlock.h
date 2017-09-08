//
//  UIControl+ZLTBlock.h
//  RunTime
//
//  Created by wujh on 16/4/19.
//  Copyright © 2016年 南京. All rights reserved.
//

typedef void(^ZLTBlock)(id sender);

#import <UIKit/UIKit.h>

@interface UIControl (ZLTBlock)

@property (nonatomic ,copy) ZLTBlock callBack;
@property (nonatomic ,copy) NSString *name;
@end
