//
//  ECChatListCell.h
//  enterpriseChat
//
//  Created by dujiepeng on 15/7/30.
//  Copyright (c) 2015年 easemob. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECConverstaionModel.h"
@interface ECChatListCell : UITableViewCell
@property (nonatomic, strong) ECConverstaionModel *conversationModel;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *showNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *msgInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) UIView *lineView;
@property (weak, nonatomic) IBOutlet UILabel *unreadCountLabel;
@end
