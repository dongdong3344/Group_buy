//
//  LDNavController.m
//  团购项目
//
//  Created by Ringo on 2016/11/14.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import "LDNavController.h"

@interface LDNavController ()

@end

@implementation LDNavController
+(void)initialize{
    UINavigationBar *navBar=[UINavigationBar appearance];
   
    //[navBar setBackgroundImage:[UIImage imageNamed:@"nav_backImage"] forBarMetrics:UIBarMetricsDefault];
    navBar.barTintColor=RGBCOLOR(55, 158, 222);
    [navBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18
                                                          ],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
 
}
//重写方法，pushViewController隐藏tabbar
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count) { //避免一开始就隐藏了
        viewController.hidesBottomBarWhenPushed = YES;
       // viewController.navigationController.navigationBar.hidden=YES;
        
        //设置左按钮样式
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame = CGRectMake(0, 0, 25, 25);
        [backBtn setBackgroundImage:[UIImage imageNamed: @"common_btn_back_arrow" ]forState:UIControlStateNormal];
        [backBtn setBackgroundImage:[UIImage imageNamed: @"common_btn_back_pressed" ]forState:UIControlStateSelected];
        
        [backBtn addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
        //创建空格
        UIBarButtonItem * spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        //将宽度设为负值
        spaceItem.width = -15;
      UIBarButtonItem* leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        viewController.navigationItem.leftBarButtonItems=@[spaceItem,leftBarButtonItem];
    }
    
    [super pushViewController:viewController animated:animated];
}

-(void)popViewController{
    
    [self  popViewControllerAnimated:YES];
    
}

@end
