//
//  ECContactsListViewController.m
//  enterpriseChat
//
//  Created by dujiepeng on 15/7/29.
//  Copyright (c) 2015年 easemob. All rights reserved.
//

#import "ECContactsListViewController.h"
#import "ECFriendListCellModel.h"
#import "ECFriendListCell.h"

#import "ECDepartmentListViewController.h"

@interface ECContactsListViewController () <UITableViewDelegate,UITableViewDataSource>
@end

@implementation ECContactsListViewController

-(void)viewDidLoad {
    self.isNeedSearch = YES;
    [super viewDidLoad];
    ECFriendListCellModel *model = [[ECFriendListCellModel alloc] init];
    model.headerRemotePath = @"http://img0.bdstatic.com/img/image/chongwu0727.jpg";
    model.eid = @"我是eid";
    model.nickname = @"环信";
    [self.datasource addObject:@[model]];
    // for test
    NSMutableArray *testAry = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; i++) {
        ECFriendListCellModel *model = [[ECFriendListCellModel alloc] init];
        model.headerRemotePath = @"http://img0.bdstatic.com/img/image/chongwu0727.jpg";
        model.eid = @"我是eid";
        model.nickname = @"名字很长名字很长名字很长名字很长名字很长名字很长名字很长";
        [testAry addObject:model];
    }
    
    [self.datasource addObject:testAry];
}

#pragma mark - rewrite superClass
-(UIBarButtonItem *)rightBarButtonItem{
    return [[UIBarButtonItem alloc] initWithTitle:@"test"
                                            style:UIBarButtonItemStyleDone
                                           target:nil
                                           action:nil];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        ECFriendListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ECFriendListCell"];
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:@"ECFriendListCell" bundle:nil]
            forCellReuseIdentifier:@"ECFriendListCell"];
            cell = [tableView dequeueReusableCellWithIdentifier:@"ECFriendListCell"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        NSArray *cellModels = [self.datasource objectAtIndex:[indexPath section]];
        cell.cellModel = [cellModels objectAtIndex:indexPath.row];
        
        return cell;
    }else {
        ECFriendListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ECFriendListCell"];
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:@"ECFriendListCell" bundle:nil]
            forCellReuseIdentifier:@"ECFriendListCell"];
            cell = [tableView dequeueReusableCellWithIdentifier:@"ECFriendListCell"];
        }
        NSArray *cellModels = [self.datasource objectAtIndex:[indexPath section]];
        cell.cellModel = [cellModels objectAtIndex:indexPath.row];
        
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 64;
    }else {
        NSArray *cellModels = [self.datasource objectAtIndex:[indexPath section]];
        return [ECFriendListCellModel heightForRowFromModel:[cellModels objectAtIndex:indexPath.row]];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return ((NSArray *)[self.datasource objectAtIndex:section]).count;
}

-(NSInteger)numberOfSectionsInTableView:(nonnull UITableView *)tableView{
    return self.datasource.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        ECDepartmentListViewController *departmentListVC = [[ECDepartmentListViewController alloc] init];
        departmentListVC.title = @"环信";
        [self.navigationController pushViewController:departmentListVC animated:YES];
    }else {
    
    }
}

-(CGFloat)tableView:(nonnull UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else {
        return 20;
    }
}

@end
