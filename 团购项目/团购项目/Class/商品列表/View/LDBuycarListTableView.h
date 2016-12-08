//
//  LDBuycarListTableView.h
//  团购项目
//
//  Created by Ringo on 2016/12/5.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^returnChangeDataBlcok)();
typedef void(^returnChangeNumBlcok)();
typedef void(^changeSelectAllBlcok)();
typedef void(^changeSelectBlcok)();


@interface LDBuycarListTableView : UITableView
@property(nonatomic,strong)NSMutableArray *buycarListData;//用于接收购物车请求返回的数据

@property(nonatomic,copy)returnChangeDataBlcok changeDataBlcok;//修改controller中数据

@property(copy,nonatomic)returnChangeNumBlcok changeNumBlcok;//修改btn上的数量

@property(copy,nonatomic)changeSelectAllBlcok selectAllBlcok;

@property(copy,nonatomic)changeSelectBlcok selectBlcok;
@property(assign,nonatomic)NSInteger selectCount;

@end
