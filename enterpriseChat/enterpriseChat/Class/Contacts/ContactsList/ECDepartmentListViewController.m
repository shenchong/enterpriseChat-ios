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

@interface ECDepartmentListViewController () <UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate, ECScrollViewDelegate>
@property (nonatomic, strong) ECDepartmentModel *departmentModel;
@property (nonatomic, strong) ECScrollView *departScrollView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datasource;
@property (nonatomic, strong) NSMutableArray *departments;
@property (nonatomic, strong) NSMutableArray *members;
@end

@implementation ECDepartmentListViewController

+ (id)departmentListWithDepartment:(ECDepartmentModel *)departmentModel
{
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
    [self.view addSubview:self.tableView];
    self.tableView.top = self.departScrollView.bottom - 30;
    [self setupDatasoure];
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

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                  style:UITableViewStyleGrouped];

        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.layer.borderWidth = 0;
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    
    return _tableView;
}

- (ECScrollView *)departScrollView{
    if (!_departScrollView) {
        _departScrollView = [[ECScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 40)];
        _departScrollView.backgroundColor = [UIColor redColor];
        _departScrollView.ecScrollViewDelegate = self;
        [_departScrollView addItem:self.departmentModel];
    }
    
    return _departScrollView;
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


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return self.departScrollView;
    }
    
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(nonnull UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return self.departScrollView.height;
    }
    
    return 20;
}

- (CGFloat)tableView:(nonnull UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}

-(void)dealloc{
    DLog(@"dealloc");
}


@end
