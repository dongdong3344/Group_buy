//
//  LDCheckoutView.h
//  团购项目
//
//  Created by Ringo on 2016/12/6.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDBuyCarEntity.h"



@interface LDCheckoutView : UIView

@property(nonatomic,strong)UILabel *priceLabel;
@property(strong,nonatomic)UIButton *gotoCheckoutBtn,*selectAllBtn;
@property(strong,nonatomic)LDBuyCarEntity *buycarEntity;


@end
