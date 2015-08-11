//
//  UIView+Frame.h
//  doChat
//
//  Created by 杜洁鹏 on 15/6/9.
//  Copyright (c) 2015年 杜洁鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)
// Frame Origin
@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;

// Frame Size
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

// Frame Borders
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat right;
@end
