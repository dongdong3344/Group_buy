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


@property (nonatomic,strong) NSMutableArray *refreshImages;//刷新动画的图片数组
@property (nonatomic,strong) NSMutableArray *normalImages;//普通状态下的图片数组
@property (nonatomic,strong) NSTimer *timer;//模拟数据刷新需要的时间控制器
@property (nonatomic,assign) int time;

@end


@implementation LDMyMessageTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self=[super initWithFrame:frame style:style];
    
    if (self) {
        self.delegate=self;
        self.dataSource=self;
        [self addSubview:_topLogoImageView];
        //self.bounces=NO;//不让tableView滚动
       // self.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);//不要覆盖状态栏
        self.separatorInset=UIEdgeInsetsMake(0, 45, 0, 0);//设置分割线距离左边45
       // [self createHeader];
    }
    return self;
}
//
////正常情况下的图片
//- (NSMutableArray *)normalImages
//{
//    if (_normalImages == nil) {
//        _normalImages = [[NSMutableArray alloc] init];
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh_fly_1"]];
//        [self.normalImages addObject:image];
//    }
//    return _normalImages;
//}
////正在刷新状态下的图片
//- (NSMutableArray *)refreshImages
//{
//    if (_refreshImages == nil) {
//        _refreshImages = [[NSMutableArray alloc] init];
//        //	循环添加图片
//        for (NSUInteger i = 1; i<=29; i++) {
//            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh_fly_%ld", i]];
//            
//            [self.refreshImages addObject:image];
//        }
//    }
//    return _refreshImages;
//}
//
//-(void)createHeader{
//    
//    MJRefreshGifHeader *header =[MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
//    [header setImages:self.refreshImages forState:MJRefreshStateRefreshing];
//    [header setTitle:@"刷新中…" forState:MJRefreshStateRefreshing];
//    [header setImages:self.normalImages forState:MJRefreshStateIdle];
//    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
//    [header setTitle:@"释放即可刷新" forState:MJRefreshStatePulling];
//    [header setImages:self.refreshImages forState:MJRefreshStatePulling];
//    header.lastUpdatedTimeLabel.hidden= YES;//如果不隐藏这个会默认 图片在最左边不是在中间
//    header.stateLabel.hidden = YES;//隐藏文字
//    self.mj_header = header;
//}
//
//
//-(void)loadNewData {
//    //模拟刷新的时间
//    self.timer  =[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
//    self.time = 3;
//}
//-(void)timeAction {
//    self.time --;
//   // NSLog(@"%d",self.time);
//    if (self.time == 0) {
//        //		刷新数据
//        [self reloadData];
//        //		停止刷新
//        [self.mj_header endRefreshing];
//        [self.timer invalidate];
//    }
//}

//  懒加载,下拉logo
- (UIImageView *)topLogoImageView {
    if (!_topLogoImageView) {
        _topLogoImageView = [[UIImageView alloc] init];
        _topLogoImageView.image = [UIImage imageNamed:@"logo1"];
        _topLogoImageView.contentMode = UIViewContentModeScaleAspectFit;
       // _topLogoImageView.backgroundColor = SPTableViewBackgroundColor;
    }
    return _topLogoImageView;
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
    if (indexPath.row==2) {
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
    if (indexPath.row==2) {
        //让系统自带拨号
         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://15262352648"]];
       
          }
    
    
        [tableView deselectRowAtIndexPath:indexPath animated:YES];//点击一下后，表格被选中，然后立即变成未选中状态，防止一直处于灰色状态

   
    
}

//设置footer高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    NSDictionary *loginDic=[[NSUserDefaults standardUserDefaults]valueForKey:@"ISLOGIN"];
    
//    return 44;
      if (loginDic.count) {
          //return SCREEN_HEIGHT-171-44*6;
          return 65;

    }else{
          return 0.01;
        
    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    NSDictionary *loginDic = [[NSUserDefaults standardUserDefaults]valueForKey:@"ISLOGIN"];
    if (loginDic.count){
        
        UIView *footView=[[UIView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WITH,44)];
        footView.backgroundColor=[UIColor whiteColor];
 
       
        _logoutButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _logoutButton.frame=footView.frame;
   
        [_logoutButton setTitle:@"退出当前账号" forState:UIControlStateNormal];
        _logoutButton.titleLabel.font=[UIFont systemFontOfSize:15];
       
        [_logoutButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_logoutButton setTitle:@"退出当前账号" forState:UIControlStateHighlighted];
        [_logoutButton setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
        [_logoutButton addTarget:self action:@selector(logoutAction) forControlEvents:UIControlEventTouchUpInside];
        _logoutButton.backgroundColor=RGBCOLOR(242, 242, 242);
       // logoutBtn.layer.cornerRadius=5;
        [footView addSubview:_logoutButton];
        return footView;

    }
    
    return  nil;
}


//下拉放大表头图片
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
 
    CGPoint offset = scrollView.contentOffset;   //获取偏移量
    //判断是否改变
    if (offset.y < 0) {
        CGRect rect = self.tableHeaderView.frame;   //  只需要改变图片的y值和高度即可
        rect.origin.y = offset.y;
        rect.size.height = 171 - offset.y; //171为图片高度

        self.tableHeaderView.frame = rect;
    }
    
 }


-(void)logoutAction{
    
    if (self.exitBlcok) {
        self.exitBlcok();
    }
    
}


@end
