//
//  LDDetailsContentView.m
//  团购项目
//
//  Created by Ringo on 2016/11/30.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import "LDDetailsContentView.h"
#import "LDDetailsContentEntity.h"
@interface LDDetailsContentView ()

@end

@implementation LDDetailsContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)setDetailsContentEntityArry:(NSArray *)detailsContentEntityArry{
    CGFloat textHeight =0;
   // _detailsContentEntityArry=detailsContentEntityArry;
    
    for (LDDetailsContentEntity *contentEntity in detailsContentEntityArry) {
        UILabel *titleLable=[[UILabel alloc]initWithFrame:CGRectMake(15, textHeight, 60, 12)];
        titleLable.text=contentEntity.Title;
        titleLable.font=[UIFont boldSystemFontOfSize:13];
       
        [self addSubview:titleLable];
        
        CGFloat height=[self returnLabelHeight:contentEntity.Value size:CGSizeMake(SCREEN_WITH-190, MAXFLOAT) fontSize:[UIFont systemFontOfSize:13]];
        UILabel *contentLabel=[[UILabel alloc]initWithFrame:CGRectMake(90, textHeight-2, SCREEN_WITH-190, height)];
        contentLabel.text=contentEntity.Value;
        contentLabel.font=[UIFont systemFontOfSize:13];
        contentLabel.numberOfLines=0;//可换行
        [self addSubview:contentLabel];
        textHeight=textHeight+height+15;//15是两条数据之间的间隔
    }
    
    if (self.contentViewBlock) {
        self.contentViewBlock(textHeight);
    }
}



-(CGFloat)returnLabelHeight:(NSString *)string
                       size:(CGSize)size
                   fontSize:(UIFont*)font{
    CGFloat height=[string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size.height ;//自适应高度
    return height;
}
@end
