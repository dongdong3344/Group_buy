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
   
    [navBar setBackgroundImage:[UIImage imageNamed:@"nav_backImage"] forBarMetrics:UIBarMetricsDefault];
    [navBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16
                                                          ],NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
 
}
//重写方法，pushViewController隐藏tabbar
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count) { //避免一开始就隐藏了
        viewController.hidesBottomBarWhenPushed = YES;
        
        //设置左按钮样式
        UIButton *fanHuiButton = [UIButton buttonWithType:UIButtonTypeCustom];
        fanHuiButton.frame = CGRectMake(0, 0, 35, 35);
        [fanHuiButton setBackgroundImage:[UIImage imageNamed: @"backWhite_night" ]forState:UIControlStateNormal];
        [fanHuiButton addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
       viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:fanHuiButton];
        
    }
    
    [super pushViewController:viewController animated:animated];
}

-(void)popViewController{
    
    [self  popViewControllerAnimated:YES];
    
}

@end
