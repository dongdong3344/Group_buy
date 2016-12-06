//
//  LDBuycarListTableView.h
//  团购项目
//
//  Created by Ringo on 2016/12/5.
//  Copyright © 2016年 omni software. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^returnChangeDataBlcok)();

@interface LDBuycarListTableView : UITableView
@property(nonatomic,strong)NSMutableArray *buycarListData;//用于接收购物车请求返回的数据

@property(nonatomic,copy)returnChangeDataBlcok changeDataBlcok;//修改controller中数据
@end
