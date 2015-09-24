//
//  ECDepartmentListViewController.m
//  enterpriseChat
//
//  Created by dujiepeng on 15/8/18.
//  Copyright © 2015年 easemob. All rights reserved.
//

#import "ECDepartmentListViewController.h"
#import "ECContactModel.h"
#import "ECContactListCell.h"
#import "ECDepartmentListCell.h"
#import "ECDBManager.h"

@interface ECDepartmentListViewController () <UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate>
@property (nonatomic, strong) ECDepartmentModel *departmentModel;
@property (nonatomic, strong) NSMutableArray *datasource;
@property (nonatomic, strong) NSMutableArray *departments;
@property (nonatomic, strong) NSMutableArray *members;
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

- (void)setupDatasoure{
    NSArray *departments = [[ECDBManager sharedInstance] loadDepartmentsWithIds:self.departmentModel.departmentSubIds
                                                                   loginAccount:@"6001"];
    NSArray *members = [[ECDBManager sharedInstance] loadContactsWithIds:self.departmentModel.deparementMembers
                                                            loginAccount:@"6001"];
    if (departments && departments.count > 0) {
        [self.datasource addObject:departments];
    }
    
    if (members && members.count > 0) {
        [self.datasource addObject:members];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDatasoure];
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSMutableArray *)datasource{
    if (!_datasource) {
        _datasource = [[NSMutableArray alloc] init];
    }
    
    return _datasource;
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        ECDepartmentListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ECDepartmentListCell"];
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:@"ECDepartmentListCell" bundle:nil]
            forCellReuseIdentifier:@"ECDepartmentListCell"];
            cell = [tableView dequeueReusableCellWithIdentifier:@"ECDepartmentListCell"];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        NSArray *cellModels = [self.datasource objectAtIndex:[indexPath section]];
        cell.departmentModel = [cellModels objectAtIndex:indexPath.row];
        return cell;
    }else {
        ECContactListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ECContactListCell"];
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:@"ECContactListCell" bundle:nil]
            forCellReuseIdentifier:@"ECContactListCell"];
            cell = [tableView dequeueReusableCellWithIdentifier:@"ECContactListCell"];
        }
        NSArray *cellModels = [self.datasource objectAtIndex:[indexPath section]];
        cell.contactModel = [cellModels objectAtIndex:indexPath.row];
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64;
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
        ECDepartmentModel *department = [[self.datasource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        ECDepartmentListViewController *viewController = [ECDepartmentListViewController departmentListWithDepartment:department];
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
