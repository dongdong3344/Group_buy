//
//  macros.h
//  团购项目
//
//  Created by Ringo on 2016/11/14.
//  Copyright © 2016年 omni software. All rights reserved.
//

#ifndef macros_h
#define macros_h
#define RGBCOLOR(X,Y,Z)  [UIColor colorWithRed:X/255.0 green:Y/255.0 blue:Z/255.0 alpha:1]

#define SCREEN_WITH    [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT    [UIScreen mainScreen].bounds.size.height


#ifdef DEBUG
#define LDDLog(...)  NSLog(__VA_ARGS__)//LDDLog不限制参数类型，中间用三个英文语句表示
#elif
#define LDDLog(...)
#endif

#endif /* macros_h */
