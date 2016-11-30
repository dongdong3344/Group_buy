//
//  LDImageView.h
//  团购项目
//
//  Created by Ringo on 2016/11/30.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ImageViewBlock)(CGFloat imageHeight);
@interface LDImageView : UIView
@property(strong,nonatomic)NSArray *imageArray;
@property(copy,nonatomic)ImageViewBlock imageViewBlock;
@end
