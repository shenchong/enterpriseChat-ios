//
//  ECConverstaionModel.m
//  enterpriseChat
//
//  Created by dujiepeng on 15/9/24.
//  Copyright © 2015年 easemob. All rights reserved.
//

#import "ECConverstaionModel.h"
#import "ECGroupModel.h"
#import "ECContactModel.h"

@implementation ECConverstaionModel
-(instancetype)initWithConversation:(EMConversation *)conversation{
    if (self = [super init]) {
        _conversation = conversation;
    }
    
    return self;
}


@end
