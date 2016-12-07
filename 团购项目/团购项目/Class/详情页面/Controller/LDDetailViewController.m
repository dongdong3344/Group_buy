//
//  LDDetailViewController.m
//  团购项目
//
//  Created by Ringo on 2016/11/28.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import "LDDetailViewController.h"
#import "LDCycleImgView.h"
#import "LDImageEntity.h"
#import "LDTitleLabelView.h"
#import "LDTitleEntity.h"
#import "LDDetailsContentEntity.h"
#import "LDDetailsContentView.h"
#import "LDImageView.h"
#import "LDBottomBtnView.h"
#import "LDMineViewController.h"

@interface LDDetailViewController ()
@property(nonatomic,strong)UIScrollView *mainScrollView;
@property(nonatomic,strong)LDCycleImgView *cycleView;
@property(nonatomic,strong)LDTitleLabelView *titleLabelView;
@property(nonatomic,strong)LDDetailsContentView *detailsContentView;
@property(nonatomic,strong)LDImageView *bottomImageView;
@property(nonatomic,assign)CGFloat mainScrollviewContentHeight;
@property(nonatomic,strong)LDBottomBtnView *buttonView;

@end


@implementation LDDetailViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.mainScrollviewContentHeight=380;//轮播图高度
    //self.edgesForExtendedLayout = 0;
    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
    [self.view addSubview:self.mainScrollView];
    [self.mainScrollView addSubview:self.cycleView];
    [self.mainScrollView addSubview:self.titleLabelView];
    [self.mainScrollView addSubview:self.detailsContentView];
    [self.mainScrollView addSubview:self.bottomImageView];
    [self.view addSubview:self.buttonView];
    [self getCycleImages];
    [self getTitleData];
    [self getDetailsContent];
    [self addConstraint];
  

}

/***set方法，设置mainScrollView滑动高度***/
-(void)setMainScrollviewContentHeight:(CGFloat)mainScrollviewContentHeight{
    
    _mainScrollviewContentHeight=mainScrollviewContentHeight;
    self.mainScrollView.contentSize=CGSizeMake(0,self.mainScrollviewContentHeight);
}

/***底部的3个按钮试图***/
-(LDBottomBtnView *)buttonView{
    if (!_buttonView) {
        _buttonView=[[LDBottomBtnView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-45-64, SCREEN_WITH, 45)];
        [_buttonView.buyCarBtn addTarget:self action:@selector(changeToBuyVC) forControlEvents:UIControlEventTouchUpInside];
        __weak typeof(self) weakself=self;
        _buttonView.addGoodsTobuyCarBlock=^(){
          
              [weakself insertGoodsIntoBuyCar];
            
        };
    }
    return _buttonView;
}

/***加入购物车***/
-(void)insertGoodsIntoBuyCar{
    /*
     URL：http://123.57.141.249:8080/beautalk/appShopCart/insert.do
     传入数据：
     参数标记：
     会员登录名 ：MemberId
     美食ID ： GoodsId
     */
    NSDictionary *dic=[[NSUserDefaults standardUserDefaults]objectForKey:@"ISLOGIN"];
    if (dic.count>0) {
        [self getWithURLString:@"appShopCart/insert.do" parameters:@{@"MemberId":dic[@"MemberId"],@"GoodsId":self.detailGoodsID} success:^(id responseObject) {
            if ([responseObject[@"result"] isEqualToString:@"success"]) {
                [self showTostMessage:@"添加购物车成功!"];
            }else{
                [self showTostMessage:@"添加购物车失败!"];
                
            }
            //LDDLog(@"responseObject:%@",responseObject);
        } failure:^(NSError *error) {
            
        }];
        
    }else{
        //跳转至登录界面
       
        [self showTostMessage:@"添加购物车前，请先登录……"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             self.tabBarController.selectedIndex=3;
        });
       
        
    }
   
}

/***点击购物车按钮，跳转至购物车页面***/
-(void)changeToBuyVC{
    
    self.tabBarController.selectedIndex=2;
    
}

/***试图底部的几张详情图片***/
-(LDImageView *)bottomImageView{
    if (!_bottomImageView) {
        _bottomImageView=[[LDImageView alloc]init];

        __weak typeof(self) weakself=self;
        _bottomImageView.imageViewBlock=^(CGFloat height){
           [weakself.bottomImageView mas_makeConstraints:^(MASConstraintMaker *make) {
               make.height.mas_equalTo(height);
           }];
            weakself.mainScrollviewContentHeight +=height;
    
        };
        
    }
    return _bottomImageView;
}

/***详细描述信息***/
-(LDDetailsContentView *)detailsContentView{
    if (!_detailsContentView) {
        _detailsContentView=[[LDDetailsContentView alloc]init];
        
        __weak typeof(self) weakself=self;
        _detailsContentView.contentViewBlock=^(CGFloat height){
            
            [weakself.detailsContentView mas_makeConstraints:^(MASConstraintMaker *make) {
                 make.height.mas_equalTo(height);
            }];
            weakself.mainScrollviewContentHeight +=height;
        };
        
    }
    return _detailsContentView;
}

/***标题标签***/
-(LDTitleLabelView *)titleLabelView{
    if (!_titleLabelView) {
        _titleLabelView=[[LDTitleLabelView alloc]init];
        __weak typeof(self) weakself=self;
        _titleLabelView.titleLabelViewBlock=^(CGFloat height){
            [weakself.titleLabelView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(height); //在添加约束方法里没有定义高度
            }];
            weakself.mainScrollviewContentHeight +=height;
           
        };
        
    }
    return _titleLabelView;
}

/***轮播图***/

-(LDCycleImgView *)cycleView{
    if (!_cycleView) {
        _cycleView=[[LDCycleImgView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WITH, 380)];
    }
    return _cycleView;
}

-(UIScrollView *)mainScrollView{
    if (!_mainScrollView) {
        _mainScrollView=[[UIScrollView alloc]init];
        _mainScrollView.showsVerticalScrollIndicator=NO;
    }
    return _mainScrollView;
}


/***请求轮播图网络数据***/
-(void)getCycleImages{
    
    [self getWithURLString:@"appGoods/findGoodsImgList.do"parameters:@{@"GoodsId":self.detailGoodsID} success:^(id responseObject) {
        [SVProgressHUD dismiss];
        NSArray *imageEntityArray = [LDImageEntity mj_objectArrayWithKeyValuesArray:responseObject];
        //LDDLog(@"imageEntityArray:%@",imageEntityArray);
        NSMutableArray *cycleImgArray=[NSMutableArray array];
        for (LDImageEntity *imageEntity in imageEntityArray) {
            if ([imageEntity.ImgType isEqualToString:@"1"]) {//判断图片是type
                [cycleImgArray addObject:imageEntity.ImgView];
            }
        }
        self.cycleView.imageArray=cycleImgArray;
        self.bottomImageView.imageArray=imageEntityArray;
    } failure:^(NSError *error) {
        LDDLog(@"error : %@",error);
    }];
    
}

/***请求标题文字，产品介绍等数据***/
-(void)getTitleData{
    
    [self getWithURLString:@"appGoods/findGoodsDetail.do" parameters:@{@"GoodsId":self.detailGoodsID} success:^(id responseObject) {
       // LDDLog(@"responsObj:%@",responseObject);
        LDTitleEntity *titleEntity=[LDTitleEntity mj_objectWithKeyValues:responseObject];
        self.titleLabelView.titleEntity=titleEntity;
        self.cycleView.titleEntity=titleEntity;
    } failure:^(NSError *error) {
        
    }];
}


/***详细图片数据***/
-(void)getDetailsContent{
    [self getWithURLString:@"appGoods/findGoodsDetailList.do?" parameters:@{@"GoodsId":self.detailGoodsID} success:^(id responseObject) {
        NSArray *detailsContentEntityArry=[LDDetailsContentEntity  mj_objectArrayWithKeyValuesArray:responseObject];
        self.detailsContentView.detailsContentEntityArry=detailsContentEntityArry;/*将获取到的模型数组赋值给detailsContentView（detailsContentView里有公开接口detailsContentEntityArry）*/
    } failure:^(NSError *error) {
        LDDLog(@"error:%@",error);
    }];
    
}

/***添加控件约束条件***/
-(void)addConstraint{
    
    [_mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 45, 0));//预留45给底部的3个button
    }];
    
    
    [_titleLabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cycleView.mas_bottom);
        make.right.left.equalTo(self.view);
        
    }];
    
    [_detailsContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabelView.mas_bottom).offset(10);
        make.right.left.equalTo(self.view);
       
    }];
    
    [_bottomImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.detailsContentView.mas_bottom);
        make.right.left.equalTo(self.view);
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    
    self.navigationItem.hidesBackButton=YES;
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];//设置navigationbar透明
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];//去除navigationbar边缘阴影线
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"backBtn"] forState:UIControlStateNormal];
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    [backBtn addTarget:self action:@selector(popViewController) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame=CGRectMake(0, 0, 30, 30);
    self.navigationItem.leftBarButtonItem=leftItem;
}

-(void)popViewController{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
