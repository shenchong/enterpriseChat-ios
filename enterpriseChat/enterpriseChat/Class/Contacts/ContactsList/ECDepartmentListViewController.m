//
//  ECDepartmentListViewController.m
//  enterpriseChat
//
//  Created by dujiepeng on 15/8/18.
//  Copyright © 2015年 easemob. All rights reserved.
//

#import "ECDepartmentListViewController.h"
#import "ECContactListCellModel.h"
#import "ECContactModel.h"
#import "ECContactListCell.h"

@interface ECDepartmentListViewController () <UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate>
@property (nonatomic, strong) ECDepartmentModel *departmentModel;
@property (nonatomic, strong) NSMutableArray *datasource;
@end

@implementation ECDepartmentListViewController

+ (id)departmentListWithDepartment:(ECDepartmentModel *)departmentModel{
    ECDepartmentListViewController *departmentListView = [[ECDepartmentListViewController alloc]
                                                          initWithDepartment:departmentModel];
    return departmentListView;
}

-(instancetype)initWithDepartment:(ECDepartmentModel *)departmentModel{
    if (self = [super init]) {
        self.departmentModel = departmentModel;
        self.hidesBottomBarWhenPushed = YES;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 64;
    }else {
        NSArray *cellModels = [self.datasource objectAtIndex:[indexPath section]];
        return [ECContactListCellModel heightForRowFromModel:[cellModels objectAtIndex:indexPath.row]];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return ((NSArray *)[self.datasource objectAtIndex:section]).count;
}

- (NSInteger)numberOfSectionsInTableView:(nonnull UITableView *)tableView{
    return self.datasource.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        ECDepartmentListViewController *viewController = [ECDepartmentListViewController departmentListWithDepartment:nil];
        [self.navigationController pushViewController:viewController animated:YES];
    }else {
        
    }
}

- (CGFloat)tableView:(nonnull UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else {
        return 20;
    }
}

@end
