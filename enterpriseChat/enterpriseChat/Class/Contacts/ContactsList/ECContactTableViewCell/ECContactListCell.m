//
//  ECContactListCell.m
//  enterpriseChat
//
//  Created by dujiepeng on 15/7/31.
//  Copyright (c) 2015年 easemob. All rights reserved.
//

#import "ECContactListCell.h"

@interface ECContactListCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *showNameLabel;

@end

@implementation ECContactListCell

- (void)awakeFromNib {
    // Initialization code
    [self.headImageView radius:self.headImageView.width/2 color:nil border:0];
}

-(void)layoutSubviews{
    [super layoutSubviews];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setCellModel:(ECContactListCellModel *)cellModel{
    _cellModel = cellModel;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:_cellModel.headerRemotePath]
                          placeholderImage:_cellModel.headerPlaceholderImage?
     _cellModel.headerPlaceholderImage:[UIImage imageNamed:@"chatListCellHead"]];
    self.showNameLabel.text = _cellModel.showName;
}

@end
