//
//  ECDepartmentListViewController.m
//  enterpriseChat
//
//  Created by dujiepeng on 15/8/18.
//  Copyright © 2015年 easemob. All rights reserved.
//

#import "ECDepartmentListViewController.h"

@interface ECDepartmentListViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation ECDepartmentListViewController

- (void)viewDidLoad {
    self.isNeedSearch = YES;
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
