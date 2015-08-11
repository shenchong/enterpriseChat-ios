//
//  ECViewManager.m
//  enterpriseChat
//
//  Created by dujiepeng on 15/7/29.
//  Copyright (c) 2015年 easemob. All rights reserved.
//

#import "ECViewManager.h"
#import <UIKit/UIKit.h>


@implementation ECViewManager


+(ECViewManager *)sharedInstance{
    static dispatch_once_t onceToken;
    static ECViewManager *viewManager;
    dispatch_once(&onceToken, ^{
        viewManager = [[self alloc] init];
    });
    return viewManager;
}

-(instancetype)init{
    if (self == [super init]) {
        
    }
    
    return self;
}

-(void)setupStatusBarStyle2LightContent{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

-(void)setupStatusBarStyle2Default{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

@end
