//
//  LDMyMessageHeadView.h
//  团购项目
//
//  Created by Ringo on 2016/11/14.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MyMessageheadViewBlock)();



@interface LDMyMessageHeadView : UIView
@property(nonatomic,strong)UILabel *welcomeLabel;
@property(nonatomic,copy)MyMessageheadViewBlock block;
- (void)reloadHeadView;
@end
