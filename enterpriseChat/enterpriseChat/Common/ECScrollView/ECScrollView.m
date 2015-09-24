//
//  ECScrollView.m
//  TestScrollView
//
//  Created by dujiepeng on 15/9/10.
//  Copyright (c) 2015年 djp. All rights reserved.
//

#import "ECScrollView.h"
#import "UIView+Frame.h"
@interface ECScrollView (){
    CGFloat _contentWidth;
}
@property (nonatomic, strong) NSMutableArray *items;
@end

@implementation ECScrollView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
    }
    
    return self;
}

-(void)layoutSubviews{
    
}

- (void)addItem:(NSInteger)item{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(_contentWidth, 0, 80, self.height);
    button.left -= button.width;
    [button setBackgroundColor:[UIColor colorWithRed:(CGFloat)(1000 * random()%255)/225
                                               green:(CGFloat)(1000 * random()%255)/225
                                                blue:(CGFloat)(1000 * random()%255)/225
                                               alpha:1]];
    button.tag = item;
    [button addTarget:self action:@selector(buttonOnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self insertSubview:button atIndex:0];
    [self.items addObject:button];
    [UIView animateWithDuration:0.2f animations:^{
        button.left += button.width;
    }];
    _contentWidth += button.width;
    self.contentSize = CGSizeMake(_contentWidth, self.height);
    if (_contentWidth > self.width) {
        [self setContentOffset:CGPointMake(_contentWidth - self.width, 0) animated:YES];
    }
}

-(void)buttonOnClicked:(UIButton *)btn{
    for (UIView *view in self.subviews) {
        if (view.tag > btn.tag) {
            _contentWidth -= view.width;
            [UIView animateWithDuration:0.2 animations:^{
                view.right = btn.right;
            }completion:^(BOOL finished) {
                [view removeFromSuperview];
            }];
        }
    }
    if (_contentWidth > self.width) {
        [self setContentOffset:CGPointMake(_contentWidth - self.width, 0) animated:YES];
    }else {
        [self setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    if (_ecScrollViewDelegate && [_ecScrollViewDelegate respondsToSelector:@selector(didClickedItem:)]) {
        [_ecScrollViewDelegate didClickedItem:btn.tag];
    }
}

@end