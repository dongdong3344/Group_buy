//
//  LDTitleEntity.h
//  团购项目
//
//  Created by Ringo on 2016/11/29.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDTitleEntity : NSObject
/**折扣价格*/
@property (copy, nonatomic) NSString *Price;
/**原价*/
@property (copy, nonatomic) NSString *OriginalPrice;
/**折扣数*/
@property (copy, nonatomic) NSString *Discount;
/**购买人数*/
@property (copy, nonatomic) NSString *BuyCount;
/**标题缩写*/
@property (copy, nonatomic) NSString *Abbreviation;
/**商品描述*/
@property (copy, nonatomic) NSString *GoodsIntro;
/**商品ID*/
@property (copy, nonatomic) NSString *GoodsId;
/**品牌图标*/
@property (copy, nonatomic) NSString *ShopImage;
/**品牌名称*/
@property (copy, nonatomic) NSString *BrandCNName;
/**品牌ID*/
@property (copy, nonatomic) NSString *ShopId;
/**品牌国家名称*/
@property (copy, nonatomic) NSString *CountryName;
/**是否收藏*/
@property (copy, nonatomic) NSString *isCollected;


@end
