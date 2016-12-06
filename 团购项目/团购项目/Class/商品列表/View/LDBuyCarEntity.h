//
//  LDBuyCarEntity.h
//  团购项目
//
//  Created by Ringo on 2016/12/5.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDBuyCarEntity : NSObject

/**商品ID*/
@property (copy, nonatomic) NSString *GoodsId;
/**商品缩略图*/
@property (copy, nonatomic) NSString *ImgView;
/**商品标题*/
@property (copy, nonatomic) NSString *GoodsTitle;
/**商品数量*/
@property (assign, nonatomic) NSInteger GoodsCount;
/**价格*/
@property (assign, nonatomic) CGFloat Price;
/**是否选中*/
@property (assign, nonatomic) BOOL isSelectButton;
/**商品标记*/
@property (copy, nonatomic) NSString *UUID;
/**商品重量*/
@property (assign, nonatomic) CGFloat Weight;

@end
