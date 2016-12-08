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
#import "LDBuyCarEntity.h"
#import "LDBuycarListTableView.h"
#import "LDCheckoutView.h"//结算view
#import "LDEmptyCarView.h"
@interface LDBuyCarViewController ()


@property(nonatomic,strong)LDBuycarListTableView *buycarListTableView;
@property(nonatomic,strong)NSMutableArray *buycarEntityArray;
@property(nonatomic,strong)LDCheckoutView *checkoutView;
@property(nonatomic,strong)LDEmptyCarView *emptyCarView;
@end

@implementation LDBuyCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=RGBCOLOR(242, 242, 242);
    self.edgesForExtendedLayout = 0;
    [self createItems];
    [self.view addSubview:self.buycarListTableView];
    [self.view addSubview:self.checkoutView];
    [self.view addSubview:self.emptyCarView];
    [self addContrains];
 }

-(void)calculateBuyCount{
    
    NSInteger i=0;
    for (LDBuyCarEntity *buyCarEntity in self.buycarEntityArray) {
        if (buyCarEntity.isSelectButton) {
            i+= buyCarEntity.GoodsCount;
           // self.tabBarItem.badgeValue=[NSString stringWithFormat:@"%ld",i];//设置角标
            NSString *str=[NSString stringWithFormat:@"去结算(%ld)",i];
            [self.checkoutView.gotoCheckoutBtn setTitle:str forState:UIControlStateNormal];
            [self.checkoutView.gotoCheckoutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.checkoutView.gotoCheckoutBtn.backgroundColor=[UIColor redColor];
            
        }else{
            // self.tabBarItem.badgeValue=[NSString stringWithFormat:@"%ld",i];
            NSString *str=[NSString stringWithFormat:@"去结算(%ld)",i];
            [self.checkoutView.gotoCheckoutBtn setTitle:str forState:UIControlStateNormal];
            [self.checkoutView.gotoCheckoutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            if (i==0) {//当商品数量为0时，设置去结算按钮的背景色为灰色
                self.checkoutView.gotoCheckoutBtn.backgroundColor=[UIColor grayColor];
               // self.tabBarItem.badgeColor=[UIColor clearColor];
            }
            
        }

        
    }
    
    
}

-(LDEmptyCarView *)emptyCarView{
    if (!_emptyCarView) {
        _emptyCarView=[[LDEmptyCarView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WITH, SCREEN_HEIGHT)];
        [_emptyCarView.goShopBtn addTarget:self action:@selector(backGroundHighlighted:) forControlEvents:UIControlEventTouchDown];
        [_emptyCarView.goShopBtn addTarget:self action:@selector(backToHomePage) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _emptyCarView;
}


/**结算***/
-(LDCheckoutView *)checkoutView{
    if (!_checkoutView) {
        _checkoutView=[[LDCheckoutView alloc]init];
        [_checkoutView.selectAllBtn addTarget:self action:@selector(selectAllTheGoods:) forControlEvents:UIControlEventTouchUpInside];
    }
     return _checkoutView;
}

/***全选按钮方法***/
-(void)selectAllTheGoods:(UIButton *)sender{

    if (sender.selected) {
        sender.selected=NO;
        self.buycarListTableView.selectCount=0;//全选按钮没有选中时，选中按钮个数置为0；
        for (LDBuyCarEntity *buyCarEntity in self.buycarEntityArray) {
            [buyCarEntity setIsSelectButton:NO];
        }
        
    }else{
        sender.selected=YES;
        self.buycarListTableView.selectCount=self.buycarEntityArray.count;//全选按钮被选中时，选中按钮个数置为模型数组里元素个数；
        for (LDBuyCarEntity *buyCarEntity in self.buycarEntityArray) {
            [buyCarEntity setIsSelectButton:YES];
        }
    }
    [self.buycarListTableView reloadData];
    [self calculateBuyCount];
    [self calculateOrderPrice];
    
}

-(LDBuycarListTableView *)buycarListTableView{
    if (!_buycarListTableView) {
        _buycarListTableView=[[LDBuycarListTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WITH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        
        __weak typeof(self) weakself=self;
        _buycarListTableView.changeDataBlcok=^(){
           
            [weakself calculateOrderPrice];//计算商品总价格
            
        };
        
        _buycarListTableView.changeNumBlcok=^(){
            [weakself calculateBuyCount];//设置结算按钮上的购买数量
        };
        
        
        /***有任何一个按钮取消点击时，全选按钮变成未选中状态***/

        _buycarListTableView.selectAllBlcok=^(){
            
            weakself.checkoutView.selectAllBtn.selected=NO;
        };
        
                
        _buycarListTableView.selectBlcok=^(){
            [UIView animateWithDuration:0.5 animations:^{
                weakself.checkoutView.selectAllBtn.selected=YES;
                weakself.checkoutView.selectAllBtn.transform=CGAffineTransformMakeScale(1.4, 1.4);
            } completion:^(BOOL finished) {
                weakself.checkoutView.selectAllBtn.transform=CGAffineTransformMakeScale(1, 1);

                
            }];
            
        };
    }
    return _buycarListTableView;
}

/***计算价格****/
-(void)calculateOrderPrice{
    CGFloat price=0.0;
    for (LDBuyCarEntity *buyCarEntity in self.buycarEntityArray) {
        if (buyCarEntity.isSelectButton) {
            price +=buyCarEntity.Price*buyCarEntity.GoodsCount;
            
        }
    }
    NSString *str=@"合计:";
    NSMutableAttributedString *totalStr=[[NSMutableAttributedString alloc]initWithString:str attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];

    NSString *productPrice=[NSString stringWithFormat:@"￥%.2f",price];
    NSMutableAttributedString *priceStr =[[NSMutableAttributedString alloc]initWithString:productPrice attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor redColor]}];
    
    [totalStr insertAttributedString:priceStr atIndex:str.length];

    self.checkoutView.priceLabel.attributedText=totalStr;
    
}

/***nav rightButtonItem***/
-(void)createItems{
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editTableView:)];
    
    [rightItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
   
    self.navigationItem.rightBarButtonItem=rightItem;

}
-(void)editTableView:(UIBarButtonItem *)sender{
    
    self.buycarListTableView.editing=!self.buycarListTableView.editing;
    sender.title=self.buycarListTableView.isEditing ? @"完成":@"编辑";
   
}
/***请求购物车数据***/
-(void)requestBuyCarData{
   // http://123.57.141.249:8080/beautalk/appShopCart/appCartGoodsList.do
  
    NSDictionary *dic=[[NSUserDefaults standardUserDefaults]objectForKey:@"ISLOGIN"];
    
    if (dic.count>0) {
        [self getWithURLString:@"appShopCart/appCartGoodsList.do" parameters:@{@"MemberId":dic[@"MemberId"]} success:^(id responseObject) {
            self.buycarEntityArray=[LDBuyCarEntity mj_objectArrayWithKeyValuesArray:responseObject];
            
            if (self.buycarEntityArray.count>0) {//＞0时，显示购物车内容
               // LDDLog(@"buycarDataArray:%@",buycarDataArray);
                self.emptyCarView.hidden=YES;
                self.buycarListTableView.buycarListData=_buycarEntityArray;
                [self calculateOrderPrice];//请求完成时，就应该显示价格
                [self calculateBuyCount];//设置结算按钮上的购买数量
                
            }
        } failure:^(NSError *error) {
            
        }];
   
    }else{//没有登录时，则显示购物车空
        self.emptyCarView.hidden=NO;
        self.checkoutView.hidden=YES;
        self.buycarListTableView.hidden=YES;
        self.tabBarItem.badgeColor=[UIColor clearColor];
    }
    
   }

/***点击去逛逛按钮时，背景颜色高亮***/

-(void)backGroundHighlighted:(UIButton*)button{
    button.backgroundColor=RGBCOLOR(1, 14, 66);
}


/***设置颜色，点击时按钮颜色高亮，然后再回到页面上，恢复原始颜色。在viewWillAppear方法里恢复***/
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestBuyCarData];//请求购物车数据
    self.checkoutView.selectAllBtn.selected=NO;
    self.buycarListTableView.selectCount=0;
    
    self.emptyCarView.goShopBtn.backgroundColor=RGBCOLOR(18, 99, 177);
    self.emptyCarView.collectionBtn.backgroundColor=RGBCOLOR(18, 99, 177);
  
}


/***跳转至首页***/
-(void)backToHomePage{
   
    self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:0];

}

/***设置约束条件***/
-(void)addContrains{
    [_checkoutView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(55);
        make.bottom.equalTo(self.view.mas_bottom);
    }];

}

@end



