//
//  LDGoodsListViewController.m
//  团购项目
//
//  Created by Ringo on 2016/12/3.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import "LDGoodsListViewController.h"
#import "LDTopButtonView.h"
#import "LDGoodsListCollectionView.h"

@interface LDGoodsListViewController ()
@property(nonatomic,strong)LDTopButtonView *topButtonView;
@property(nonatomic,strong)LDGoodsListCollectionView *goodsListCollectionView;
@end

@implementation LDGoodsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.topButtonView];
    [self.view addSubview:self.goodsListCollectionView];
    [self addContrains];
}

-(void)addContrains{
    [_goodsListCollectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topButtonView.mas_bottom);
        make.right.left.bottom.equalTo(self.view);
    }];
}

-(LDGoodsListCollectionView *)goodsListCollectionView{
    if (!_goodsListCollectionView) {
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc]init];
        CGFloat width=(SCREEN_WITH-10)/2;
        flowLayout.itemSize=CGSizeMake(width, width/0.725);
        _goodsListCollectionView=[[LDGoodsListCollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flowLayout];
        _goodsListCollectionView.backgroundColor=RGBCOLOR(242, 242, 242);
        _goodsListCollectionView.goodsListArray=self.goodsListEntityArray;
        
    }
    return _goodsListCollectionView;
}

-(LDTopButtonView *)topButtonView{
    if (!_topButtonView) {
        _topButtonView=[[LDTopButtonView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WITH, 30)];
    }
    return _topButtonView;
}

@end
