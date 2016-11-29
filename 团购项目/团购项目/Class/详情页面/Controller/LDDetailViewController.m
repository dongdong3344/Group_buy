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
@interface LDDetailViewController ()
@property(nonatomic,strong)UIScrollView *mainScrollView;
@property(nonatomic,strong)LDCycleImgView *cycleView;
@end
@implementation LDDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // self.edgesForExtendedLayout = 0;
    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.mainScrollView];
    [self.mainScrollView addSubview:self.cycleView];
    [self setupConstraint];
    [self getCycleImages];

}

-(LDCycleImgView *)cycleView{
    if (!_cycleView) {
        _cycleView=[[LDCycleImgView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WITH, 380)];
    }
    return _cycleView;
}

-(UIScrollView *)mainScrollView{
    if (!_mainScrollView) {
        _mainScrollView=[[UIScrollView alloc]init];
        _mainScrollView.contentSize=CGSizeMake(0, 2000);
    }
    return _mainScrollView;
}

-(void)getCycleImages{
    
    [self  getWithURLString:@"appGoods/findGoodsImgList.do"parameters:@{@"GoodsId":self.detailGoodsID} success:^(id responseObject) {
        [SVProgressHUD dismiss];
        NSArray *imageEntityArray = [LDImageEntity mj_objectArrayWithKeyValuesArray:responseObject];
       // LDDLog(@"imageEntityArray:%@",imageEntityArray);
        NSMutableArray *cycleImgArray=[NSMutableArray array];
        for (LDImageEntity *imageEntity in imageEntityArray) {
            if ([imageEntity.ImgType isEqualToString:@"1"]) {//判断图片是type 1
                [cycleImgArray addObject:imageEntity.ImgView];
            }
        }
        self.cycleView.imageArray=cycleImgArray;
    } failure:^(NSError *error) {
        LDDLog(@"error : %@",error);
    }];
    
}

-(void)setupConstraint{
    
    [_mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 45, 0));
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
