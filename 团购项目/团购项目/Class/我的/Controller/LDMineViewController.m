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
@interface LDMineViewController ()

@property(nonatomic,strong)LDMyMessageTableView *tableView;
@property(nonatomic,strong)LDMyMessageHeadView *headView;

@end

@implementation LDMineViewController

-(LDMyMessageHeadView *)headView{
    if (!_headView) {
        _headView=[[LDMyMessageHeadView alloc]init];
        
        __weak typeof(self) weakself=self;
        _headView.block=^(){
            LDRegisterViewController *vc=[[LDRegisterViewController alloc]init];
            [weakself.navigationController pushViewController:vc animated:YES];
        };
        
    }
    return _headView;
}


-(UITableView *)tableView{
    
    if (!_tableView) {
        _tableView=[[LDMyMessageTableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    }
    return _tableView;
}


- (void)viewDidLoad {
   
    [super viewDidLoad];
     self.view.backgroundColor=[UIColor whiteColor];
  
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.headView];
    [self addAutoLayout];
  

}


-(void)addAutoLayout{
    [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view) ;
        make.height.mas_equalTo(150);
    }];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(176);
        make.top.equalTo(self.headView.mas_bottom).offset(35);
    }];
    
    
}


@end
