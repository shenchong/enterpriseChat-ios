//
//  ECChatListCell.m
//  enterpriseChat
//
//  Created by dujiepeng on 15/7/30.
//  Copyright (c) 2015年 easemob. All rights reserved.
//

#import "ECChatListCell.h"

@interface ECChatListCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *showNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *msgInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UILabel *unreadCountLabel;

@end

@implementation ECChatListCell

- (void)awakeFromNib {
    [self.headImageView radius:self.headImageView.width/2 color:nil border:0];
    [self.unreadCountLabel radius:self.unreadCountLabel.width/2 color:nil border:0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if (_cellModel.unreadCount == 0) {
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

-(void)setCellModel:(ECChatListCellModel *)cellModel{
    _cellModel = cellModel;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:_cellModel.headerRemotePath]
                          placeholderImage:[UIImage imageNamed:@"chatListCellHead"]];
    self.showNameLabel.text = _cellModel.showName;
    self.timeLabel.text = _cellModel.time;
    self.msgInfoLabel.text = _cellModel.msgInfo;

    if (_cellModel.unreadCount > 99) {
        self.unreadCountLabel.text = @"99+";
    }else {
        self.unreadCountLabel.text = [NSString stringWithFormat:@"%ld",(long)_cellModel.unreadCount];
    }
}

@end
