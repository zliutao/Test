//
//  MyTableViewCell.m
//  RunTime
//
//  Created by wujh on 16/7/14.
//  Copyright © 2016年 南京. All rights reserved.
//

#import "MyTableViewCell.h"

@implementation MyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _lab = [[UILabel alloc] initWithFrame:CGRectZero];
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        
       
        
        [self.contentView addSubview:_lab];
        [self.contentView addSubview:_button];
        
    }

    return self;
}

- (void)setModel:(OrderModel *)model{
    self.model = model;
    if (model) {
        _lab.text = model.orderid;
        [_button setTitle:model.orderCount forState:UIControlStateNormal];
    }


}

- (void)layoutSubviews{
    [super layoutSubviews];

    _lab.frame = CGRectMake(12, 10, 60, 30);
    _lab.backgroundColor = [UIColor redColor];
    _button.frame = CGRectMake(80, 10, 100, 30);
    _button.backgroundColor = [UIColor blueColor];
}

- (void)click:(UIButton *)btn{
    if (self.call) {
        self.call();
    }
}
@end
