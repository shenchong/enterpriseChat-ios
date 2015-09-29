//
//  ECSearchBar.m
//  enterpriseChat
//
//  Created by dujiepeng on 15/9/29.
//  Copyright © 2015年 easemob. All rights reserved.
//

#import "ECSearchBar.h"

@interface ECSearchBar ()
@property (nonatomic, strong) UIView *lineView;
@end

@implementation ECSearchBar

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundImage = [self imageWithColor:[UIColor whiteColor] size:self.bounds.size];
        self.placeholder = @"搜索";
        [self addSubview:self.lineView];
    }
    
    return self;
}

-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:self.bounds];
        _lineView.top = self.height - 0.3;
        _lineView.height = 0.3;
        _lineView.backgroundColor = ECCELL_LINE;
    }
    
    return _lineView;
}

- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
