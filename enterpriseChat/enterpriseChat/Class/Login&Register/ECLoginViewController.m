//
//  ECLoginViewController.m
//  enterpriseChat
//
//  Created by dujiepeng on 15/8/26.
//  Copyright (c) 2015年 easemob. All rights reserved.
//

#import "ECLoginViewController.h"

@interface ECLoginViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UIImageView *logeImageView;

@end

@implementation ECLoginViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupUI];
}

- (void)setupUI{
    [_usernameField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_pwdField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    self.logeImageView.image = [UIImage imageNamed:@""];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.logeImageView.image = [UIImage imageNamed:@"Welcome"];
}

@end
