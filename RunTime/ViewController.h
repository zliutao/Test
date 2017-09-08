//
//  ViewController.h
//  RunTime
//
//  Created by wujh on 16/4/19.
//  Copyright © 2016年 南京. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^cityChoose)(float a);

@interface ViewController : UIViewController

@property (nonatomic ,copy) cityChoose cityBlock;
@property (nonatomic ,assign) int  b;

@end

