//
//  ECChatViewController.m
//  enterpriseChat
//
//  Created by dujiepeng on 15/7/29.
//  Copyright (c) 2015年 easemob. All rights reserved.
//

#import "ECChatViewController.h"

@interface ECChatViewController ()
{
    EMConversation *_conversation;
}
@end

@implementation ECChatViewController

-(instancetype)initWithConversation:(EMConversation *)conversation{
    if (self = [super init]) {
        _conversation = conversation;
        self.hidesBottomBarWhenPushed = YES;
    }
    
    return self;
}
@end
