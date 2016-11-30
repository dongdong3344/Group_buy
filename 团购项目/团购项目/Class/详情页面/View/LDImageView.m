//
//  LDImageView.m
//  团购项目
//
//  Created by Ringo on 2016/11/30.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import "LDImageView.h"
#import "LDImageEntity.h"

@interface LDImageView ()

@end

@implementation LDImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


-(void)setImageArray:(NSArray *)imageArray{
    
    
    CGFloat imageHeight=0;
    
    for (LDImageEntity * imageEntity in imageArray) {
        if ([imageEntity.ImgType isEqualToString:@"1"]) {
            //LDDLog(@"Resolution:%@",imageEntity.Resolution);
            
            NSArray *sizeArray=[imageEntity.Resolution componentsSeparatedByString:@"*"];//字符串截取,以*号以断点
            //LDDLog(@"sizeArray: %@",sizeArray);
            CGFloat height=SCREEN_WITH/[sizeArray[0] floatValue] *[sizeArray[1] floatValue];
            UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(0, imageHeight, SCREEN_WITH,height)];
        
            [image sd_setImageWithURL:[NSURL URLWithString:imageEntity.ImgView]];
            [self addSubview:image];
            imageHeight=imageHeight+height;
        }
    }
    
    //LDDLog(@"imageHeight:%f",imageHeight);
    if (self.imageViewBlock) {
        self.imageViewBlock(imageHeight);
    }
    
}
@end
