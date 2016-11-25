//
//  LDProductEntity.h
//  团购项目
//
//  Created by Ringo on 2016/11/24.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDProductEntity : NSObject

//注意首字母大写，因为请求到的字典数组里都是大写，否则解析后都是nil



@property (nonatomic, strong) NSString * Discount;          //购买数量
@property (nonatomic, strong) NSString * DomesticPrice; //本地价格1
@property (nonatomic, strong) NSString * ForeignPrice;  //国外价格1
@property (nonatomic, strong) NSString * GoodsId;        //产品ID   1
@property (nonatomic, strong) NSString * GoodsIntro;   //商品信息
@property (nonatomic, strong) NSString * ImgView;    //缩略图1
@property (nonatomic, strong) NSString * Price;        //原来的价格1
@property (nonatomic, strong) NSString * Title;        //商品名称

@end
