//
//  LDMessageCell.m
//  团购项目
//
//  Created by Ringo on 2016/11/14.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import "LDMessageCell.h"
@interface LDMessageCell()
@property(nonatomic,strong)UIImageView *iconImage;//图标
@property(nonatomic,strong)UILabel *titleLabel;//cell中显示的文字label
@property(nonatomic,strong)UIImageView *nextImage;//右箭头
@property(nonatomic,strong)UILabel *lineLabel;//分割线
@end


@implementation LDMessageCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.iconImage];
        [self addSubview:self.titleLabel];
        [self addSubview:self.nextImage];
        [self addSubview:self.lineLabel];
    }
    return self;
}

-(UIImageView *)iconImage{
    
    if (!_iconImage) {
        _iconImage=[[UIImageView alloc]init];
    }
    return _iconImage;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel=[[UILabel alloc]init];
        _titleLabel.font=[UIFont systemFontOfSize:15];
        _titleLabel.textColor=[UIColor blackColor];
    }
    return _titleLabel;
    
}

-(UIImageView *)nextImage{
    if (!_nextImage) {
        _nextImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"下一步"]];
    }
    return _nextImage;
    
}


-(UILabel *)lineLabel{
    
    if (!_lineLabel) {
        _lineLabel=[[UILabel alloc]init];
        _lineLabel.backgroundColor=RGBCOLOR(242, 242, 242);
    }
    return _lineLabel;
}

#pragma mark -重写 setter方法-
-(void)setSourceDic:(NSDictionary *)sourceDic{
    _sourceDic=sourceDic;
    _titleLabel.text=sourceDic[@"title"];
    _iconImage.image=[UIImage imageNamed: sourceDic[@"image"]];
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));//设置icon大小
        make.left.equalTo(self.mas_left).offset(15);//距离左边15
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [_nextImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(10, 14));
        make.right.equalTo(self.mas_right).offset(-15);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(140, 15));
        make.left.equalTo(self.iconImage.mas_right).offset(10);
        make.centerY.equalTo(self.mas_centerY);
        
    }];
    
    [_lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);//和titleLabel左对齐
        make.right.bottom.equalTo(self);
        make.height.equalTo(@1);//高度为1
    }];
  
}


@end
