//
//  SuperViewController.m
//  RunTime
//
//  Created by wujh on 16/7/5.
//  Copyright © 2016年 南京. All rights reserved.
//

#import "SuperViewController.h"
#import "MyTableViewCell.h"
#import "ShoppingCartView.h"
#import "ViewModel.h"
#import "GoodsListView.h"
typedef enum {
    ControllerStateShowLogo = 0, // 显示logo
    ControllerStateOnlyLeftButton = 1,  // 显示左边按钮
    ControllerStateWithBothButton = 2,   // 显示左右按钮
    ControllerStateCustomMiddleView = 3,  // 自定义中间视图
    ControllerStateCustomMiddleViewWithoutGesture  //自定义中间视图，无手势
}ControllerState;


@interface SuperViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *maintable;
//抛物线红点
@property (strong, nonatomic) UIImageView *redView;
//数据源
@property (nonatomic,strong) NSMutableArray *dataArray;
//订单数据
@property (nonatomic,strong) NSMutableArray *ordersArray;
//总数量
@property (nonatomic,assign) NSInteger totalOrders;

@property (nonatomic,strong) ShoppingCartView *shoppcartview;


@end

@implementation SuperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    tableView.delegate = self;
    tableView.dataSource = self;
   // [tableView registerClass:[MyTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view  addSubview:tableView];
    self.view.backgroundColor = [UIColor blackColor];
    self.shoppcartview  = [[ShoppingCartView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 50, CGRectGetWidth(self.view.bounds), 40) inView:self.view];
    [self.view addSubview:self.shoppcartview];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(UpdatemainUI:) name:@"updateUI" object:nil];
    
//CALayer
    

    
}
-(void)UpdatemainUI:(NSNotification *)Notification{
    
    NSMutableDictionary *dic =[NSMutableDictionary dictionaryWithDictionary: Notification.userInfo];
    //重新计算订单数组。
    self.ordersArray = [ViewModel storeOrders:dic[@"update"] OrderData:self.ordersArray isAdded:[dic[@"isAdd"] boolValue]];
    self.shoppcartview.OrderList.objects = self.ordersArray;
    //设置高度。
    [self.shoppcartview updateFrame:self.shoppcartview.OrderList];
    [self.shoppcartview.OrderList.tableView reloadData];
    //设置数量、价格
    self.shoppcartview.badgeValue =  [ViewModel CountOthersWithorderData:self.ordersArray];
    double price = [ViewModel GetTotalPrice:self.ordersArray];
    [self.shoppcartview setTotalMoney:price];
    //重新设置数据源
    self.dataArray = [ViewModel UpdateArray:self.dataArray atSelectDictionary:dic[@"update"]];
    [self.maintable reloadData];
    
}

/**
 *  抛物线小红点
 *
 *  @return
 */
- (UIImageView *)redView
{
    if (!_redView) {
        _redView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        _redView.image = [UIImage imageNamed:@"adddetail"];
        _redView.layer.cornerRadius = 10;
    }
    return _redView;
}
/**
 *  存放用户添加到购物车的商品数组
 *
 *  @return
 */
-(NSMutableArray *)ordersArray
{
    if (!_ordersArray) {
        _ordersArray = [NSMutableArray new];
    }
    return _ordersArray;
}
#pragma mark - 设置购物车动画
- (void)animationDidFinish
{
    
    [self.redView removeFromSuperview];
    [UIView animateWithDuration:0.1 animations:^{
        self.shoppcartview.shoppingCartBtn.transform = CGAffineTransformMakeScale(0.8, 0.8);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            self.shoppcartview.shoppingCartBtn.transform = CGAffineTransformMakeScale(1, 1);
        } completion:^(BOOL finished) {
            
        }];
        
    }];
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    if (!cell) {
        cell = [[MyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
      
    }
  
    __weak MyTableViewCell *c = cell;
    cell.call = ^(){
    
        c.lab.backgroundColor    = [UIColor grayColor];
        c.button.backgroundColor = [UIColor blackColor];
    
    };
    return cell;
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
