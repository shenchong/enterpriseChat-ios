//
//  ECBaseTableViewController.h
//  enterpriseChat
//
//  Created by dujiepeng on 15/7/29.
//  Copyright (c) 2015年 easemob. All rights reserved.
//

#import "ECBaseViewController.h"

@interface ECBaseTableViewController : ECBaseViewController
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datasource;
@property (nonatomic) BOOL isNeedSearch;
@end
