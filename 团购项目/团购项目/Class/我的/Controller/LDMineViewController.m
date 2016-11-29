//
//  LDMineViewController.m
//  团购项目
//
//  Created by Ringo on 2016/11/14.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import "LDMineViewController.h"

#import "LDRegisterViewController.h"
#import "LDLoginViewController.h"
#import "LDSheetViewController.h"
#import "AppDelegate.h"
@interface LDMineViewController ()<UIActionSheetDelegate>
@property(nonatomic,strong)LDMyMessageTableView *tableView;
@property(nonatomic,strong)LDMyMessageHeadView *headView;
@end

@implementation LDMineViewController


// @selector方法， 即受到通知之后的事件
- (void)receiveNotification{
    
    // NSNotification 有三个属性，name, object, userInfo，其中最关键的object就是从第三个界面传来的数据。name就是通知事件的名字， userInfo一般是事件的信息。
    [self.tableView reloadData];
    [self.headView reloadHeadView];
    
}




-(LDMyMessageHeadView *)headView{
    if (!_headView) {
        _headView=[[LDMyMessageHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WITH, 171)];
        
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
        _tableView=[[LDMyMessageTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WITH, SCREEN_HEIGHT) style:UITableViewStylePlain];

        __block typeof(self) weakself=self;
        _tableView.exitBlcok=^(){
          
            [weakself logout];
        };
        _tableView.tableHeaderView=self.headView;
        
    }
    return _tableView;
}


-(void)logout{
   
    LDSheetViewController *sheetVC=[[LDSheetViewController alloc]init];
    sheetVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;//OverCurrentContext
    sheetVC.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
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
    
//    [self  presentViewController:alertVC animated:YES completion:nil];
// 
    
}


- (void)viewDidLoad {
   
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;//可以让tabview覆盖在状态栏下（不是在状态栏顶部下20像素）
    [self.view addSubview:self.headView];
    [self.view addSubview:self.tableView];
   

    
    NSNotificationCenter *notiCenter = [NSNotificationCenter defaultCenter];
    
    // 注册一个监听事件。第三个参数的事件名， 系统用这个参数来区别不同事件。
    [notiCenter addObserver:self selector:@selector(receiveNotification) name:@"reloadData" object:nil];
    
   }


//下拉logo设置
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // taleview的子视图中,有一张弹簧似的View,这张view在tableView的正常状态下的高度为0,然后随着tableView的滑动，该View会随着tableview的滑动而变高，其底部永远紧贴tableView的顶部.我们应该遇到过这种现象，当我们把 tablview的背景色设置为白色时，往下滑tableView，我们会发现最顶端tableView的背景色为灰白色，这灰白色的View就是这张具有弹簧效果的view
    
    UIView *springview = self.tableView.subviews.firstObject;
    [springview insertSubview:self.tableView.topLogoImageView atIndex:0];
    
    [self.tableView.topLogoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 30));
        make.centerX.mas_equalTo(self.tableView.topLogoImageView.superview);
        // 必须设置底部约束
        make.bottom.mas_equalTo(self.tableView.topLogoImageView.superview).offset(-30);
    }];
}




//隐藏navigaitonbar
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.tableView reloadData];//刷新数据表格
    [self.headView reloadHeadView];
    
    //设置欢迎信息富文本
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    NSString *phoneStr=[user objectForKey:@"phone"];
    NSString  *str=[NSString stringWithFormat:@"欢迎你,%@",phoneStr];
    NSMutableAttributedString *welcomeStr = [[NSMutableAttributedString alloc] initWithString:str];
    [welcomeStr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, 4)];
    //[welcomeStr addAttribute:NSForegroundColorAttributeName value:RGBCOLOR(56, 166, 243)range:NSMakeRange(4, 11)];
    self.headView.welcomeLabel.attributedText=welcomeStr;
//    NSLog(@"电话号码:%@",phoneStr);
    
    //self.headView.welcomeLabel.text=str;
}






- (void)dealloc
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self]; // 移除当前对象监听的事件
    
    
}

@end
