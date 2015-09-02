//
//  AppDelegate.m
//  enterpriseChat
//
//  Created by dujiepeng on 15/7/29.
//  Copyright (c) 2015年 easemob. All rights reserved.
//

#import "AppDelegate.h"
#import "ECMainViewController.h"
#import "AppDelegate+EaseMob.h"
#import "ECLoginViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self easemobApplication:application didFinishLaunchingWithOptions:launchOptions];
    [[ECViewManager sharedInstance] setupNavigationBar2White];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginChanged:)
                                                 name:LOGIN_CHANGE_NOTIFICATION
                                               object:nil];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = WINDOW_BACKCOLOR;
    self.window.rootViewController = [ECLoginViewController showLoginViewController];
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)showMainView{

}

- (void)loginChanged:(NSNotification *)noti{
    if ([noti.object boolValue]) {
        self.window.rootViewController = [[ECMainViewController alloc] init];
    }
}


@end
