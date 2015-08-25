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
#import "ECContactModel.h"
#import "KxMenu.h"
#define MENU_POPOVER_FRAME  CGRectMake(8, 0, 140, 188)

@interface ECChatListViewController () <UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) NSArray *menuItems;
@end

@implementation ECChatListViewController

-(void)viewDidLoad{
    self.isNeedSearch = YES;
    [super viewDidLoad];
    //for test
    for (int i = 0; i < 1000; i++) {
        ECContactModel *contactModel = [[ECContactModel alloc] init];
//        contactModel.nickname = @"名字很长名字很长名字很长名字很长名字很长名字很长名字很长";
        contactModel.eid = [NSString stringWithFormat:@"我是eid %d",i];
        contactModel.headImagePath = @"http://img0.bdstatic.com/img/image/chongwu0727.jpg";
        ECChatListCellModel *model = [[ECChatListCellModel alloc] init];
        model.contactModel = contactModel;
        model.time = @"2015-07-30";
        model.msgInfo = @"请问这个鞋子什么时候能到货？发什么快递？请问这个鞋子什么时候能到货？发什么快递？";
        model.unreadCount = 1000;
        [self.datasource addObject:model];
    }
    [self setupBadgeValue:@"1"];
}

#pragma mark - rewrite superClass
-(UIBarButtonItem *)rightBarButtonItem{
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                        target:self
                                                                                        action:@selector(addChat:)];
    rightBarButtonItem.tintColor = [UIColor blackColor];
    return rightBarButtonItem;
}

#pragma mark - getter


#pragma mark - Action
- (void)addChat:(id)sender{
    [KxMenu setTintColor:[UIColor darkGrayColor]];
    NSArray * menuItems = @[[KxMenuItem menuItem:@"发起会话"
                                           image:[UIImage imageNamed:@"menu_item_chat"]
                                          target:self
                                          action:@selector(createSignChat)],
                            [KxMenuItem menuItem:@"发起群聊"
                                           image:[UIImage imageNamed:@"menu_item_groupChat"]
                                          target:self
                                          action:@selector(createGroupChat)]];
    [KxMenu showMenuInView:self.view
                  fromRect:CGRectMake(self.view.bounds.size.width - 24, 64, 1, 1)
                 menuItems:menuItems];
    
}

- (void)createSignChat{
    DLog(@"create Sign Chat");
}

- (void)createGroupChat{
    DLog(@"create Group Chat");
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
}

@end


