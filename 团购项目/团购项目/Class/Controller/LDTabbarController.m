//
//  LDTabbarController.m
//  团购项目
//
//  Created by Ringo on 2016/11/14.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import "LDTabbarController.h"
#import "LDNavController.h"

@interface LDTabbarController ()

@end

@implementation LDTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViewcontrollers];
    
}
-(void)setupViewcontrollers{
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:56/255.0 green:165/255.0 blue:241/255.0 alpha:1]} forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:132/255.0 green:132/255.0 blue:132/255.0 alpha:1]} forState:UIControlStateNormal];
    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbar_back"]];
    
    NSMutableArray *controllersArry=[NSMutableArray arrayWithArray:@ [@"LDTimeViewController",@"LDClassViewController",@"LDBuyCarViewController",@"LDMineViewController"]];
    NSArray *images=@[@"菜单栏限时特卖按钮未选中状态",@"菜单栏分类按钮未选中状态",@"菜单栏购物车按钮未选中状态",@"菜单栏我的按钮未选中状态"];
     NSArray *selectedImage=@[@"菜单栏限时特卖按钮选中状态",@"菜单栏分类按钮选中状态",@"菜单栏购物车按钮选中状态",@"菜单栏我的按钮选中状态"];
    NSArray *titles=@[@"限时购",@"分类",@"购物车",@"我的"];
    for (NSInteger i=0; i<controllersArry.count; i++) {
        NSString *controllerName=controllersArry[i];
        UIViewController *vc=[[NSClassFromString(controllerName) alloc]init];
        vc.title=titles[i];
//        vc.view.backgroundColor=RGBCOLOR(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255));
        [vc.tabBarItem setImage:[UIImage imageNamed:images[i]]];
        [vc.tabBarItem setSelectedImage:[UIImage imageNamed:selectedImage[i]]];
        LDNavController *nav=[[LDNavController alloc]initWithRootViewController:vc];
        [controllersArry replaceObjectAtIndex:i withObject:nav];
    }
    self.viewControllers=controllersArry;
    
}

@end
