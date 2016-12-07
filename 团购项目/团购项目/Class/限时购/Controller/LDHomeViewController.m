//
//  LDTimeViewController.m
//  团购项目
//
//  Created by Ringo on 2016/11/14.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import "LDHomeViewController.h"
#import "LDProductEntity.h"
#import "LDBrandEntity.h"
#import "LDButtonSwitchView.h"
#import "LDTableView.h"
#import "LDDetailViewController.h"
#import "LDCategoryViewController.h"

#import "LDGoodsListViewController.h"
#import "LDGoodsListEntity.h"

#define PRODUCT_CELL_WIDTH 170
#define BRAND_CELL_WIDTH 200

@interface LDHomeViewController ()<UIScrollViewDelegate,PYSearchViewControllerDelegate,UISearchBarDelegate>
@property(strong,nonatomic)UIScrollView *mainScrollView;
@property(strong,nonatomic)SDCycleScrollView *cycleScrollView;
@property(strong,nonatomic)LDTableView *productTableView,*brandTableView;
@property(strong,nonatomic)LDButtonSwitchView *buttonSwitchView;
@property(strong,nonatomic)NSArray *productEntityArry;//存放新品数据模型的数组
@property(strong,nonatomic)NSArray *brandEntityArry;//存放品牌数据模型的数组
@property(strong,nonatomic)UISearchBar *mySearchBar;
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
    [self getCycleImages];
    [self getProducts];
    [self getBrands];
    [self addUIbarbuttonItems];
}


-(void)addUIbarbuttonItems{
    //搜索按钮
    UIButton *rightItemBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    rightItemBtn.frame=CGRectMake(0, 0, 30, 30);
    [rightItemBtn setImage:[UIImage imageNamed:@"home_title_search1"] forState:UIControlStateNormal];
    [rightItemBtn setImage:[UIImage imageNamed:@"home_title_search"] forState:UIControlStateHighlighted];
    [rightItemBtn addTarget:self action:@selector(presentSearchVC) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithCustomView:rightItemBtn];
    self.navigationItem.rightBarButtonItem=rightItem;
   
    //分类按钮
    UIButton *leftItemBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    leftItemBtn.frame=CGRectMake(0, 0, 30, 30);
    [leftItemBtn setImage:[UIImage imageNamed:@"home_title_menu1"] forState:UIControlStateNormal];
    [leftItemBtn setImage:[UIImage imageNamed:@"home_title_menu"] forState:UIControlStateHighlighted];
    [leftItemBtn addTarget:self action:@selector(pushToCategoryVC) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithCustomView:leftItemBtn];
    self.navigationItem.leftBarButtonItem=leftItem;
    
    //titleView
    UIImageView *image=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tmmarket_today_crazy_title"]];
    image.frame=CGRectMake(0, 0, 90, 40);
    self.navigationItem.titleView=image;
   
}
//跳转至分类
-(void)pushToCategoryVC{
    
    self.tabBarController.selectedIndex=1;//直接跳转至分类页面
    
}

//跳转至搜索控制器
-(void)presentSearchVC{

        NSArray *hotSeaches = @[@"美白",@"保湿",@"护理", @"补水",@"面膜",@"眼霜",@"水乳",@"口腔",@"化妆品",@"面部精华"];
   
        PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"请输入搜索关键字" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
            
            [self postWithURLString:@"appSearch/searchList.do" parameters:@{@"search":searchBar.text,@"OrderName":@"host",@"OrderType":@"Desc"} success:^(id responseObject) {
            NSArray *goodsListArry=[LDGoodsListEntity mj_objectArrayWithKeyValuesArray:responseObject];//取得模型数组
           
            /***网络请求成功后再跳转***/
            LDGoodsListViewController *goodsListVC=[[LDGoodsListViewController alloc]init];
            goodsListVC.title=searchBar.text;//标题是search搜索框内的文字
            goodsListVC.goodsListEntityArray=goodsListArry;
           
            [self.navigationController pushViewController:goodsListVC animated:YES];
            [self dismissViewControllerAnimated:NO completion:nil];
    
            if (goodsListArry.count==0) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [goodsListVC.view makeToast:@"抱歉，目前库内无此商品!" duration:1.5 position:@"CSToastPositionCenter"];
                });
                
            }
        } failure:^(NSError *error) {
            
        }];
        
    }];
    
    searchViewController.delegate = self;
 
    searchViewController.searchHistoryStyle = PYHotSearchStyleDefault; // 搜索历史风格
    searchViewController.hotSearchStyle = PYHotSearchStyleColorfulTag; // 热门搜索风格为默认
    //设置取消按钮样式
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 40, 25);
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(backToHomeVC) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithCustomView:btn];
    searchViewController.navigationItem.rightBarButtonItem=rightItem;
    
    //跳转至搜索控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    [self presentViewController:nav animated:NO completion:nil];


}

-(void)backToHomeVC{

    [self dismissViewControllerAnimated:YES completion:nil];

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

//轮播图
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
        [_buttonSwitchView.brandBtn addTarget:self action:@selector(changeTableView:) forControlEvents:UIControlEventTouchUpInside];
        [_buttonSwitchView.productBtn addTarget:self action:@selector(changeTableView:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buttonSwitchView;
 
}

//按钮切换不同的表格
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

//新品团购
-(LDTableView *)productTableView{
    
    if (!_productTableView) {
        _productTableView=[[LDTableView alloc]initWithFrame:CGRectMake(0, 280, SCREEN_WITH, self.productEntityArry.count*PRODUCT_CELL_WIDTH) style:UITableViewStylePlain];
  
        _productTableView.isProductTableView=YES;
        __weak typeof(self) weakself=self;
        //接收block
        _productTableView.goodsIDBlcok=^(NSString *goodsID){
            LDDetailViewController *detailVC=[[LDDetailViewController alloc]init];
            detailVC.detailGoodsID=goodsID;
            [weakself.navigationController pushViewController:detailVC animated:YES];
            
        };

           }
    return _productTableView;
}

//品牌团购
-(LDTableView *)brandTableView{
    
    if (!_brandTableView) {
        _brandTableView=[[LDTableView alloc]initWithFrame:CGRectMake(SCREEN_WITH, 280, SCREEN_WITH, self.brandEntityArry.count*BRAND_CELL_WIDTH) style:UITableViewStylePlain]; //注意是orgin.x=SCREEN_WITH,如果写成0 ，则页面加载时，会先显示brandTableView
        _brandTableView.isProductTableView=NO;

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

        self.productEntityArry=[LDProductEntity  mj_objectArrayWithKeyValuesArray:responseObject];
        self.productTableView.productEntityArry=self.productEntityArry;
        CGRect  rect=self.productTableView.frame;
        rect.size.height=self.productEntityArry.count*170;  //改变productTableView的高度
        self.productTableView.frame=rect;
        [self.productTableView reloadData];
    } failure:^(NSError *error) {
         LDDLog(@"error:%@",error);
    }];
}


//请求品牌团购数据
-(void)getBrands{
     //  http://123.57.141.249:8080/beautalk/appActivity/appActivityList.do
       [self getWithURLString:@"appActivity/appActivityList.do" parameters:nil success:^(id responseObject) {
        self.brandEntityArry=[LDBrandEntity mj_objectArrayWithKeyValuesArray:responseObject];//拿到字典数组
        self.brandTableView.brandEntityArry=self.brandEntityArry;
        CGRect rect=self.brandTableView.frame;
        rect.size.height=self.brandEntityArry.count*200;  //改变brandTableView的高度
        self.brandTableView.frame=rect;
        [self.brandTableView reloadData];
     } failure:^(NSError *error) {
        LDDLog(@"error:%@",error);
    }];
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

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title=@"首页";
    self.navigationController.navigationBar.translucent=NO;//设置不透明
    self.navigationController.navigationBar.barTintColor=RGBCOLOR(55, 158, 222);
    
}



@end
