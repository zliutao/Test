//
//  MyTableViewCell.h
//  RunTime
//
//  Created by wujh on 16/7/14.
//  Copyright © 2016年 南京. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"

typedef void(^makeCall)();

@interface MyTableViewCell : UITableViewCell

@property (nonatomic ,retain) UILabel *lab;
@property (nonatomic ,retain) UIButton *button;
@property (nonatomic ,copy)   makeCall call;
@property (nonatomic ,retain) OrderModel *model;

@end
