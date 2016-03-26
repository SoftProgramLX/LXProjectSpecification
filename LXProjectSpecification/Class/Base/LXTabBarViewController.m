//
//  LXTabBarViewController.m
//  LXBaseFunction
//
//  Created by 李旭 on 16/3/25.
//  Copyright © 2016年 李旭. All rights reserved.
//

#import "LXTabBarViewController.h"
#import "LXTestViewController.h"

@interface LXTabBarViewController ()

@end

@implementation LXTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = bgColor;
    
    LXTestViewController *testVC = [[LXTestViewController alloc] init];
    [self addOneChlildVc:testVC title:@"test1" navigationTitle:@"test1" imageName:nil selectedImageName:nil];
    
    [self addOneChlildVc:[[UIViewController alloc] init] title:@"test2" navigationTitle:@"test2" imageName:nil selectedImageName:nil];
    [self addOneChlildVc:[[UIViewController alloc] init] title:@"test3" navigationTitle:@"test3" imageName:nil selectedImageName:nil];
    
//    self.tabBar.backgroundImage = [UIImage imageNamed:@""];
    self.tabBar.translucent = NO;
}

- (void)addOneChlildVc:(UIViewController *)childVc title:(NSString *)title navigationTitle:(NSString *)navTitle imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    childVc.title = title;
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[NSForegroundColorAttributeName] = globalRedWordColor;
    [childVc.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    
    childVc.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = selectedImage;
    
    LXNavigationController *nav = [[LXNavigationController alloc] initWithRootViewController:childVc];
    nav.navigationItem.title = navTitle;
    
    [self addChildViewController:nav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
