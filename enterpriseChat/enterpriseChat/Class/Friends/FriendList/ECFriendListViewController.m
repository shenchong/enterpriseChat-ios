//
//  ECFriendListViewController.m
//  enterpriseChat
//
//  Created by dujiepeng on 15/7/29.
//  Copyright (c) 2015年 easemob. All rights reserved.
//

#import "ECFriendListViewController.h"
#import "ECFriendListCellModel.h"
#import "ECFriendListCell.h"

@interface ECFriendListViewController () <UITableViewDelegate,UITableViewDataSource>
@end

@implementation ECFriendListViewController

-(void)viewDidLoad {
    self.isNeedSearch = YES;
    [super viewDidLoad];
    // for test
    for (int i = 0; i < 10; i++) {
        ECFriendListCellModel *model = [[ECFriendListCellModel alloc] init];
        model.headerRemotePath = @"http://img0.bdstatic.com/img/image/chongwu0727.jpg";
        model.eid = @"我是eid";
        model.nickname = @"名字很长名字很长名字很长名字很长名字很长名字很长名字很长";
        [self.datasource addObject:model];
    }
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ECFriendListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ECFriendListCell"];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"ECFriendListCell" bundle:nil]
        forCellReuseIdentifier:@"ECFriendListCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"ECFriendListCell"];
    }
    cell.cellModel = [self.datasource objectAtIndex:[indexPath row]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [ECFriendListCellModel heightForRowFromModel:[self.datasource objectAtIndex:[indexPath row]]];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasource.count;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
