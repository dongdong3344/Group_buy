//
//  LDCycleImgView.m
//  团购项目
//
//  Created by Ringo on 2016/11/28.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import "LDCycleImgView.h"

@interface LDCycleImgView ()
@property(nonatomic,strong)SDCycleScrollView *cycleScrollView;
@property(nonatomic,strong)UILabel *buyCountLabel;//购买人数
@end

@implementation LDCycleImgView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.cycleScrollView];
        [self addSubview:self.buyCountLabel];
        [self setupContrains];
    }
    return self;
}

-(UILabel *)buyCountLabel{
    if (!_buyCountLabel) {
        _buyCountLabel=[[UILabel alloc]init];
        _buyCountLabel.text=@"100人已购买";
        _buyCountLabel.font=[UIFont systemFontOfSize:11];
        _buyCountLabel.textAlignment=NSTextAlignmentCenter;
        _buyCountLabel.layer.cornerRadius=11;
        _buyCountLabel.layer.masksToBounds=YES;
        _buyCountLabel.textColor=[UIColor whiteColor];
        _buyCountLabel.backgroundColor=[UIColor orangeColor];
        
     
    }
    return _buyCountLabel;
}


//set方法，赋值
-(void)setImageArray:(NSArray *)imageArray{
    
    _cycleScrollView.imageURLStringsGroup = imageArray;

}


-(void)setBuyCount:(NSString *)buyCount{
    
    _buyCountLabel.text=buyCount;
}


-(SDCycleScrollView *)cycleScrollView{
    
    if (!_cycleScrollView) {
        _cycleScrollView=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WITH, 380) delegate:nil placeholderImage:[UIImage imageNamed:@"cycle_placeholder"]];
        
        _cycleScrollView.pageDotColor=[UIColor grayColor];
        _cycleScrollView.currentPageDotColor=[UIColor redColor];
        
        _cycleScrollView.pageControlAliment= SDCycleScrollViewPageContolAlimentCenter;
    }
    return _cycleScrollView;
}



-(void)setupContrains{
    [_buyCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(11);
        make.bottom.equalTo(self.mas_bottom).offset(-30);
        make.size.mas_equalTo(CGSizeMake(90, 22));
    }];
}
@end
