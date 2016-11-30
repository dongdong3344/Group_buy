//
//  LDDetailsContentView.h
//  团购项目
//
//  Created by Ringo on 2016/11/30.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DetailsContentViewBlock)(CGFloat height);
@interface LDDetailsContentView : UIView
@property(strong,nonatomic)NSArray *detailsContentEntityArry;/*存放模型*/
@property(copy,nonatomic)DetailsContentViewBlock contentViewBlock;
@end
