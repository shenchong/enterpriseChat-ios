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

@interface ECDepartmentListViewController () <UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate, ECScrollViewDelegate,UISearchBarDelegate>
@property (nonatomic, strong) ECDepartmentModel *departmentModel;
@property (nonatomic, strong) ECScrollView *departScrollView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *datasource;
@property (nonatomic, strong) NSMutableArray *departments;
@property (nonatomic, strong) NSMutableArray *members;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic) NSString *departmentId;
@end

@implementation ECDepartmentListViewController

+ (id)departmentListWithDepartment:(ECDepartmentModel *)departmentModel
{
    ECDepartmentListViewController *departmentListView = [[ECDepartmentListViewController alloc]
                                                          initWithDepartment:departmentModel];
    departmentListView.departmentId = departmentModel.departmentId;
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
    self.tableView.tableHeaderView = self.searchBar;
    [self setupDatasoure];
    [self.departScrollView addItems:self.items];
    [self.departScrollView addItem:self.departmentModel];
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
        _tableView.top +=44;
        _tableView.height += 24;
        _tableView.layer.borderWidth = 0;
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    
    return _tableView;
}

-(UISearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 44)];
        _searchBar.delegate = self;
    }
    
    return _searchBar;
}

- (ECScrollView *)departScrollView{
    if (!_departScrollView) {
        _departScrollView = [[ECScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 40)];
        _departScrollView.backgroundColor = [UIColor whiteColor];
        _departScrollView.ecScrollViewDelegate = self;
        _departScrollView.latestTitleColor = [UIColor blueColor];
        _departScrollView.titleFont = [UIFont systemFontOfSize:15];
    }
    
    return _departScrollView;
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *cellModels = [self.datasource objectAtIndex:[indexPath section]];
    id model = [cellModels objectAtIndex:indexPath.row];
    if ([model isKindOfClass:[ECDepartmentModel class]]) {
        ECDepartmentListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ECDepartmentListCell"];
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:@"ECDepartmentListCell" bundle:nil]
            forCellReuseIdentifier:@"ECDepartmentListCell"];
            cell = [tableView dequeueReusableCellWithIdentifier:@"ECDepartmentListCell"];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.departmentModel = (ECDepartmentModel *)model;
        return cell;
    }else {
        ECContactListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ECContactListCell"];
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:@"ECContactListCell" bundle:nil]
            forCellReuseIdentifier:@"ECContactListCell"];
            cell = [tableView dequeueReusableCellWithIdentifier:@"ECContactListCell"];
        }
        cell.contactModel = (ECContactModel *)model;
        
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
    NSArray *cellModels = [self.datasource objectAtIndex:[indexPath section]];
    id model = [cellModels objectAtIndex:indexPath.row];
    if ([model isKindOfClass:[ECDepartmentModel class]]) {
        ECDepartmentModel *department = [[self.datasource objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        ECDepartmentListViewController *viewController = [ECDepartmentListViewController
                                                          departmentListWithDepartment:department];
        if (self.departScrollView.items && self.departScrollView.items.count > 0) {
            viewController.items = self.departScrollView.items;
        }
        [self.navigationController pushViewController:viewController animated:YES];
    }else{
    
    }
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *scView = [[UIView alloc] initWithFrame:self.departScrollView.bounds];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectZero];
        lineView.height = 0.3;
        lineView.top = self.departScrollView.height;
        lineView.width = self.view.width;
        lineView.backgroundColor = [UIColor lightGrayColor];
        [scView addSubview:self.departScrollView];
        [scView addSubview:lineView];
        return scView;
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

- (void)eCSCrollView:(ECScrollView *)scrollVeiw
      didClickedItem:(NSString *)itemId{
    for (ECDepartmentListViewController *viewController in self.navigationController.viewControllers) {
        if ([viewController.departmentId isEqualToString:itemId]) {
            [self.navigationController popToViewController:viewController animated:YES];
        }
    }
}

#pragma mark - UISearchBarDelegate
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [searchBar setShowsCancelButton:NO];
    [searchBar resignFirstResponder];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    [searchBar setShowsCancelButton:YES];
    return YES;
}
@end
