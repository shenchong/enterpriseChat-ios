//
//  UIView+Radius.m
//  doChat
//
//  Created by dujiepeng on 3/28/15.
//  Copyright (c) 2015 zero. All rights reserved.
//

#import "UIView+Radius.h"

@implementation UIView (Radius)
-(void)radius:(CGFloat)radius
        color:(UIColor *)color
       border:(CGFloat)border{
    [[self layer] setBorderWidth:border];//画线的宽度
    [[self layer] setBorderColor:color.CGColor];//颜色
    [[self layer] setCornerRadius:radius];//圆角
    [[self layer] setMasksToBounds:YES];
}
@end
