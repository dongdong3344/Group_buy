//
//  LDGoodsListCollectionView.h
//  团购项目
//
//  Created by Ringo on 2016/12/3.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectCellGoodsIDBlock)(NSString *goodsID);

@interface LDGoodsListCollectionView : UICollectionView
@property(strong,nonatomic)NSArray *goodsListArray;
@property(copy,nonatomic)SelectCellGoodsIDBlock goodsIDBlock;
@end
