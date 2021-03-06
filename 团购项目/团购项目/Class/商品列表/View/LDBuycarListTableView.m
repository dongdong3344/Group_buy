//
//  LDBuycarListTableView.m
//  团购项目
//
//  Created by Ringo on 2016/12/5.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import "LDBuycarListTableView.h"
#import "LDBuyCarTableViewCell.h"
#import "LDBuyCarEntity.h"
@interface LDBuycarListTableView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation LDBuycarListTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self=[super initWithFrame:frame style:style];
    if (self) {
        self.separatorInset=UIEdgeInsetsMake(0, 43, 0, 0);
        self.backgroundColor=RGBCOLOR(242, 242, 242);
        self.dataSource=self;
        self.delegate=self;
        self.bounces=NO;
        self.tableFooterView = [[UIView alloc] init];//去除UITableView底部多余行及分割线
    }
    return self;
}



/***setter更新表格数据***/
-(void)setBuycarListData:(NSMutableArray *)buycarListData{
    _buycarListData =buycarListData;
    for (LDBuyCarEntity *buyCarEntity in self.buycarListData) {
        [buyCarEntity setIsSelectButton:NO];//设置所有商品未选中
        [buyCarEntity setIsSelectAllButton:NO];
    }
    
    [self reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WITH, 20)];
    UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.opaque = NO;
    headerLabel.textColor = [UIColor blackColor];
    headerLabel.highlightedTextColor = [UIColor blackColor];
    headerLabel.font = [UIFont systemFontOfSize:14];
    headerLabel.frame = CGRectMake(17, 0, SCREEN_WITH, 20);
    headerLabel.text = @"普通商品";
    [customView addSubview:headerLabel];
    return customView;
}


//设置高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

//表格个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.buycarListData.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LDBuyCarTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (!cell) {
        cell=[[LDBuyCarTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
        cell.selectionStyle= UITableViewCellSelectionStyleNone; //选中cell时无色

    }
    cell.buycarEntity=self.buycarListData[indexPath.row];
    cell.tag=1000+indexPath.row;//cell tag
    
    [cell.plusBtn addTarget:self action:@selector(addBuyCount:) forControlEvents:UIControlEventTouchUpInside];
    [cell.minusBtn addTarget:self action:@selector(minusdBuyCount:) forControlEvents:UIControlEventTouchUpInside];
    [cell.isSelectedBtn addTarget:self action:@selector(selectTheGoods:) forControlEvents:UIControlEventTouchUpInside];
    //不显示最后一行的分割线
    if (indexPath.row ==self.buycarListData.count-1) {
        cell.separatorInset = UIEdgeInsetsMake(0, self.bounds.size.width, 0, 0);
    }

    return cell;
    
}
/***增加购买数量方法***/
-(void)addBuyCount:(UIButton*)sender{
    UIView *cell=[sender superview];//[sender superview]如果仅一次，可能拿到的不是cell
    NSInteger cellTag=cell.tag-1000;
   // NSLog(@"celltag:%ld",(long)cellTag);
    
    LDBuyCarEntity *buyCarEntity=self.buycarListData[cellTag];

    [buyCarEntity setGoodsCount:buyCarEntity.GoodsCount+1];
    [self reloadData];
    [self changeData];
    [self changeBuyCountNum];
    
    
}
/***减少购买数量方法***/
-(void)minusdBuyCount:(UIButton*)sender{
    UIView *cell=[sender superview];//[sender superview]如果仅一次，可能拿到的不是cell
    NSInteger cellTag=cell.tag-1000;
    //NSLog(@"celltag:%ld",(long)cellTag);
    
    LDBuyCarEntity *buyCarEntity=self.buycarListData[cellTag];
   
    if (buyCarEntity.GoodsCount>1) {
        [buyCarEntity setGoodsCount:buyCarEntity.GoodsCount-1];
    }
    [self reloadData];
    [self changeData];//改变购买数字
    [self changeBuyCountNum];//改变去结算按钮上的商品数量
}

/***选中按钮方法***/
-(void)selectTheGoods:(UIButton*)sender{
    
    //sender.selected=!sender.selected;
    
    UIView *cell=[sender superview];
   
    LDBuyCarEntity *buyCarEntity=self.buycarListData[cell.tag-1000];
   

    if (sender.selected) {
        sender.selected=NO;
        [buyCarEntity setIsSelectButton:NO];
        
        self.selectCount--;
        
        if (self.selectAllBlcok) {
            self.selectAllBlcok();//任何一个按钮没有被选中时，全选按钮为未选中状态
        }
        
    }else{
        
        sender.selected=YES;
        [buyCarEntity setIsSelectButton:YES];
        self.selectCount++;
        LDDLog(@"当前被选中的按钮个数: % ld",self.selectCount);
        if (self.selectCount==self.buycarListData.count) {
            if (self.selectBlcok) {
                self.selectBlcok();
            }
        }
        
    }
    
    [self reloadData];
    [self changeData];
    [self changeBuyCountNum];
}


-(void)changeBuyCountNum{
    if (self.changeNumBlcok) {
        self.changeNumBlcok();
    }
  
}

-(void)changeData{
    if (self.changeDataBlcok) {
        self.changeDataBlcok();
    }
}

/***设置左滑删除按钮***/
-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    UITableViewRowAction *deleteAction=[UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        LDBuyCarEntity *buyCarEntity=self.buycarListData[indexPath.row];
        [buyCarEntity setGoodsCount:0];
        [self changeData];
        [self.buycarListData removeObjectAtIndex:indexPath.row];//移除数据源
        [self deleteRowsAtIndexPaths:@[indexPath]withRowAnimation:UITableViewRowAnimationAutomatic];//删除表格
    }];
    
    return @[deleteAction];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}


@end
