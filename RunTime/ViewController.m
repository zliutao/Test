//
//  ViewController.m
//  RunTime
//
//  Created by wujh on 16/4/19.
//  Copyright © 2016年 南京. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "Person+Other.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "UIControl+ZLTBlock.h"
#import "SuperViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,retain)UIImageView *imageView;
@property (nonatomic, strong) UICollectionView *xtCollectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) CALayer *dotLayer;
@property (nonatomic, assign) CGFloat endPoint_x;
@property (nonatomic, assign) CGFloat endPoint_y;
@property (nonatomic, strong) UIBezierPath *path;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) UILongPressGestureRecognizer *longPress;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self test1];
    
    Person *p = [[Person alloc] init];
    p.money = @"12123";
    
    UIImageView *vi = [[UIImageView alloc] initWithFrame:CGRectMake(20, 200, 300, 30)];
    vi.image = [UIImage imageNamed:@"矩形-1.png"];
    [self.view addSubview:vi];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(50, 50, 100, 101);
    [btn setImage:[UIImage imageNamed:@"椭圆-1.png"] forState:UIControlStateNormal];
  
    btn.callBack = ^(id sender){
    
    NSLog(@"%@",sender);
    
    };
   
    [self.view addSubview:btn];
    [self canCancelX];
   // a想做一件事却因为一些原因不能做，于是让啊遵循他的一些约定，然后帮他做一些事情。协议中包括需要实现的方法，
   // 以及啊能够做到的事情  iOS 代理，协议  选择代理，block声明的时候要用copy，
   // [self bubbleAnimation];
    
    UILabel *label12 = [[UILabel alloc] initWithFrame:CGRectMake(15, 50, 300, 300)];
    label12.text = @"离思五首\n元稹\n曾经沧海难为水,\n除却巫山不是云!\n取次花丛懒回顾,\n半缘修道半缘君!\n";
    
    label12.numberOfLines = 0;
    label12.backgroundColor = [UIColor colorWithRed:(arc4random()%173)/346.0 + 0.5 green:(arc4random()%173)/346.0 + 0.5  blue:(arc4random()%173)/346.0 + 0.5  alpha: 1];
    label12.font = [UIFont systemFontOfSize:30];
    label12.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label12];

    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 50, 300, 300)];
    self.imageView.image = [UIImage imageNamed:@"矩形-1.png"];
    [self.view addSubview:self.imageView];
    

    // UIActivityViewController *actVC = [UIActivityViewController alloc] initWithActivityItems:<#(nonnull NSArray *)#> applicationActivities:<#(nullable NSArray<__kindof UIActivity *> *)#>;
    
    CAReplicatorLayer *replication = [CAReplicatorLayer layer];
    replication.bounds  = CGRectMake(0, 0, 100, 100);
    replication.cornerRadius = 10;
    replication.position = self.view.center;
    replication.backgroundColor = [[UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.2] CGColor];
    [self.view.layer addSublayer:replication];
    
    CALayer *dotLay  = [CALayer layer];
    dotLay.bounds = CGRectMake(0, 0, 15, 15);
    dotLay.position = CGPointMake(15, replication.frame.size.height/2);
    dotLay.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.6].CGColor;
    dotLay.cornerRadius    = 7.5;
    
    [replication addSublayer:dotLay];
    
    // replication.instanceCount = 3;
    // replication.instanceTransform = CATransform3DMakeTranslation(replication.frame.size.width/3, 0, 0);
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration    = 1.0;
    animation.fromValue   = @1;
    animation.toValue     = @0;
    animation.repeatCount = MAXFLOAT;
    [dotLay addAnimation:animation forKey:nil];
    
    replication.instanceDelay = 1.0/10;
    
    CGFloat count = 10.0;
    replication.instanceCount = count;
    CGFloat angel = 2* M_PI/count;
    replication.instanceTransform = CATransform3DMakeRotation(angel, 0, 0, 1);
    dotLay.transform = CATransform3DMakeScale(0, 0, 0);
    
    
 }

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
   return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
   // NSString *identifier = @"collectionview";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionview" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UICollectionViewCell alloc] init];
    }
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    lab.text = @"collectionView";
    lab.font = [UIFont systemFontOfSize:10];
    [cell addSubview:lab];
    
    UIImageView *ima = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, 80, 40)];
    ima.image = [UIImage imageNamed:@"椭圆-1.png"];
    [cell addSubview:ima];

    float a;
    __weak ViewController *vc = self;
    self.cityBlock(a);
    return cell;

}

+(void)aop_changeMethod:(SEL)oldMethod newMethod:(SEL)newMethod
{
    //系统的方法
    Method oldM  = class_getInstanceMethod([self class], oldMethod);
    //自己定义与系统方法去交换的方法
    Method newM  = class_getInstanceMethod([self class], newMethod);
    //交换方法
    method_exchangeImplementations(oldM, newM);
}

+(void)aop_changeMethod1:(SEL)oldMethod newMethod:(SEL)newMethod
{
    //系统的方法
    Method oldM  = class_getInstanceMethod([self class], oldMethod);
    //自己定义与系统方法去交换的方法
    Method newM  = class_getInstanceMethod([self class], newMethod);
    //交换方法
    method_exchangeImplementations(oldM, newM);
}
+(void)aop_changeMethod2:(SEL)oldMethod newMethod:(SEL)newMethod
{
    //系统的方法与交换的方法  这个月线上交换
    Method oldM  = class_getInstanceMethod([self class], oldMethod);
    //自己定义与系统方法去交换的方法
    Method newM = class_getInstanceMethod([self class], newMethod);
    //交换方法
   
    method_exchangeImplementations(oldM, newM);
}
+(void)aop_changeMethod3:(SEL)oldMethod newMethod:(SEL)newMethod
{
    //系统的方法
    Method oldM  = class_getInstanceMethod([self class], oldMethod);
    //自己定义与系统方法去交换的方法
    Method newM = class_getInstanceMethod([self class], newMethod);
    //交换方法  oc方法交换
    method_exchangeImplementations(oldM, newM);
}
+(void)aop_changeMethod4:(SEL)oldMethod newMethod:(SEL)newMethod
{
    //系统的方法
    Method oldM  = class_getInstanceMethod([self class], oldMethod);
    //自己定义与系统方法去交换的方法
    Method newM = class_getInstanceMethod([self class], newMethod);
    //交换方法
    method_exchangeImplementations(oldM, newM);
}
+(void)aop_changeMethod5:(SEL)oldMethod newMethod:(SEL)newMethod
{
    //系统的方法
    Method oldM  = class_getInstanceMethod([self class], oldMethod);
    //自己定义与系统方法去交换的方法
    Method newM = class_getInstanceMethod([self class], newMethod);
    //交换方法
    method_exchangeImplementations(oldM, newM);
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //触摸任意位置
    UITouch *touch = touches.anyObject;
    //触摸位置在图片上的图标
    CGPoint cententPoint = [touch locationInView:self.imageView];
    //设置清除点的大小,iOS，
    CGRect rect  = CGRectMake(cententPoint.x, cententPoint.y, 20, 20);
    //获取上下文文本
    CGContextRef ref = UIGraphicsGetCurrentContext();
    //将imageview的layer映射到上下文文本中
    [self.imageView.layer renderInContext:ref];
    //清除划过的区域
    CGContextClearRect(ref, rect);
    //获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //结束图片的画板，（以为着图片在上下文中消失）
    UIGraphicsEndImageContext();
    //设置
    self.imageView.image = image;

  
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(20, 202, 50, 200);
    btn.backgroundColor = [UIColor redColor];
    btn.tintAdjustmentMode = NSTextAlignmentCenter;
    btn.alpha = 0.1;
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
- (void)bubbleAnimation{

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 200, 200);
    btn.layer.cornerRadius = 100;
    btn.backgroundColor = [UIColor cyanColor];
    [btn addTarget:self action:@selector(bubbleAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
- (void)bubbleAction:(UIButton *)button{

    button.transform = CGAffineTransformMakeScale(0.6, 0.6);
    [UIView animateWithDuration:10 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:0.3 options:0 animations:^{
        
      button.transform = CGAffineTransformMakeScale(1, 1);
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)canCancelX{
    CAEmitterLayer *snowEmitter = [CAEmitterLayer layer];
    //降落区域的方位
    snowEmitter.frame = self.view.bounds;
    //添加到父视图Layer上
    [self.view.layer addSublayer:snowEmitter];
    //指定发射源的位置
    snowEmitter.emitterPosition = CGPointMake(self.view.bounds.size.width / 2.0, -10);
    //指定发射源的大小
    snowEmitter.emitterSize  = CGSizeMake(self.view.bounds.size.width, 0.0);
    //指定发射源的形状和模式
    snowEmitter.emitterShape = kCAEmitterLayerLine;
    snowEmitter.emitterMode  = kCAEmitterLayerOutline;
    //创建CAEmitterCell
    CAEmitterCell *snowflake = [CAEmitterCell emitterCell];
    //每秒多少个
    snowflake.birthRate = 3.0;
    //存活时间
    snowflake.lifetime = 50.0;
    //初速度，因为动画属于落体效果，所以我们只需要设置它在y方向上的加速度就行了。
    snowflake.velocity = 10;
    //初速度范围
    snowflake.velocityRange = 5;
    //y轴方向的加速度
    snowflake.yAcceleration = 30;
    //以锥形分布开的发射角度。角度用弧度制。粒子均匀分布在这个锥形范围内。
    snowflake.emissionRange = 4;
    //设置降落的图片
    snowflake.contents  = (id) [[UIImage imageNamed:@"椭圆-1"] CGImage];
    //图片缩放比例
    snowflake.scale = 0.5;
    //开始动画
    snowEmitter.emitterCells = [NSArray arrayWithObject:snowflake];


}

- (void)test1{

    unsigned int count;

    Ivar *ivars = class_copyIvarList([Person class], &count);
    for (int i = 0; i<count; i++) {
        Ivar ivar = ivars[i];
        const char*name = ivar_getName(ivar);
        NSString *key = [NSString stringWithUTF8String:name];
        NSLog(@"%@",key);
    }
    free(ivars);

    Ivar *ivars1 = class_copyIvarList([self class], &count);
    for (int i = 0; i<count; i++) {
        const char*name = ivar_getName(ivars1[i]);
        NSString *na = [NSString stringWithUTF8String:name];
        NSLog(@"------%@",na);
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(20, 20, 200, 200);
        btn.backgroundColor = [UIColor redColor];
        btn.layer.cornerRadius = 100;
        btn.selected = YES;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        btn.tag = 1000;
        
    }
}

- (void)btnClick:(UIButton*)sender{


}

- (void)test2{
    unsigned int count;
    objc_property_t *propertys = class_copyPropertyList([Person class], &count);
    for (int i = 0; i<count; i++) {
        objc_property_t property = propertys[i];
        const char* name = property_getName(property);
        NSString *key = [NSString stringWithUTF8String:name];
        NSLog(@"属性名%@",key);
        
    }
    free(propertys);
   //ios 运行时机制交换两个方法的实现，架构的时候一般都有这个方法
    unsigned int count1;
    objc_property_t *pror = class_copyPropertyList([self class], &count1);
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:count1];
    for (int i = 0; i<arr.count; i++) {
        const char *propertyName = property_getName(pror[i]);
        NSString *nam = [NSString stringWithUTF8String:propertyName];
        [arr addObject:nam];
    }
    free(pror);

}

- (void)test3{

    unsigned int count;
    Method *methods = class_copyMethodList([Person class], &count);
    for (int i = 0; i<count; i++) {
        Method method = methods[i];
        SEL methodsel = method_getName(method);
        const char *name = sel_getName(methodsel);
        NSString *key = [NSString stringWithUTF8String:name];
        int arguments = method_getNumberOfArguments(method);
        NSLog(@"%d%@",arguments,key);
    }

    free(methods);

}
- (void)test4{

    unsigned int count;
    Ivar *ivas =class_copyIvarList([self class], &count);
    for (int i = 0; i<count; i++) {
        Ivar ivar = ivas[i];
        const char *name = ivar_getName(ivar);
        
    }


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
