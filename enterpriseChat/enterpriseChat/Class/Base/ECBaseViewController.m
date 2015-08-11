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
    self.edgesForExtendedLayout = UIRectEdgeNone;
    // 为了纠正navigationBar显示
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationItem.rightBarButtonItem = [self rightBarButtonItem];
        self.navigationItem.leftBarButtonItem = [self leftBarButtonItem];
}

- (void)setupWithItemTitle:(NSString *)title
     finishedSelectedImage:(UIImage *)finishImage
withFinishedUnselectedImage:(UIImage *)unselectedImage
                       tag:(NSInteger)tag{
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

@end
