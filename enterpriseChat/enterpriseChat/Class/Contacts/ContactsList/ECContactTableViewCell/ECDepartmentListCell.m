//
//  ECDepartmentListCell.m
//  enterpriseChat
//
//  Created by dujiepeng on 15/9/24.
//  Copyright © 2015年 easemob. All rights reserved.
//

#import "ECDepartmentListCell.h"

@interface ECDepartmentListCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *showNameLabel;
@property (strong, nonatomic) UIView *lineView;
@end

@implementation ECDepartmentListCell

- (void)awakeFromNib {
    // Initialization code
    [self.headImageView radius:self.headImageView.width/2 color:nil border:0];
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bottom - 0.3, self.width, 0.3)];
    self.lineView.backgroundColor= [UIColor colorWithWhite:0.667 alpha:0.610];
    [self addSubview:self.lineView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setDepartmentModel:(ECDepartmentModel *)departmentModel{
    _departmentModel = departmentModel;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:_departmentModel.departmentImagePath]
                          placeholderImage:[UIImage imageNamed:@"chatListCellHead"]];
    self.showNameLabel.text = _departmentModel.departmentName;
}

@end
