//
//  LDTableView.m
//  团购项目
//
//  Created by Ringo on 2016/11/28.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import "LDTableView.h"
#import "LDBrandTableViewCell.h"
#import "LDProductTableViewCell.h"
@interface LDTableView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation LDTableView

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self=[super initWithFrame:frame style:style];
    if (self) {
        self.delegate=self;
        self.dataSource=self;
        self.bounces=NO;
    }
    return self;
}


-(void)setBrandEntityArry:(NSArray *)brandEntityArry{
    _brandEntityArry=brandEntityArry;
    [self reloadData];
}

-(void)setProductEntityArry:(NSArray *)productEntityArry{
    _productEntityArry=productEntityArry;
      [self reloadData];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.isProductTableView) {
        return 170;
    }else  return 200;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.isProductTableView) {
        return self.productEntityArry.count;
    }else {
        return self.brandEntityArry.count;
    }
  
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.isProductTableView) {
        LDProductTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"product"];
        if (!cell) {
            cell=[[LDProductTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"product"];
            cell.productEntiy=self.productEntityArry[indexPath.row];//将取到的数据赋值给model
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.isProductTableView) {
        if (self.goodsIDBlcok) {
            _goodsIDBlcok([self.productEntityArry[indexPath.row] GoodsId]);
        }
    }
    
}






@end
