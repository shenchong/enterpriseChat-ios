//
//  UITextField+Category.m
//  enterpriseChat
//
//  Created by dujiepeng on 15/8/27.
//  Copyright (c) 2015年 easemob. All rights reserved.
//

#import "UITextField+Category.h"

@implementation UITextField (Category)
- (UIColor *)placeholderColor{
    return (UIColor *)[self valueForKeyPath:@"_placeholderLabel.textColor"];
}

- (void)setPlaceholderColor:(UIColor *)color{
    [self setValue:color forKeyPath:@"_placeholderLabel.textColor"];
}


- (UIFont *)placeholderFont{
    return (UIFont *)[self valueForKey:@"_placeholderLabel.font"];
}

- (void)setPlaceholderFont:(UIFont *)font{
    [self setValue:font forKeyPath:@"_placeholderLabel.font"];
}

- (void)setClearButtonImage:(UIImage *)image{
    UIButton *clearButton = [self valueForKey:@"_clearButton"];
    [clearButton setImage:image forState:UIControlStateNormal];
    [clearButton setImage:image forState:UIControlStateHighlighted];
}
@end
