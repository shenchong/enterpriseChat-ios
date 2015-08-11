//
//  ECChatListViewController.m
//  enterpriseChat
//
//  Created by dujiepeng on 15/7/29.
//  Copyright (c) 2015年 easemob. All rights reserved.
//

#import "ECChatListViewController.h"
#import "ECChatListCell.h"
#import "ECChatListCellModel.h"

@interface ECChatListViewController () <UITableViewDelegate,UITableViewDataSource>
@end

@implementation ECChatListViewController

-(void)viewDidLoad{
    self.isNeedSearch = YES;
    [super viewDidLoad];
    //for test
    for (int i = 0; i < 1000; i++) {
        ECChatListCellModel *model = [[ECChatListCellModel alloc] init];
        model.headerRemotePath = @"http://img0.bdstatic.com/img/image/chongwu0727.jpg";
//        model.nickname = @"名字很长名字很长名字很长名字很长名字很长名字很长名字很长";
        model.eid = [NSString stringWithFormat:@"我是eid %d",i];
        model.time = @"2015-07-30";
        model.msgInfo = @"请问这个鞋子什么时候能到货？发什么快递？请问这个鞋子什么时候能到货？发什么快递？";
        [self.datasource addObject:model];
    }
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ECChatListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ECChatListCell"];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"ECChatListCell" bundle:nil]
        forCellReuseIdentifier:@"ECChatListCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"ECChatListCell"];
    }
    cell.cellModel = [self.datasource objectAtIndex:[indexPath row]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [ECChatListCellModel heightForRowFromModel:[self.datasource objectAtIndex:[indexPath row]]];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasource.count;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ECChatListCellModel *model = [self.datasource objectAtIndex:indexPath.row];
    NSLog(@"showName -- %@",model.showName);
}

@end


