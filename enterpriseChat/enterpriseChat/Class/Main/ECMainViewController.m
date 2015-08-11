//
//  ECMainViewController.m
//  enterpriseChat
//
//  Created by dujiepeng on 15/7/29.
//  Copyright (c) 2015年 easemob. All rights reserved.
//

#import "ECMainViewController.h"
#import "ECChatListViewController.h"
#import "ECFriendListViewController.h"
#import "ECEnterpriseListViewController.h"
#import "ECSettingsListViewController.h"


@interface ECMainViewController () <UITabBarControllerDelegate>

@property (nonatomic, strong) ECChatListViewController *chatList;
@property (nonatomic, strong) ECFriendListViewController *friendList;
@property (nonatomic, strong) ECEnterpriseListViewController *enterprise;
@property (nonatomic, strong) ECSettingsListViewController *settings;

@end

@implementation ECMainViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    self.delegate = self;
    [self setupTabbar];
    self.viewControllers = @[self.chatList,self.friendList,self.enterprise,self.settings];
    [self tabBarController:self didSelectViewController:self.chatList];
}

-(void)setupTabbar{
    self.tabBar.tintColor = TABBAR_TINTCOLOR;
    self.tabBar.barTintColor = TABBAR_BARTINTCOLOR;
}

#pragma mark - UITabBarControllerDelegate
- (void)tabBarController:(UITabBarController *)tabBarController
 didSelectViewController:(UIViewController *)viewController{
    self.title = viewController.tabBarItem.title;
    self.navigationItem.rightBarButtonItem = viewController.navigationItem.rightBarButtonItem;
}

#pragma mark - getter
-(ECChatListViewController *)chatList{
    if (!_chatList) {
        _chatList = [[ECChatListViewController alloc] init];
        [_chatList setupWithItemTitle:@"会话"
                finishedSelectedImage:[UIImage imageNamed:@"tabbar_chats"]
          withFinishedUnselectedImage:[UIImage imageNamed:@"tabbar_chatsHL"]
                                  tag:0];
    }
    
    return _chatList;
}

-(ECFriendListViewController *)friendList{
    if (!_friendList) {
        _friendList = [[ECFriendListViewController alloc] init];
        [_friendList setupWithItemTitle:@"联系人"
                  finishedSelectedImage:[UIImage imageNamed:@"tabbar_contacts"]
            withFinishedUnselectedImage:[UIImage imageNamed:@"tabbar_contactsHL"]
                                    tag:1];
    }
    
    return _friendList;
}

-(ECEnterpriseListViewController *)enterprise{
    if (!_enterprise) {
        _enterprise = [[ECEnterpriseListViewController alloc] init];
        [_enterprise setupWithItemTitle:@"应用"
                  finishedSelectedImage:[UIImage imageNamed:@"tabbar_social"]
            withFinishedUnselectedImage:[UIImage imageNamed:@"tabbar_socialHL"]
                                    tag:2];
    }
    
    return _enterprise;
}

-(ECSettingsListViewController *)settings{
    if (!_settings) {
        _settings = [[ECSettingsListViewController alloc] init];
        [_settings setupWithItemTitle:@"设置"
                finishedSelectedImage:[UIImage imageNamed:@"tabbar_setting"]
          withFinishedUnselectedImage:[UIImage imageNamed:@"tabbar_settingHL"]
                                  tag:3];
    }
    
    return _settings;
}

@end
