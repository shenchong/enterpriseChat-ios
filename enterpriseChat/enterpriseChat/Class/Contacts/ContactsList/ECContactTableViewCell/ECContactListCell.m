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
@property (strong, nonatomic) UIView *lineView;

@end

@implementation ECContactListCell

- (void)awakeFromNib {
    // Initialization code
    [self.headImageView radius:self.headImageView.width/2 color:nil border:0];
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bottom - 0.3, self.width, 0.3)];
    self.lineView.backgroundColor= ECCELL_LINE;
    [self addSubview:self.lineView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setContactModel:(ECContactModel *)contactModel{
    _contactModel = contactModel;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:_contactModel.headImagePath]
                          placeholderImage:_contactModel.placeholderImage?
     _contactModel.placeholderImage:[UIImage imageNamed:@"chatListCellHead"]];
    self.showNameLabel.text = _contactModel.showName;
}

@end
