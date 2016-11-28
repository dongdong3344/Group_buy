//
//  LDImageEntity.h
//  团购项目
//
//  Created by Ringo on 2016/11/28.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LDImageEntity : NSObject
/**图片地址*/
@property (copy, nonatomic) NSString *ImgView;

/**图片名称*/
@property (copy, nonatomic) NSString *ImgType;

/**图片尺寸*/
@property (copy, nonatomic) NSString *Resolution;
@end
