//
//  LDMyMessageTableView.h
//  团购项目
//
//  Created by Ringo on 2016/11/14.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MyMessageTableViewBlock)();

@interface LDMyMessageTableView : UITableView
@property(strong,nonatomic)UIButton *logoutButton;
@property(copy,nonatomic)MyMessageTableViewBlock exitBlcok;

@end
