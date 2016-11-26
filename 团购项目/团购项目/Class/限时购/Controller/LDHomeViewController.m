//
//  LDTimeViewController.m
//  团购项目
//
//  Created by Ringo on 2016/11/14.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import "LDHomeViewController.h"
#import "LDProductEntity.h"
#import "LDProductTableViewCell.h"
#import "LDBrandEntity.h"
#import "LDBrandTableViewCell.h"
#import "LDButtonSwitchView.h"


#define PRODUCT_CELL_WIDTH 170
#define BRAND_CELL_WIDTH 200

@interface LDHomeViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property(strong,nonatomic)UIScrollView *mainScrollView;
@property(strong,nonatomic)SDCycleScrollView *cycleScrollView;

@property(strong,nonatomic)UITableView *productTableView,*brandTableView;

@property(strong,nonatomic)NSArray *productEntityArry;//存放新品数据模型的数组
@property(strong,nonatomic)NSArray *brandEntityArry;//存放品牌数据模型的数组
@property(strong,nonatomic)LDButtonSwitchView *buttonSwitchView;
@end

@implementation LDHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = 0;
    [self.view addSubview:self.mainScrollView];
    [self.mainScrollView addSubview:self.cycleScrollView];
    
    [self.mainScrollView addSubview:self.productTableView];
    [self.mainScrollView addSubview:self.brandTableView];
    [self.mainScrollView addSubview:self.buttonSwitchView];
    [self  getCycleImages];
    [self getProducts];
    [self getBrands];

}


-(UIScrollView *)mainScrollView{
    
    if (!_mainScrollView) {
        _mainScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WITH, SCREEN_HEIGHT-49-64)];
        _mainScrollView.contentSize=CGSizeMake(0, 1980);
        _mainScrollView.showsVerticalScrollIndicator=NO;
        _mainScrollView.delegate=self;
        
    }
    return _mainScrollView;
    
}


-(SDCycleScrollView *)cycleScrollView{
    
    if (!_cycleScrollView) {
        _cycleScrollView=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WITH, 230) delegate:nil placeholderImage:[UIImage imageNamed:@"cycle_placeholder"]];
 
        _cycleScrollView.pageDotColor=[UIColor grayColor];
        _cycleScrollView.currentPageDotColor=[UIColor redColor];
    
        _cycleScrollView.pageControlAliment= SDCycleScrollViewPageContolAlimentCenter
        ;
      //  _cycleScrollView.pageControlStyle= SDCycleScrollViewPageContolStyleAnimated;
    }
    return _cycleScrollView;
}


//放按钮的view
-(LDButtonSwitchView *)buttonSwitchView{
    
    if (!_buttonSwitchView) {
       _buttonSwitchView=[[LDButtonSwitchView alloc]initWithFrame:CGRectMake(0, 230, SCREEN_WITH, 50)];
        _buttonSwitchView.backgroundColor=[UIColor whiteColor];
    }
    return _buttonSwitchView;
 
}


-(void)changeTableView:(UIButton *)button{
    
    if (button==self.buttonSwitchView.productBtn) {//如何新品团购按钮被选中
        button.selected=YES;
        self.buttonSwitchView.brandBtn.selected=NO;
        
    [UIView animateWithDuration:0.2 animations:^{
        CGRect productRect=self.productTableView.frame;
        productRect.origin.x=0;
        self.productTableView.frame=productRect;
        
        CGRect brandRect=self.brandTableView.frame;
        brandRect.origin.x=SCREEN_WITH;
        self.brandTableView.frame=brandRect;
        self.mainScrollView.contentSize=CGSizeMake(0,self.productEntityArry.count*170+280 );//改变大的Scroll
    }];
        
    }else{
        button.selected=YES;
        self.buttonSwitchView.productBtn.selected=NO;
        [UIView animateWithDuration:0.2 animations:^{
            CGRect brandRect=self.brandTableView.frame;
            brandRect.origin.x=0;
            self.brandTableView.frame=brandRect;
            
            CGRect productRect=self.productTableView.frame;
            productRect.origin.x=-SCREEN_WITH;
            self.productTableView.frame=productRect;
            self.mainScrollView.contentSize=CGSizeMake(0,self.brandEntityArry.count*200+280 );//改变大的Scroll

        }];
      
    }
    
}

-(UITableView *)productTableView{
    
    if (!_productTableView) {
        _productTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 280, SCREEN_WITH, self.productEntityArry.count*PRODUCT_CELL_WIDTH) style:UITableViewStylePlain];
        _productTableView.delegate=self;
        _productTableView.dataSource=self;
        _productTableView.bounces=NO;//不让上下回弹
           }
    return _productTableView;
}


-(UITableView *)brandTableView{
    
    if (!_brandTableView) {
        _brandTableView=[[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WITH, 280, SCREEN_WITH, self.brandEntityArry.count*BRAND_CELL_WIDTH) style:UITableViewStylePlain]; //注意是。orgin.x=SCREEN_WITH,如果写成0 ，则页面加载时，会先显示brandTableView
        _brandTableView.delegate=self;
        _brandTableView.dataSource=self;
        _brandTableView.bounces=NO;//不让上下回弹
        
    }
    return _brandTableView;
}



//请求轮播数据
- (void)getCycleImages{
    
    [self  getWithURLString:@"appHome/appHome.do"  parameters:nil success:^(id responseObject) {
          [SVProgressHUD dismiss];
        NSMutableArray *imageArray = [NSMutableArray array];
        for (NSDictionary *dic in responseObject) {
            NSString *imageURL= dic[@"ImgView"];
            [imageArray addObject:imageURL];
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
        
        //LDDLog(@"responseObject:%@",responseObject);
        
        self.productEntityArry=[LDProductEntity  mj_objectArrayWithKeyValuesArray:responseObject];
      
       //NSLog(@"productEntityArry:%@",self.productEntityArry);
        
        CGRect  rect=self.productTableView.frame;
        rect.size.height=self.productEntityArry.count*170;  //改变productTableView的高度
        self.productTableView.frame=rect;

       // LDDLog(@" 新品数据frame:%@",NSStringFromCGSize(self.mainScrollView.contentSize));
       [self.productTableView reloadData];//刷新表格数据
        
    } failure:^(NSError *error) {
         LDDLog(@"error:%@",error);
    }];
}


//请求品牌团购数据
-(void)getBrands{
     //  http://123.57.141.249:8080/beautalk/appActivity/appActivityList.do
    [self getWithURLString:@"appActivity/appActivityList.do" parameters:nil success:^(id responseObject) {
        
        //LDDLog(@"responseObject:%@",responseObject);
        
        self.brandEntityArry=[LDBrandEntity  mj_objectArrayWithKeyValuesArray:responseObject];
        
        //NSLog(@"brandEntityArry:%@",self.brandEntityArry);
        
        CGRect  rect=self.brandTableView.frame;
        rect.size.height=self.brandEntityArry.count*200;  //改变brandTableView的高度
        self.brandTableView.frame=rect;
     
       //   LDDLog(@" 团购数据frame:%@",NSStringFromCGSize(self.mainScrollView.contentSize));

        [self.brandTableView reloadData];//刷新表格数据
        
    } failure:^(NSError *error) {
        LDDLog(@"error:%@",error);
    }];

  
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView==self.productTableView) {
        return 170;
    }else  return 200;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView==self.productTableView) {
        return self.productEntityArry.count;
    }else {
        return self.brandEntityArry.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView==self.productTableView) {
        LDProductTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"product"];
        if (!cell) {
            cell=[[LDProductTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"product"];
            cell.productEntiy=self.productEntityArry[indexPath.row];//将取到的数据赋值给model
           // NSLog(@"product_title:%@",cell.productEntiy.title);
        }
        return cell;
        
          }else{
              LDBrandTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"brand"];
              if (!cell) {
                  cell=[[LDBrandTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"brand"];
                  cell.brandEntity=self.brandEntityArry[indexPath.row];
              }
              return cell;
    }
   
}


//滑动时，固定2按钮
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offsetY=scrollView.contentOffset.y;
    if (offsetY>230) {
        CGRect rect=self.buttonSwitchView.frame;
        rect.origin.y=offsetY;
        self.buttonSwitchView.frame=rect;
        
    }else {
        CGRect rect=self.buttonSwitchView.frame;
        rect.origin.y=230;
        self.buttonSwitchView.frame=rect;
        
    }
    
    
}





@end
