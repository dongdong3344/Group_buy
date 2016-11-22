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
        self.bounces=NO;//不让tableView滚动
        self.separatorInset=UIEdgeInsetsMake(0, 45, 0, 0);//设置分割线距离左边45
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
    
    NSDictionary *loginDic=[[NSUserDefaults standardUserDefaults]valueForKey:@"ISLOGIN"];
    if (loginDic.count) {//字典里有值的话
        return 6;
    }else  return 4;
    
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
        phoneNum.text=@"15262352648";
       // phoneNum.textColor=[UIColor redColor];
        [cell addSubview:phoneNum];
        
        
        [phoneNum mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(cell.mas_right).offset(-15);
            make.centerY.equalTo(cell.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(110, 15));
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

//设置footer高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    NSDictionary *loginDic=[[NSUserDefaults standardUserDefaults]valueForKey:@"ISLOGIN"];
    if (loginDic.count) {
          return SCREEN_HEIGHT-171-44*6;
    }else{
          return SCREEN_HEIGHT-171-44*4;
        
    }
    
}



-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    NSDictionary *loginDic = [[NSUserDefaults standardUserDefaults]valueForKey:@"ISLOGIN"];
    if (loginDic.count){
        
        UIView *footView=[[UIView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WITH,44)];
        footView.backgroundColor=RGBCOLOR(242, 242, 242);

       
        _logoutButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _logoutButton.frame=footView.frame;
        [_logoutButton setTitle:@"退出当前账号" forState:UIControlStateNormal];
        _logoutButton.titleLabel.font=[UIFont systemFontOfSize:15];
        [_logoutButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_logoutButton setTitle:@"退出当前账号" forState:UIControlStateHighlighted];
        [_logoutButton setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
        [_logoutButton addTarget:self action:@selector(logoutAction) forControlEvents:UIControlEventTouchUpInside];
        _logoutButton.backgroundColor=[UIColor whiteColor];
       // logoutBtn.layer.cornerRadius=5;
        [footView addSubview:_logoutButton];
        return footView;

    }
    
    return  nil;
}

-(void)logoutAction{
    
    if (self.exitBlcok) {
        self.exitBlcok();
    }
    
}


@end
