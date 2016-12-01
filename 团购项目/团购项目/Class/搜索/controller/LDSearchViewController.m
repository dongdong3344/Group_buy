//
//  LDSearchViewController.m
//  团购项目
//
//  Created by Ringo on 2016/12/1.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import "LDSearchViewController.h"

@interface LDSearchViewController ()<UISearchBarDelegate>

@end

@implementation LDSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self addSearchBar];
    
}



-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem=leftItem;
}

-(void)addSearchBar{
    UISearchBar *searchBar=[[UISearchBar alloc]init];
    self.navigationItem.titleView=searchBar;
    searchBar.showsCancelButton=YES;
    searchBar.placeholder=@"请输入搜索关键字";
    [searchBar becomeFirstResponder];
    searchBar.delegate=self;
    
    //找到取消按钮
    
    UIButton *cancleBtn = [searchBar valueForKey:@"cancelButton"];
    
    //修改标题和标题颜色
    
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    
    [cancleBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
}

//取消按钮代理方法
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
