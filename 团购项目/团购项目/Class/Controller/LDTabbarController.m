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
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:RGBCOLOR(7, 123, 251)} forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:RGBCOLOR(132, 132, 132)} forState:UIControlStateNormal];
    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbar_back"]];
    
    NSMutableArray *controllersArry=[NSMutableArray arrayWithArray:@ [@"LDTimeViewController",@"LDClassViewController",@"LDBuyCarViewController",@"LDMineViewController"]];
    NSArray *images=@[@"home_xianshigou_btn_normal",@"home_class_btn_normal",@"home_buycar_btn_normal",@"home_personal_btn_normal"];
     NSArray *selectedImage=@[@"home_xianshigou_btn_selected",@"home_class_btn_selected",@"home_buycar_btn_selected",@"home_personal_btn_highlighted"];
    NSArray *titles=@[@"限时购",@"分类",@"购物车",@"我"];
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
