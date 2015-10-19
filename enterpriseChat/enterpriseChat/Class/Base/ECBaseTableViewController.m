//
//  ECBaseTableViewController.m
//  enterpriseChat
//
//  Created by dujiepeng on 15/7/29.
//  Copyright (c) 2015年 easemob. All rights reserved.
//

#import "ECBaseTableViewController.h"
#import "RealtimeSearchUtil.h"
#import "UIScrollView+EmptyDataSet.h"

@interface ECBaseTableViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@property (nonatomic, strong) NSMutableArray *tempDatasource;
@property (nonatomic, strong) UISearchBar *searchBar;
@end

@implementation ECBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    if (self.isNeedSearch) {
        self.tableView.tableHeaderView = self.searchController.searchBar;
        self.searchController.barHiddenWhenSearch = self.barHiddenWhenSearch;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = @"test";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 54;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
    }
}


#pragma mark - searchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    __weak typeof(self) weakSelf = self;
    [[RealtimeSearchUtil currentUtil] realtimeSearchWithSource:self.tempDatasource
                                                    searchText:(NSString *)searchText
                                                   resultBlock:^(NSArray *results)
     {
         if (results) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 [weakSelf.datasource removeAllObjects];
                 [weakSelf.datasource addObjectsFromArray:results];
                 weakSelf.searchController.resultsSource = [self.datasource copy];
                 [weakSelf.searchController.searchResultsTableView reloadData];
             });
         }
     }];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    if (!self.barHiddenWhenSearch) {
        self.tempDatasource = [self.datasource mutableCopy];
    }
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    if (!self.barHiddenWhenSearch) {
        self.datasource = [self.tempDatasource mutableCopy];
    }
    return YES;
}


#pragma mark - DZNEmptyDataSetSource & DZNEmptyDataSetDelegate
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *imageName = @"欢迎使用企信透明";
    
    return [UIImage imageNamed:imageName];
}

#pragma mark - getter
- (UISearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] init];
        _searchBar.delegate = self;
    }
    
    return _searchBar;
}

- (EMSearchDisplayController *)searchDisplayController{
    if (!_searchController) {
        __weak typeof(self) weakSelf = self;
        _searchController = [[EMSearchDisplayController alloc] initWithSearchBar:self.searchBar
                                                              contentsController:self];
        [_searchController setCellForRowAtIndexPathCompletion:^UITableViewCell *(UITableView *tableView,
                                                                                 NSIndexPath *indexPath)
         {
             return [weakSelf tableView:tableView cellForRowAtIndexPath:indexPath];
         }];
        
        [_searchController setHeightForRowAtIndexPathCompletion:^CGFloat(UITableView *tableView,
                                                                         NSIndexPath *indexPath)
         {
             return [weakSelf tableView:tableView heightForRowAtIndexPath:indexPath];
         }];
        
        [_searchController setDidSelectRowAtIndexPathCompletion:^(UITableView *tableView,
                                                                  NSIndexPath *indexPath)
         {
             [weakSelf tableView:tableView didSelectRowAtIndexPath:indexPath];
         }];
        
        [_searchController setSearchDisplayControllerWillBeginSearch:^(UISearchDisplayController *searchController) {
            weakSelf.tempDatasource = [weakSelf.datasource mutableCopy];
        }];
        
        [_searchController setSearchDisplayControllerDidEndSearch:^(UISearchDisplayController *searchController) {
            weakSelf.datasource = [weakSelf.tempDatasource mutableCopy];
        }];
    }
    
    return _searchController;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.layer.borderWidth = 0;
        _tableView.emptyDataSetSource = self;
        _tableView.emptyDataSetDelegate = self;
    }
    
    return _tableView;
}

#pragma mark - getter
- (NSMutableArray *)datasource{
    if (!_datasource) {
        _datasource = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    return _datasource;
}




@end
