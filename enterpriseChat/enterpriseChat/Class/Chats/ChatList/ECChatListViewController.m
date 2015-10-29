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
#import "NSDate+Category.h"
#import "ConvertToCommonEmoticonsHelper.h"
#import "ChatViewController.h"

#define MENU_POPOVER_FRAME  CGRectMake(8, 0, 140, 188)

@interface ECChatListViewController () <UITableViewDelegate,UITableViewDataSource,IChatManagerDelegate>

@property(nonatomic,strong) NSArray *menuItems;

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
    
//    NSArray *conversations = [[EaseMob sharedInstance].chatManager conversations];
//    for (EMConversation *conversation in conversations) {
//        ECConverstaionModel *model = [[ECConverstaionModel alloc]initWithConversation:conversation];
//        [self.datasource addObject:model];
//    }
//    
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

- (void)loadDataSource
{
//    NSMutableArray *ret = nil;
    NSArray *conversations = [[EaseMob sharedInstance].chatManager conversations];
    
//    NSArray* sorte = [conversations sortedArrayUsingComparator:
//                      ^(EMConversation *obj1, EMConversation* obj2){
//                          EMMessage *message1 = [obj1 latestMessage];
//                          EMMessage *message2 = [obj2 latestMessage];
//                          if(message1.timestamp > message2.timestamp) {
//                              return(NSComparisonResult)NSOrderedAscending;
//                          }else {
//                              return(NSComparisonResult)NSOrderedDescending;
//                          }
//                      }];
    self.datasource = nil;
    
    for (EMConversation *conversation in conversations) {
        ECConverstaionModel *model = [[ECConverstaionModel alloc]initWithConversation:conversation];
        [self.datasource addObject:model];
    }
    
//    ret = [[NSMutableArray alloc] initWithArray:sorte];
//    return ret;
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
    
//    EMConversation *conversation = [self.datasource objectAtIndex:indexPath.row];
//    cell.conversationModel.showName = conversation.chatter;
//    cell.showNameLabel.text = conversation.chatter;
//    
//    cell.conversationModel.msgTime = [self lastMessageTimeByConversation:conversation];
//    cell.timeLabel.text = cell.conversationModel.msgTime;
//    
//    
//    cell.conversationModel.msgInfo = [self subTitleMessageByConversation:conversation];
//    cell.msgInfoLabel.text = cell.conversationModel.msgInfo;
//    
//    cell.conversationModel.unreadCount = [self unreadMessageCountByConversation:conversation];
//    cell.unreadCountLabel.text = [NSString stringWithFormat:@"%ld",(long)cell.conversationModel.unreadCount];
//    
//    cell.conversationModel.headerRemotePath = nil;
//    [cell.headImageView sd_setImageWithURL:[NSURL URLWithString:cell.conversationModel.headerRemotePath]
//                          placeholderImage:[UIImage imageNamed:@"chatListCellHead"]];
    
    cell.conversationModel = [self.datasource objectAtIndex:[indexPath row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasource.count;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    EMConversation *conversation = [[[EaseMob sharedInstance].chatManager conversations] objectAtIndex:indexPath.row];
    

    ChatViewController *chatController;
    NSString *title = conversation.chatter;
    if (conversation.conversationType != eConversationTypeChat) {
        if ([[conversation.ext objectForKey:@"groupSubject"] length])
        {
            title = [conversation.ext objectForKey:@"groupSubject"];
        }
        else
        {
            NSArray *groupArray = [[EaseMob sharedInstance].chatManager groupList];
            for (EMGroup *group in groupArray) {
                if ([group.groupId isEqualToString:conversation.chatter]) {
                    title = group.groupSubject;
                    break;
                }
            }
        }
    } else if (conversation.conversationType == eConversationTypeChat) {
//        title = [[UserProfileManager sharedInstance] getNickNameWithUsername:conversation.chatter];
    }
    
//    NSString *chatter = conversation.chatter;
    
//    chatController = [[ChatViewController alloc] initWithConversation:conversation];
    chatController = [[ChatViewController alloc]initWithChatter:conversation.chatter conversationType:conversation.conversationType];
    chatController.title = title;
    
    
//    chatController.delelgate = self;
    [self.navigationController pushViewController:chatController animated:YES];
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

// 得到最后消息时间
-(NSString *)lastMessageTimeByConversation:(EMConversation *)conversation
{
    NSString *ret = @"";
    EMMessage *lastMessage = [conversation latestMessage];;
    if (lastMessage) {
        ret = [NSDate formattedTimeFromTimeInterval:lastMessage.timestamp];
    }
    
    return ret;
}

// 得到最后消息文字或者类型
-(NSString *)subTitleMessageByConversation:(EMConversation *)conversation
{
    NSString *ret = @"";
    EMMessage *lastMessage = [conversation latestMessage];
    if (lastMessage) {
        id<IEMMessageBody> messageBody = lastMessage.messageBodies.lastObject;
        switch (messageBody.messageBodyType) {
            case eMessageBodyType_Image:{
                ret = NSLocalizedString(@"message.image1", @"[image]");
            } break;
            case eMessageBodyType_Text:{
                // 表情映射。
                NSString *didReceiveText = [ConvertToCommonEmoticonsHelper
                                            convertToSystemEmoticons:((EMTextMessageBody *)messageBody).text];
                    ret = didReceiveText;
            } break;
            case eMessageBodyType_Voice:{
                ret = NSLocalizedString(@"message.voice1", @"[voice]");
            } break;
            case eMessageBodyType_Location: {
                ret = NSLocalizedString(@"message.location1", @"[location]");
            } break;
            case eMessageBodyType_Video: {
                ret = NSLocalizedString(@"message.video1", @"[video]");
            } break;
            default: {
            } break;
        }
    }
    
    return ret;
}

// 得到未读消息条数
- (NSInteger)unreadMessageCountByConversation:(EMConversation *)conversation
{
    NSInteger ret = 0;
    ret = conversation.unreadMessagesCount;
    
    return  ret;
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
//    self.datasource = [self loadDataSource];
    [self loadDataSource];
    [self.tableView reloadData];
//    [self hideHud];
}

@end


