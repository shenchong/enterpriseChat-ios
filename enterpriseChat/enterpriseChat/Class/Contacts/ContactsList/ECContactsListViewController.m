//
//  ECContactsListViewController.m
//  enterpriseChat
//
//  Created by dujiepeng on 15/7/29.
//  Copyright (c) 2015年 easemob. All rights reserved.
//

#import "ECContactsListViewController.h"
#import "ECContactListCellModel.h"
#import "ECContactListCell.h"
#import "ECDepartmentListViewController.h"
#import "ECContactModel.h"
@interface ECContactsListViewController () <UITableViewDelegate,UITableViewDataSource>
@end

@implementation ECContactsListViewController

-(void)viewDidLoad {
    self.isNeedSearch = YES;
    [super viewDidLoad];
    ECContactListCellModel *easeModel = [[ECContactListCellModel alloc] init];
    ECContactModel *model = [[ECContactModel alloc] init];
    model.contactPlaceholderImage = [UIImage imageNamed:@"department"];
    model.contactNickname = @"环信";
    easeModel.contactDelegate = model;
    
    ECContactListCellModel *departModel = [[ECContactListCellModel alloc] init];
    model = [[ECContactModel alloc] init];
    model.contactPlaceholderImage = [UIImage imageNamed:@"department"];
    model.contactNickname = @"群组";
    departModel.contactDelegate = model;
    
    [self.datasource addObject:@[easeModel,departModel]];
    // for test
    NSMutableArray *testAry = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; i++) {
        ECContactModel *contactModel = [[ECContactModel alloc] init];
        contactModel.contactNickname = @"名字很长名字很长名字很长名字很长名字很长名字很长名字很长";
        contactModel.contactEid = [NSString stringWithFormat:@"我是eid %d",i];
        contactModel.contactHeadImagePath = @"http://img0.bdstatic.com/img/image/chongwu0727.jpg";
        ECContactListCellModel *model = [[ECContactListCellModel alloc] init];
        model.contactDelegate = contactModel;
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
        ECContactListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ECContactListCell"];
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:@"ECContactListCell" bundle:nil]
            forCellReuseIdentifier:@"ECContactListCell"];
            cell = [tableView dequeueReusableCellWithIdentifier:@"ECContactListCell"];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        NSArray *cellModels = [self.datasource objectAtIndex:[indexPath section]];
        cell.cellModel = [cellModels objectAtIndex:indexPath.row];
        
        return cell;
    }else {
        ECContactListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ECContactListCell"];
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:@"ECContactListCell" bundle:nil]
            forCellReuseIdentifier:@"ECContactListCell"];
            cell = [tableView dequeueReusableCellWithIdentifier:@"ECContactListCell"];
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
        return [ECContactListCellModel heightForRowFromModel:[cellModels objectAtIndex:indexPath.row]];
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
