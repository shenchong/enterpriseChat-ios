//
//  ECChatListCell.m
//  enterpriseChat
//
//  Created by dujiepeng on 15/7/30.
//  Copyright (c) 2015年 easemob. All rights reserved.
//

#import "ECChatListCell.h"

@interface ECChatListCell ()

@end

@implementation ECChatListCell

- (void)awakeFromNib {
    [self.headImageView radius:self.headImageView.width/2 color:nil border:0];
    [self.unreadCountLabel radius:self.unreadCountLabel.width/2 color:nil border:0];
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bottom - 0.3, self.width, 0.3)];
    self.lineView.backgroundColor= [UIColor colorWithWhite:0.667 alpha:0.610];
    [self addSubview:self.lineView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (![_unreadCountLabel isHidden]) {
        _unreadCountLabel.backgroundColor = [UIColor redColor];
    }
}


- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    [super setHighlighted:highlighted animated:animated];
    if (![_unreadCountLabel isHidden]) {
        _unreadCountLabel.backgroundColor = [UIColor redColor];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if (_conversationModel.conversation.unreadMessagesCount == 0) {
        [self.unreadCountLabel setHidden:YES];
    }else {
        [self.unreadCountLabel setHidden:NO];
        if (self.unreadCountLabel.text.length == 3) {
            [self.unreadCountLabel setFont:[UIFont systemFontOfSize:9]];
        }else if (self.unreadCountLabel.text.length == 2){
            [self.unreadCountLabel setFont:[UIFont systemFontOfSize:11]];
        }else{
            [self.unreadCountLabel setFont:[UIFont systemFontOfSize:12]];
        }
    }
}

-(void)setConversationModel:(ECConverstaionModel *)conversationModel{
    _conversationModel = conversationModel;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:_conversationModel.headerRemotePath]
                          placeholderImage:[UIImage imageNamed:@"chatListCellHead"]];
    self.showNameLabel.text = _conversationModel.showName;
    self.timeLabel.text = _conversationModel.msgTime;
    self.msgInfoLabel.text = _conversationModel.msgInfo;
    if (_conversationModel.unreadCount > 99) {
        self.unreadCountLabel.text = @"99+";
    }else {
        self.unreadCountLabel.text = [NSString stringWithFormat:@"%ld",(long)_conversationModel.unreadCount];
    }
}

@end
