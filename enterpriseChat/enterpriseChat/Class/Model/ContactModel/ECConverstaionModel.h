//
//  ECConverstaionModel.h
//  enterpriseChat
//
//  Created by dujiepeng on 15/9/24.
//  Copyright © 2015年 easemob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EaseMob.h"
@interface ECConverstaionModel : NSObject
@property (nonatomic, strong, readonly) EMConversation *conversation;

@property (nonatomic, strong) NSString *showName;
@property (nonatomic, strong) NSString *headerRemotePath;
@property (nonatomic, strong) NSString *msgTime;
@property (nonatomic, strong) NSString *msgInfo;
@property (nonatomic) NSInteger unreadCount;

- (instancetype)initWithConversation:(EMConversation *)conversation;
@end
