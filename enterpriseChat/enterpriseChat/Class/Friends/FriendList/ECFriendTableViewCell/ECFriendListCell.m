//
//  ECFriendListCell.m
//  enterpriseChat
//
//  Created by dujiepeng on 15/7/31.
//  Copyright (c) 2015年 easemob. All rights reserved.
//

#import "ECFriendListCell.h"

@interface ECFriendListCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *showNameLabel;

@end

@implementation ECFriendListCell

- (void)awakeFromNib {
    // Initialization code
    [self.headImageView radius:self.headImageView.width/2 color:nil border:0];
}

-(void)layoutSubviews{
    [super layoutSubviews];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellModel:(ECFriendListCellModel *)cellModel{
    _cellModel = cellModel;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:_cellModel.headerRemotePath]
                          placeholderImage:[UIImage imageNamed:@"chatListCellHead"]];
    self.showNameLabel.text = _cellModel.showName;
}

@end
