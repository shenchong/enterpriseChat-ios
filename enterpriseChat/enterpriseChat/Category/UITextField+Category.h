//
//  UITextField+Category.h
//  enterpriseChat
//
//  Created by dujiepeng on 15/8/27.
//  Copyright (c) 2015年 easemob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Category)
- (UIColor *)placeholderColor;
- (void)setPlaceholderColor:(UIColor *)color;

- (UIFont *)placeholderFont;
- (void)setPlaceholderFont:(UIFont *)font;

- (void)setClearButtonImage:(UIImage *)image;
@end
