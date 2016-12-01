//
//  LDCycleImgView.h
//  团购项目
//
//  Created by Ringo on 2016/11/28.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDTitleEntity.h"

@interface LDCycleImgView : UIView
@property(strong,nonatomic)NSArray *imageArray;//轮播图数组
@property(strong,nonatomic)LDTitleEntity *titleEntity;
@end
