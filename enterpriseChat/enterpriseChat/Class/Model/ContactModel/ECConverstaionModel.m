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
#import "ConvertToCommonEmoticonsHelper.h"
#import "NSDate+Category.h"

@implementation ECConverstaionModel
-(instancetype)initWithConversation:(EMConversation *)conversation{
    if (self = [super init]) {
        _conversation = conversation;
        
        self.showName = conversation.chatter;
        
        self.msgInfo = [self subTitleMessageByConversation:conversation];
        
        self.unreadCount = [self unreadMessageCountByConversation:conversation];
        
        self.msgTime = [self lastMessageTimeByConversation:conversation];
        
        self.headerRemotePath = @"http://img0.bdstatic.com/img/image/chongwu0727.jpg";
    }
    
    return self;
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

@end
