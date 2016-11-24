//
//  LDTimeViewController.m
//  团购项目
//
//  Created by Ringo on 2016/11/14.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import "LDTimeViewController.h"
#import "LDProductEntity.h"
#import "LDProductTableViewCell.h"

@interface LDTimeViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property(strong,nonatomic)UIScrollView *mainScrollView;
@property(strong,nonatomic)SDCycleScrollView *cycleScrollView;
@property(strong,nonatomic)UIView *buttonBarView;
@property(strong,nonatomic)UITableView *productTableView,*brandTableView;
@property(strong,nonatomic)UIButton *productBtn,*brandBtn;
@property(strong,nonatomic)NSArray *productArry;

@end

@implementation LDTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = 0;
    [self.view addSubview:self.mainScrollView];
    [self.mainScrollView addSubview:self.cycleScrollView];
    
    [self.mainScrollView addSubview:self.productTableView];
    [self.mainScrollView addSubview:self.brandTableView];
    [self.buttonBarView addSubview:self.productBtn];
    [self.buttonBarView addSubview:self.brandBtn];
    [self.mainScrollView addSubview:self.buttonBarView];
  
    [self  getCycleImages];
    [self getProducts];



}

-(UIScrollView *)mainScrollView{
    
    if (!_mainScrollView) {
        _mainScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WITH, SCREEN_HEIGHT)];
        _mainScrollView.contentSize=CGSizeMake(0, 1980);
        _mainScrollView.showsVerticalScrollIndicator=NO;
        _mainScrollView.delegate=self;
        
    }
    return _mainScrollView;
    
}


-(SDCycleScrollView *)cycleScrollView{
    
    if (!_cycleScrollView) {
        _cycleScrollView=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WITH, 230) delegate:nil placeholderImage:[UIImage imageNamed:@"placeholder"]];
        _cycleScrollView.backgroundColor=[UIColor redColor];
        _cycleScrollView.pageDotColor=[UIColor grayColor];
    
        _cycleScrollView.pageControlAliment= SDCycleScrollViewPageContolAlimentCenter
        ;
      //  _cycleScrollView.pageControlStyle= SDCycleScrollViewPageContolStyleAnimated;
    }
    return _cycleScrollView;
}

-(UIView *)buttonBarView{
    if (!_buttonBarView) {
        _buttonBarView=[[UIView alloc]initWithFrame:CGRectMake(0, 230, SCREEN_WITH, 50)];
        _buttonBarView.backgroundColor=[UIColor whiteColor];
        
    }
    return _buttonBarView;
 
}

-(UIButton *)productBtn{
    if (!_productBtn) {
        _productBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_productBtn setImage:[UIImage imageNamed:@"product_un"] forState:UIControlStateNormal];
        [_productBtn setImage:[UIImage  imageNamed:@"product"] forState:UIControlStateSelected];
        [_productBtn setTitle:@"新品团购" forState:UIControlStateNormal];
        [_productBtn setTitleColor:RGBCOLOR(56, 166, 243) forState:UIControlStateNormal];
        [_productBtn setTitleColor:RGBCOLOR(213, 48, 34) forState:UIControlStateSelected];
        _productBtn.titleLabel.font=[UIFont systemFontOfSize:14];
        _productBtn.selected=YES;
        [_productBtn addTarget:self action:@selector(changeTableView:) forControlEvents:UIControlEventTouchUpInside];
        
        _productBtn.frame=CGRectMake(0, 0, SCREEN_WITH/2, 50);
    }
    return _productBtn;
    
}


-(UIButton *)brandBtn{
    if (!_brandBtn) {
        _brandBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_brandBtn setImage:[UIImage imageNamed:@"brand"] forState:UIControlStateNormal];
        [_brandBtn setImage:[UIImage  imageNamed:@"brand_un"] forState:UIControlStateSelected];
        _brandBtn.titleLabel.font=[UIFont systemFontOfSize:14];
        [_brandBtn setTitle:@"品牌团购" forState:UIControlStateNormal];
        [_brandBtn setTitleColor: RGBCOLOR(213, 48, 34) forState:UIControlStateSelected];
        [_brandBtn setTitleColor:RGBCOLOR(56, 166, 243) forState:UIControlStateNormal];
         _brandBtn.frame=CGRectMake(SCREEN_WITH/2, 0, SCREEN_WITH/2, 50);
        [_brandBtn addTarget:self action:@selector(changeTableView:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _brandBtn;
    
}


-(void)changeTableView:(UIButton *)button{
    if (button==self.productBtn) {
       
        CGRect productRect=self.productTableView.frame;
        productRect.origin.x=0;
        self.productTableView.frame=productRect;
        
        CGRect brandRect=self.brandTableView.frame;
        brandRect.origin.x=SCREEN_WITH;
        self.brandTableView.frame=brandRect;
        
        self.productBtn.selected=YES;
        self.brandBtn.selected=NO;
        
        
    }else{
        
        CGRect productRect=self.productTableView.frame;
        productRect.origin.x=-SCREEN_WITH;
        self.productTableView.frame=productRect;
        
        CGRect brandRect=self.brandTableView.frame;
        brandRect.origin.x=0;
        self.brandTableView.frame=brandRect;
        
        self.productBtn.selected=NO;
        self.brandBtn.selected=YES;
        
    }
    
}

-(UITableView *)productTableView{
    
    if (!_productTableView) {
        _productTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 280, SCREEN_WITH, 1700) style:UITableViewStylePlain];
        _productTableView.delegate=self;
        _productTableView.dataSource=self;
        _productTableView.bounces=NO;//不让上下回弹
    }
    return _productTableView;
}


-(UITableView *)brandTableView{
    
    if (!_brandTableView) {
        _brandTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 280, SCREEN_WITH, 1700) style:UITableViewStylePlain];
        _brandTableView.delegate=self;
        _brandTableView.dataSource=self;
        _brandTableView.backgroundColor=[UIColor orangeColor];
    }
    return _brandTableView;
}



//请求轮播数据
- (void)getCycleImages{
    [self  getWithURLString:@"appHome/appHome.do"  parameters:nil success:^(id responseObject) {
          [SVProgressHUD dismiss];
        NSMutableArray *imageArray = [NSMutableArray array];
        for (NSDictionary *dic in responseObject) {
            NSString *imageUrl = dic[@"ImgView"];
            [imageArray addObject:imageUrl];
        }
       _cycleScrollView.imageURLStringsGroup = imageArray;
     
    } failure:^(NSError *error) {
        LDDLog(@"error : %@",error);
    }];
  }

//请求新品团购数据
-(void)getProducts{
   // http://123.57.141.249:8080/beautalk/appActivity/appHomeGoodsList.do
    [self getWithURLString:@"appActivity/appHomeGoodsList.do" parameters:nil success:^(id responseObject) {
     
        self.productArry=[LDProductEntity mj_objectArrayWithKeyValuesArray:responseObject];
        
        LDDLog(@"productArry:%@",self.productArry);
        [self.productTableView reloadData];//刷新数据
    } failure:^(NSError *error) {
         LDDLog(@"error:%@",error);
    }];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offsetY=scrollView.contentOffset.y;
    if (offsetY>230) {
        CGRect rect=self.buttonBarView.frame;
        rect.origin.y=offsetY;
        self.buttonBarView.frame=rect;
        
    }else {
        CGRect rect=self.buttonBarView.frame;
        rect.origin.y=230;
        self.buttonBarView.frame=rect;
        
    }
    
    
}





-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 170;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView==self.productTableView) {
        return self.productArry.count;
    }
    return 10;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.productTableView) {
        LDProductTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"product"];
        if (!cell) {
            cell=[[LDProductTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"product"];
            cell.productEntiy=self.productArry[indexPath.row];
        }
        return cell;
    }else{
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" ];
        if (!cell) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            cell.textLabel.text=[NSString stringWithFormat:@"%li",indexPath.row];
        }
        return cell;

    }
    
}



@end
