//
//  ECViewManager.h
//  enterpriseChat
//
//  Created by dujiepeng on 15/7/29.
//  Copyright (c) 2015年 easemob. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ECViewManager : NSObject
+(ECViewManager *)sharedInstance;

-(void)setupStatusBarStyle2LightContent;
-(void)setupStatusBarStyle2Default;
@end
