//
//  LDBuyCarTableViewCell.h
//  团购项目
//
//  Created by Ringo on 2016/12/5.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDBuyCarEntity.h"

@interface LDBuyCarTableViewCell : UITableViewCell

@property(strong,nonatomic)LDBuyCarEntity *buycarEntity;
@property(strong,nonatomic)UIButton *isSelectedBtn,*plusBtn,*minusBtn;
@end
