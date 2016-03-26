//
//  LXNavigationController.m
//  LXBaseFunction
//
//  Created by 李旭 on 16/3/25.
//  Copyright © 2016年 李旭. All rights reserved.
//

#import "LXNavigationController.h"

@interface LXNavigationController ()

@end

@implementation LXNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.translucent = NO;
    self.navigationBar.barTintColor = [UIColor blueColor];
}

+ (void)initialize
{
    [self setupNavigationBarTheme];
    [self setupBarButtonItemTheme];
}

+ (void)setupNavigationBarTheme
{
    UINavigationBar *appearance = [UINavigationBar appearance];
    [appearance setBackgroundImage:[UIImage imageNamed:@"my_topbg"] forBarMetrics:UIBarMetricsDefault];
    [appearance setShadowImage:[[UIImage alloc] init]];
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    textAttrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:18];
    [appearance setTitleTextAttributes:textAttrs];
}

+ (void)setupBarButtonItemTheme
{
    UIBarButtonItem *appearance = [UIBarButtonItem appearance];
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    [appearance setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
    disableTextAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [appearance setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
}

//能拦截所有push进来的子控制器
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 判断现在push的是不是栈底控制器(最先push进来的那个控制器)
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
//        // 设置导航栏按钮
        viewController.navigationItem.leftBarButtonItem = [LXCreateView itemWithImageName:@"s_point3" selectedImg:@"s_point3_sel" target:self action:@selector(back)];
        NSLog(@"%@", viewController.navigationItem.leftBarButtonItem);
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

@end




