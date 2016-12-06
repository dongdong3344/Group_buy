//
//  LDBottomBtnView.h
//  团购项目
//
//  Created by Ringo on 2016/11/30.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AddGoodsToBuyCarBlock)();
@interface LDBottomBtnView : UIView

@property(nonatomic,strong)UIButton *buyCarBtn;
@property(strong,nonatomic)JSBadgeView *badgeView;

@property(copy,nonatomic)AddGoodsToBuyCarBlock addGoodsTobuyCarBlock;
@end
