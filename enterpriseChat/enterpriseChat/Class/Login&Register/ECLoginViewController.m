//
//  ECLoginViewController.m
//  enterpriseChat
//
//  Created by dujiepeng on 15/8/26.
//  Copyright (c) 2015年 easemob. All rights reserved.
//

#import "ECLoginViewController.h"
#import "UITextField+Category.h"
#import "UIViewController+DismissKeyboard.h"

@interface ECLoginViewController () <UITextFieldDelegate>{
    UIView *_firstResponderView;
    CGFloat _keyboardY;
}
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UIImageView *logeImageView;

@end

@implementation ECLoginViewController

+ (UINavigationController *)showLoginViewController{
    ECLoginViewController *loginVC = [[ECLoginViewController alloc]
                                      initWithNibName:@"ECLoginViewController" bundle:nil];
    loginVC.title = @"登录";
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
    [nav setNavigationBarHidden:YES];
    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"chatListCellHead"] forBarMetrics:UIBarMetricsDefault];
    return nav;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[ECViewManager sharedInstance] setupStatusBarStyle2LightContent];
    [self setupUI];
    [self setupForDismissKeyboard];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillChangeFrame:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
}

- (void)setupUI{
    UILabel *leftView = [[UILabel alloc] initWithFrame:CGRectZero];
    leftView.textColor = [UIColor whiteColor];
    leftView.font = [UIFont systemFontOfSize:13];
    leftView.textAlignment = NSTextAlignmentLeft;
    leftView.text = @"手机号:  ";
    [leftView sizeToFit];
    leftView.height = _usernameField.height;
    [_usernameField setLeftView:leftView];
    [_usernameField setLeftViewMode:UITextFieldViewModeAlways];
    [_usernameField setFont:[UIFont systemFontOfSize:18]];
    [_usernameField setPlaceholderColor:[UIColor whiteColor]];
    [_usernameField setPlaceholderFont:[UIFont systemFontOfSize:18]];
    [_usernameField setClearButtonImage:[UIImage imageNamed:@"tabbar_chatsHL"]];
    [_usernameField setClearButtonMode:UITextFieldViewModeWhileEditing];
    
    leftView = [[UILabel alloc] initWithFrame:CGRectZero];
    leftView.textColor = [UIColor whiteColor];
    leftView.font = [UIFont systemFontOfSize:13];
    leftView.textAlignment = NSTextAlignmentLeft;
    leftView.text = @"密码:  ";
    [leftView sizeToFit];
    [_pwdField setLeftView:leftView];
    [_pwdField setLeftViewMode:UITextFieldViewModeAlways];
    [_pwdField setFont:[UIFont systemFontOfSize:18]];
    [_pwdField setPlaceholderColor:[UIColor whiteColor]];
    [_pwdField setPlaceholderFont:[UIFont systemFontOfSize:18]];
    [_pwdField setClearButtonImage:[UIImage imageNamed:@"tabbar_chatsHL"]];
    [_pwdField setClearButtonMode:UITextFieldViewModeWhileEditing];
    [_pwdField setClearsOnBeginEditing:YES];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithTitle:@"确定"
                                              style:UIBarButtonItemStyleDone
                                              target:self
                                              action:@selector(login)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    NSValue *beginValue = [userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey];
    NSValue *endValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect beginRect;
    [beginValue getValue:&beginRect];
    CGRect endRect;
    [endValue getValue:&endRect];
    _keyboardY = CGRectGetMinY(endRect);
    if (CGRectGetMinY(endRect) < CGRectGetMinY(beginRect)) {
        if (CGRectGetMinY(endRect) < _firstResponderView.bottom) {
            self.view.top += (_keyboardY - _firstResponderView.bottom);
        }
    }else {
        self.view.top = 0;
    }
}

- (void)doneButton:(id)sender{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (_firstResponderView && textField.bottom > _keyboardY) {
        [UIView animateWithDuration:0.25 animations:^{
            self.view.top += _keyboardY - textField.bottom;
        }];
    }
    _firstResponderView = textField;
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (string.length > 0) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }else {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    _firstResponderView = nil;
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    self.logeImageView.image = [UIImage imageNamed:@"WelcomeHL"];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.logeImageView.image = [UIImage imageNamed:@"Welcome"];
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.tag == 0) {
        [_pwdField becomeFirstResponder];
    }else {
        [textField resignFirstResponder];
    }
    return YES;
}

#pragma mark - actions
- (void)login{
    if ([self.usernameField.text isEffective] && [self.pwdField.text isEffective]) {
        [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:self.usernameField.text
                                                            password:self.pwdField.text
                                                          completion:^(NSDictionary *loginInfo, EMError *error)
         {
             [[EaseMob sharedInstance].chatManager setIsAutoLoginEnabled:YES];
             [[NSNotificationCenter defaultCenter] postNotificationName:LOGIN_CHANGE_NOTIFICATION
                                                                 object:@YES];
         } onQueue:nil];
    }
}

@end
