//
//  LDSearchViewController.m
//  团购项目
//
//  Created by Ringo on 2016/12/1.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import "LDSearchViewController.h"
#import "LDGoodsListViewController.h"
#import "LDGoodsListEntity.h"
@interface LDSearchViewController ()<UISearchBarDelegate>
@property(nonatomic,strong)UISearchBar *searchBar;
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
    //self.searchBar.text=@"";
    [self.searchBar becomeFirstResponder];
}

-(void)addSearchBar{
    UISearchBar *searchBar=[[UISearchBar alloc]init];
    self.navigationItem.titleView=searchBar;
    searchBar.showsCancelButton=YES;
    searchBar.placeholder=@"请输入搜索关键字";
    [searchBar becomeFirstResponder];
    searchBar.delegate=self;
    self.searchBar=searchBar;
    
    //找到取消按钮
    
    UIButton *cancleBtn = [searchBar valueForKey:@"cancelButton"];
    
    //修改标题和标题颜色
    
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    
    [cancleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
}

//取消按钮代理方法
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
   
    
    [self postWithURLString:@"appSearch/searchList.do" parameters:@{@"search":searchBar.text,@"OrderName":@"host",@"OrderType":@"Desc"} success:^(id responseObject) {
       
        NSArray *goodsListArry=[LDGoodsListEntity mj_objectArrayWithKeyValuesArray:responseObject];//取得模型数组
         LDDLog(@"goodsListArry: %@",goodsListArry);
        /***网络请求成功后再跳转***/
        LDGoodsListViewController *goodsListVC=[[LDGoodsListViewController alloc]init];
        goodsListVC.title=searchBar.text;//标题是search搜索框内的文字
        goodsListVC.goodsListEntityArray=goodsListArry;
        [searchBar resignFirstResponder];//防止页面闪2次
        [self.navigationController pushViewController:goodsListVC animated:YES];
        //[NSThread sleepForTimeInterval:1];

        if (goodsListArry.count==0) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [goodsListVC.view makeToast:@"抱歉，目前库内无此商品!" duration:1.5 position:@"CSToastPositionCenter"];

            });
       
//            UIAlertController *alterVC=[UIAlertController alertControllerWithTitle:nil message:@"抱歉，目前库内无此商品" preferredStyle:UIAlertControllerStyleAlert];
//            UIAlertAction *acttion=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
//            [goodsListVC presentViewController:alterVC animated:YES completion:nil];
        }
    } failure:^(NSError *error) {
        
    }];
}
@end
