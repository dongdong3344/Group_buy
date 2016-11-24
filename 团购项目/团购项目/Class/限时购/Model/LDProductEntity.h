//
//  LDProductEntity.h
//  团购项目
//
//  Created by Ringo on 2016/11/24.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDProductEntity : NSObject


@property (nonatomic, strong) NSString * countryImg;     //国家图片1
@property (nonatomic, strong) NSString * discount;       //购买数量
@property (nonatomic, strong) NSString * domesticPrice; //本地价格1
@property (nonatomic, strong) NSString * foreignPrice;  //国外价格1
@property (nonatomic, strong) NSString * goodsId;  //产品ID   1
@property (nonatomic, strong) NSString * goodsIntro;   //商品信息
@property (nonatomic, strong) NSString * imgView;    //缩略图1
@property (nonatomic, strong) NSString * price;         //原来的价格1
@property (nonatomic, strong) NSString * title;  //商品名称

@end
