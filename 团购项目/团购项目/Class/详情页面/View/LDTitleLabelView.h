//
//  LDTitleLabelView.h
//  团购项目
//
//  Created by Ringo on 2016/11/28.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDTitleEntity.h"

typedef void(^TitleLabelViewBlock)(CGFloat height);

@interface LDTitleLabelView : UIView
@property(strong,nonatomic)LDTitleEntity *titleEntity;
@property(copy,nonatomic)TitleLabelViewBlock titleLabelViewBlock;

@end
