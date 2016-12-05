//
//  LDBottomBtnView.m
//  团购项目
//
//  Created by Ringo on 2016/11/30.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import "LDBottomBtnView.h"

@interface LDBottomBtnView ()
@property(nonatomic,strong)UIButton *buyBtn,*addToBuyCarBtn;//购物车按钮，立即购买按钮，添加到购物车按钮
@property(assign,nonatomic)NSInteger clicks;


@end

@implementation LDBottomBtnView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=RGBCOLOR(239, 239, 239);
      
        [self addSubview:self.buyBtn];
        [self addSubview:self.buyCarBtn];
        [self addSubview:self.addToBuyCarBtn];
    }
    return self;
}


-(UIButton *)addToBuyCarBtn{
    if (!_addToBuyCarBtn) {
        _addToBuyCarBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _addToBuyCarBtn.backgroundColor=[UIColor blueColor];
        
        [_addToBuyCarBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
        _addToBuyCarBtn.titleLabel.font=[UIFont boldSystemFontOfSize:16];
        [_addToBuyCarBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        _addToBuyCarBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
        [_addToBuyCarBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_addToBuyCarBtn addTarget:self action:@selector(addToBuyCar) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addToBuyCarBtn;
}


/***点击加入购物车按钮方法***/
-(void)addToBuyCar{
    JSBadgeView  *badgeView=[[JSBadgeView alloc]initWithParentView:self.buyCarBtn alignment:JSBadgeViewAlignmentTopRight];
    
    //1、背景色
    badgeView.badgeBackgroundColor = [UIColor redColor];
    //2、没有反光面
    badgeView.badgeOverlayColor = [UIColor clearColor];
    //3、外圈的颜色，默认是白色
    badgeView.badgeStrokeColor = [UIColor clearColor];
    
   
    
    /*****设置数字****/
    //1、用字符
    badgeView.badgeText =[NSString stringWithFormat:@"%ld",(long)(self.clicks+1)];
    
    self.clicks++;
    
    //2、如果不显示就设置为空
   // badgeView.badgeText = nil;x
    
    //当更新数字时，最好刷新，不然由于frame固定的，数字为2位时，红圈变形
    [badgeView setNeedsLayout];
    
    
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:badgeView.badgeText forKey:@"badgeText"];
    
    [userDefaults synchronize];
    
     self.badgeView=badgeView;
    
    
   // LDDLog(@"数字是：%@",self.badgeView.badgeText);
    
}


-(UIButton *)buyBtn{
    if (!_buyBtn) {
        _buyBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _buyBtn.backgroundColor=RGBCOLOR(199, 0, 0);
        [_buyBtn setTitle:@"立即购买" forState:UIControlStateNormal];
        [_buyBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        _buyBtn.titleLabel.font=[UIFont boldSystemFontOfSize:16];
        _buyBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
        [_buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    }
    return _buyBtn;
}

-(UIButton *)buyCarBtn{
    if (!_buyCarBtn) {
        _buyCarBtn=[UIButton buttonWithType: UIButtonTypeCustom];
        [_buyCarBtn setImage:[UIImage imageNamed:@"shoppingcar"] forState:UIControlStateNormal];
    }
    return _buyCarBtn;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    [_buyCarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.size.mas_equalTo(CGSizeMake(26, 26));
        make.centerY.equalTo(self.mas_centerY);//Y方向居中
        
    }];
    
    [_addToBuyCarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(45);
        make.centerY.equalTo(self.mas_centerY);//Y方向居中
        make.left.equalTo(self.buyCarBtn.mas_right).offset(35);
        make.right.equalTo(self.buyBtn.mas_left).offset(-5);
    }];
    
    [_buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(45);
        make.centerY.equalTo(self.mas_centerY);//Y方向居中
        make.width.equalTo(self.addToBuyCarBtn.mas_width);
        make.right.equalTo(self.mas_right);
    }];
    
}



@end
