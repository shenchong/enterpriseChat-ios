//
//  ECBaseViewController.m
//  enterpriseChat
//
//  Created by dujiepeng on 15/7/29.
//  Copyright (c) 2015年 easemob. All rights reserved.
//

#import "ECBaseViewController.h"
#import "AppDelegate.h"

@implementation ECBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [self rightBarButtonItem];
    self.navigationItem.leftBarButtonItem = [self leftBarButtonItem];
}

- (void)setupWithTitle:(NSString *)title
 finishedSelectedImage:(UIImage *)finishImage
withFinishedUnselectedImage:(UIImage *)unselectedImage
                   tag:(NSInteger)tag{
    self.navigationItem.title = title;
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:title
                                                    image:finishImage
                                            selectedImage:unselectedImage];
    self.tabBarItem.tag = tag;
    NSDictionary *normalTextAttributes = @{
                                           NSFontAttributeName:[UIFont systemFontOfSize:TABBAR_TEXT_FONT_SIZE],
                                           NSForegroundColorAttributeName:TABBAR_NORMAL_TEXT_COLOR
                                           };
    
    [self.tabBarItem setTitleTextAttributes:normalTextAttributes forState:UIControlStateNormal];
    
    NSDictionary *selectedTextAttributes = @{
                                             NSFontAttributeName:[UIFont systemFontOfSize:TABBAR_TEXT_FONT_SIZE],
                                             NSForegroundColorAttributeName:TABBAR_SELECTED_TEXT_COLOR
                                             };
    
    [self.tabBarItem setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];
}

-(UIBarButtonItem *)rightBarButtonItem{
    return nil;
}

-(UIBarButtonItem *)leftBarButtonItem{
    return nil;
}

-(void)setupBadgeValue:(NSString *)badgeValue{
    self.tabBarItem.badgeValue = badgeValue;
}

@end
