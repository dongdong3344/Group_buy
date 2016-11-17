//
//  LDMyMessageTableView.m
//  团购项目
//
//  Created by Ringo on 2016/11/14.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import "LDMyMessageTableView.h"
#import "LDMessageCell.h"

@interface LDMyMessageTableView ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSArray *cellTableSource; 
@end


@implementation LDMyMessageTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self=[super initWithFrame:frame style:style];
    
    if (self) {
        self.delegate=self;
        self.dataSource=self;
        self.bounces=NO;//不让tableView滑动
        
        self.separatorInset=UIEdgeInsetsMake(0, 45, 0, 0);//设置分割线位置
    }
    return self;
}
-(NSArray *)cellTableSource{
    if (!_cellTableSource) {
        NSString *filePath=[[NSBundle mainBundle]pathForResource:@"cellList.plist" ofType:nil];
        _cellTableSource=[NSArray arrayWithContentsOfFile:filePath];
    }
    return _cellTableSource;
}

#pragma mark -tableView delegate-

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LDMessageCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[LDMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.sourceDic=self.cellTableSource[indexPath.row];
    
    //如果是最后一行，隐藏nextImage,新加一个label
    if (indexPath.row==3) {
        UIImageView *nextImage=[cell valueForKey:@"nextImage"];
        nextImage.hidden=YES;//此处不能移除，否则崩溃
        
        UILabel *phoneNum=[[UILabel alloc]init];
        phoneNum.textColor=RGBCOLOR(124, 122, 128);
        phoneNum.text=@"152-6235-2648";
       // phoneNum.textColor=[UIColor redColor];
        [cell addSubview:phoneNum];
        
        
        [phoneNum mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(cell.mas_right).offset(-15);
            make.centerY.equalTo(cell.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(135, 15));
        }];
    }
    return cell;
    
}
//设置行高为44
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return  44;
}

//选中某行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LDDLog(@"我选中的是第%li",indexPath.row);
    
}


@end
