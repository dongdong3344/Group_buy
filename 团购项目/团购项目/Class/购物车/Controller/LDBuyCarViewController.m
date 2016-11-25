//
//  LDBuyCarViewController.m
//  团购项目
//
//  Created by Ringo on 2016/11/14.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import "LDBuyCarViewController.h"
#import "LDHomeViewController.h"
#import "LDNavController.h"
#import "AppDelegate.h"
@interface LDBuyCarViewController ()

@property(nonatomic,strong)UIImageView *buycarView;
@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)UIButton *goShopBtn,* collectionBtn;

@end

@implementation LDBuyCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // self.view.backgroundColor=RGBCOLOR(242, 242, 242);
     self.edgesForExtendedLayout = 0;
    [self.view addSubview:self.buycarView];
    [self.view addSubview:self.label];
    [self.view addSubview:self.goShopBtn];
    [self.view addSubview:self.collectionBtn];
    [self setupContrains];
    
   }


-(UIImageView *)buycarView{
    if (!_buycarView) {
        _buycarView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cart01"]];
    }
    return _buycarView;
}

-(UILabel *)label{
    if (!_label) {
        _label=[[UILabel alloc]init];
        _label.text=@"您的购物车中没有商品";
        _label.font=[UIFont systemFontOfSize:16];
        _label.textColor=RGBCOLOR(85, 85, 85);
        _label.textAlignment=NSTextAlignmentCenter;
    }
    return _label;
}


-(UIButton *)goShopBtn{
    if (!_goShopBtn) {
        _goShopBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_goShopBtn setTitle:@"去逛逛" forState:UIControlStateNormal];
        _goShopBtn.backgroundColor=RGBCOLOR(18, 99, 177);
        _goShopBtn.titleLabel.font=[UIFont boldSystemFontOfSize:16];
        [_goShopBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _goShopBtn.layer.cornerRadius=5;
        [_goShopBtn addTarget:self action:@selector(backToHomePage) forControlEvents:UIControlEventTouchUpInside];
    }
    return _goShopBtn;
}


-(UIButton *)collectionBtn{
    if (!_collectionBtn) {
        _collectionBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_collectionBtn setTitle:@"看收藏" forState:UIControlStateNormal];
        _collectionBtn.titleLabel.font=[UIFont boldSystemFontOfSize:16];
        _collectionBtn.backgroundColor=RGBCOLOR(18, 99, 177);

        [_collectionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _collectionBtn.layer.cornerRadius=5;
    }
    return _collectionBtn;
}

-(void)backToHomePage{
   
    self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:0];


}

-(void)setupContrains{
    
    [_buycarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(179, 155));
        make.top.equalTo(self.view.mas_top).offset(20);
        make.centerX.equalTo(self.view.mas_centerX);
        
    }];
    
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(180, 16));
        make.top.equalTo(self.buycarView.mas_bottom).offset(20);
        make.centerX.equalTo(self.view.mas_centerX);

    }];
    
    [_goShopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-50);
        make.left.equalTo(self.view.mas_left).offset(50);
        make.top.equalTo(self.buycarView.mas_bottom).offset(80);
        make.height.equalTo(@35);
    }];

    
    [_collectionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-50);
        make.left.equalTo(self.view.mas_left).offset(50);
        make.top.equalTo(self.goShopBtn.mas_bottom).offset(25);
        make.height.equalTo(@35);
    }];

    
}




@end



