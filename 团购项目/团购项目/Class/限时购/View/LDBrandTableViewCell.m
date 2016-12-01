//
//  LDBrandTableViewCell.m
//  团购项目
//
//  Created by Ringo on 2016/11/25.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import "LDBrandTableViewCell.h"


@interface LDBrandTableViewCell ()
@property(nonatomic,strong)UIImageView *pictureView;
@end

@implementation LDBrandTableViewCell
-(void)setBrandEntity:(LDBrandEntity *)brandEntity{
    
    _brandEntity=brandEntity;
    [_pictureView sd_setImageWithURL:[NSURL URLWithString:self.brandEntity.ImgView] placeholderImage:[UIImage imageNamed:@"brand_placeholder"]];
}

-(UIImageView *)pictureView{
    if (!_pictureView) {
        _pictureView=[[UIImageView alloc]init];
    }
    return _pictureView;
}

-(void)layoutSubviews{
    [_pictureView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 10, 0));//设置内边距
        
    }];
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.pictureView];
        
    }
    return self;
}
@end
