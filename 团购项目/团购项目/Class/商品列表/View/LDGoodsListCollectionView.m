//
//  LDGoodsListCollectionView.m
//  团购项目
//
//  Created by Ringo on 2016/12/3.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import "LDGoodsListCollectionView.h"
#import "LDGoodsCollectionViewCell.h"

@interface LDGoodsListCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation LDGoodsListCollectionView

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    self=[super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.dataSource=self;
        self.delegate=self;
        [self registerClass:[LDGoodsCollectionViewCell class] forCellWithReuseIdentifier:@"LDGoodsCollectionViewCell"];//注册cell
    
    }
    return self;
}

//刷新数据
-(void)setGoodsListArray:(NSArray *)goodsListArray{
    _goodsListArray=goodsListArray;
    [self reloadData];
}
//分组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

//元素个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _goodsListArray.count;
}

//cell
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID=@"LDGoodsCollectionViewCell";
    LDGoodsCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath ];
    cell.goodsListEntity=self.goodsListArray[indexPath.row];
    return cell;
    
}

//点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}


@end
