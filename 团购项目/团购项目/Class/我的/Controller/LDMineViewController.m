//
//  LDMineViewController.m
//  团购项目
//
//  Created by Ringo on 2016/11/14.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import "LDMineViewController.h"
#import "LDMyMessageTableView.h"
#import "LDMyMessageHeadView.h"
#import "LDRegisterViewController.h"
#import "LDLoginViewController.h"
#import "LDSheetViewController.h"

#import "AppDelegate.h"
@interface LDMineViewController ()<UIActionSheetDelegate>

@property(nonatomic,strong)LDMyMessageTableView *tableView;
@property(nonatomic,strong)LDMyMessageHeadView *headView;

@end

@implementation LDMineViewController



-(LDMyMessageHeadView *)headView{
    if (!_headView) {
        _headView=[[LDMyMessageHeadView alloc]init];
        
        __weak typeof(self) weakself=self;
        _headView.block=^(){
           LDLoginViewController *vc=[[LDLoginViewController alloc]init];
            [weakself.navigationController pushViewController:vc animated:YES];
        };
        
    }
    return _headView;
}




-(UITableView *)tableView{
    
    if (!_tableView) {
        _tableView=[[LDMyMessageTableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];

        __block typeof(self) weakself=self;
        _tableView.exitBlcok=^(){
          
            [weakself logout];
        };
        
    }
    return _tableView;
}



-(void)logout{
   
    LDSheetViewController *sheetVC=[[LDSheetViewController alloc]init];
    sheetVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;//OverCurrentContext
    
    //以下几个代码目的是为了隐藏tabbar
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    appdelegate.window.rootViewController.definesPresentationContext = YES;
    [appdelegate.window.rootViewController presentViewController:sheetVC animated:YES completion:nil];
    

    
//    UIAlertController *alertVC=[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
// 
//    
//    UIAlertAction *quitAction=[UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        
//        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"ISLOGIN"];//删除登录状态
//
//        
//    }];
//    [quitAction setValue:[UIColor redColor] forKey:@"_titleTextColor"];
//
//    [alertVC addAction:quitAction];
//    
//    
//    UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        
//        [self dismissViewControllerAnimated:alertVC completion:nil];
//        
//    }];
  //  [cancelAction setValue:RGBCOLOR(188, 188, 188) forKey:@"_titleTextColor"];

    
//    [alertVC addAction:cancelAction];
//    
//    
//    
//    [self  presentViewController:alertVC animated:YES completion:nil];
// 
    
}



- (void)viewDidLoad {
   
    [super viewDidLoad];
     self.view.backgroundColor=[UIColor whiteColor];
    self.view.backgroundColor=RGBCOLOR(242, 242, 242);

    [self.view addSubview:self.headView];
    [self.view addSubview:self.tableView];
    [self setupConstraints];
    
   }

//隐藏navigaitonbar
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.tableView reloadData];//刷新数据表格
}

-(void)setupConstraints{
    [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view) ;
        make.height.mas_equalTo(171);
    }];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(320);
        make.top.equalTo(self.headView.mas_bottom).offset(20);
    }];
    
    
}


@end
