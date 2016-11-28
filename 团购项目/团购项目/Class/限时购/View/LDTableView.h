//
//  LDTableView.h
//  团购项目
//
//  Created by Ringo on 2016/11/28.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TableSelectedGoodsIDBlcok)(NSString *goodsID);

@interface LDTableView : UITableView
@property(assign,nonatomic)BOOL  isProductTableView;
@property(strong,nonatomic)NSArray *productEntityArry;//存放新品数据模型的数组
@property(strong,nonatomic)NSArray *brandEntityArry;//存放品牌数据模型的数组
@property(copy,nonatomic)TableSelectedGoodsIDBlcok goodsIDBlcok;
@end
