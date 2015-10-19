//
//  ECChatListViewController.m
//  enterpriseChat
//
//  Created by dujiepeng on 15/7/29.
//  Copyright (c) 2015年 easemob. All rights reserved.
//

#import "ECChatListViewController.h"
#import "ECChatListCell.h"
#import "ECContactModel.h"
#import "KxMenu.h"
#import "ECChatViewController.h"

#define MENU_POPOVER_FRAME  CGRectMake(8, 0, 140, 188)

@interface ECChatListViewController () <UITableViewDelegate,UITableViewDataSource,IChatManagerDelegate>

@property(nonatomic,strong) NSArray *menuItems;
//@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation ECChatListViewController

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        _datasource = [NSMutableArray array];
//    }
//    return self;
//}

- (void)viewDidLoad{
    self.isNeedSearch = YES;
    self.barHiddenWhenSearch = YES;
    [super viewDidLoad];
    //for test
//    
//    for (int i = 0; i < 1000; i++) {
//        ECContactModel *contactModel = [[ECContactModel alloc] init];
//        contactModel.eid = [NSString stringWithFormat:@"我是eid %d",i];
//        contactModel.headImagePath = @"http://img0.bdstatic.com/img/image/chongwu0727.jpg";
//        ECChatListCellModel *model = [[ECChatListCellModel alloc] init];
//        model.contactDelegate = contactModel;
//        model.time = @"2015-07-30";
//        model.msgInfo = @"请问这个鞋子什么时候能到货？发什么快递？请问这个鞋子什么时候能到货？发什么快递？";
//        model.unreadCount = 1000;
//        [self.datasource addObject:model];
//    }
    [self setupBadgeValue:@"1"];
    
    [[EaseMob sharedInstance].chatManager loadAllConversationsFromDatabaseWithAppend2Chat:NO];
    [self removeEmptyConversationsFromDB];
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self refreshDataSource];
    [self registerNotifications];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self unregisterNotifications];
}

- (void)removeEmptyConversationsFromDB
{
    NSArray *conversations = [[EaseMob sharedInstance].chatManager conversations];
    NSMutableArray *needRemoveConversations;
    for (EMConversation *conversation in conversations) {
        if (!conversation.latestMessage || (conversation.conversationType == eConversationTypeChatRoom)) {
            if (!needRemoveConversations) {
                needRemoveConversations = [[NSMutableArray alloc] initWithCapacity:0];
            }
            
            [needRemoveConversations addObject:conversation.chatter];
        }
    }
    
    if (needRemoveConversations && needRemoveConversations.count > 0) {
        [[EaseMob sharedInstance].chatManager removeConversationsByChatters:needRemoveConversations
                                                             deleteMessages:YES
                                                                append2Chat:NO];
    }
}

- (void)removeChatroomConversationsFromDB
{
    NSArray *conversations = [[EaseMob sharedInstance].chatManager conversations];
    NSMutableArray *needRemoveConversations;
    for (EMConversation *conversation in conversations) {
        if (conversation.conversationType == eConversationTypeChatRoom) {
            if (!needRemoveConversations) {
                needRemoveConversations = [[NSMutableArray alloc] initWithCapacity:0];
            }
            
            [needRemoveConversations addObject:conversation.chatter];
        }
    }
    
    if (needRemoveConversations && needRemoveConversations.count > 0) {
        [[EaseMob sharedInstance].chatManager removeConversationsByChatters:needRemoveConversations
                                                             deleteMessages:YES
                                                                append2Chat:NO];
    }
}


#pragma mark - private

- (NSMutableArray *)loadDataSource
{
    NSMutableArray *ret = nil;
    NSArray *conversations = [[EaseMob sharedInstance].chatManager conversations];
    
    NSArray* sorte = [conversations sortedArrayUsingComparator:
                      ^(EMConversation *obj1, EMConversation* obj2){
                          EMMessage *message1 = [obj1 latestMessage];
                          EMMessage *message2 = [obj2 latestMessage];
                          if(message1.timestamp > message2.timestamp) {
                              return(NSComparisonResult)NSOrderedAscending;
                          }else {
                              return(NSComparisonResult)NSOrderedDescending;
                          }
                      }];
    
    ret = [[NSMutableArray alloc] initWithArray:sorte];
    return ret;
}


#pragma mark - rewrite superClass
- (UIBarButtonItem *)rightBarButtonItem{
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                        target:self
                                                                                        action:@selector(addChat:)];
    rightBarButtonItem.tintColor = [UIColor blackColor];
    return rightBarButtonItem;
}

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
    ECChatViewController *chatVC = [[ECChatViewController alloc] initWithConversation:nil];
    [self.navigationController pushViewController:chatVC animated:YES];
}

- (void)createGroupChat{
    DLog(@"create Group Chat");
}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ECChatListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ECChatListCell"];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"ECChatListCell" bundle:nil]
        forCellReuseIdentifier:@"ECChatListCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"ECChatListCell"];
    }
    cell.conversationModel = [self.datasource objectAtIndex:[indexPath row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasource.count;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - IChatMangerDelegate

-(void)didUnreadMessagesCountChanged
{
    [self refreshDataSource];
}

- (void)didUpdateGroupList:(NSArray *)allGroups error:(EMError *)error
{
    [self refreshDataSource];
}

- (void)didReceiveOfflineMessages:(NSArray *)offlineMessages
{
    [self refreshDataSource];
}

- (void)didReceiveMessage:(EMMessage *)message{
    
}

#pragma mark - registerNotifications
-(void)registerNotifications{
    [self unregisterNotifications];
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
}

-(void)unregisterNotifications{
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
}

- (void)dealloc{
    [self unregisterNotifications];
}

#pragma mark - public

- (void)refreshDataSource
{
    self.datasource = [self loadDataSource];
    [self.tableView reloadData];
//    [self hideHud];
}

@end


