//
//  ECScrollView.m
//  TestScrollView
//
//  Created by dujiepeng on 15/9/10.
//  Copyright (c) 2015年 djp. All rights reserved.
//

#import "ECScrollView.h"
#import "UIView+Frame.h"

@interface ECScrollViewButton : UIButton
@property (nonatomic, strong) NSString *itemId;
@end

@implementation ECScrollViewButton

@end

@interface ECScrollView (){
    CGFloat _contentWidth;
}

@end

@implementation ECScrollView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        _contentWidth = 10;
    }
    
    return self;
}

-(void)layoutSubviews{
    
}

-(NSMutableArray *)items{
    if (!_items) {
        _items = [[NSMutableArray alloc] init];
    }
    
    return _items;
}

- (void)addItem:(id <ECScrollViewItemDelegate>)item{
    ECScrollViewButton *button = [ECScrollViewButton buttonWithType:UIButtonTypeCustom];
    NSMutableAttributedString *attributeTitle;
    if (self.items.count == 0) {
        attributeTitle = [[NSMutableAttributedString alloc]
                          initWithString:[NSString stringWithFormat:@"%@",[item itemName]]
                          attributes:nil];
        [attributeTitle addAttribute:NSForegroundColorAttributeName
                               value:self.latestTitleColor
                               range:NSMakeRange(0,attributeTitle.length)];
    }else {
        attributeTitle = [[NSMutableAttributedString alloc]
                          initWithString:[NSString stringWithFormat:@"> %@",[item itemName]]
                          attributes:nil];
        [attributeTitle addAttribute:NSForegroundColorAttributeName
                               value:self.latestTitleColor
                               range:NSMakeRange(1,attributeTitle.length - 1)];
    }

    [attributeTitle addAttribute:NSFontAttributeName
                           value:self.titleFont
                           range:NSMakeRange(0, attributeTitle.length)];
    
    
    [button setAttributedTitle:attributeTitle forState:UIControlStateNormal];
    [button sizeToFit];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(_contentWidth, 0, button.width + 10, self.height);
    button.left -= button.width;
    button.itemId = [item itemId];
    [button addTarget:self action:@selector(buttonOnClicked:)
     forControlEvents:UIControlEventTouchUpInside];
    [self.items addObject:item];
    [self insertSubview:button atIndex:0];
    [UIView animateWithDuration:0.2f animations:^{
        button.left += button.width;
    }];
    _contentWidth += button.width;
    self.contentSize = CGSizeMake(_contentWidth, self.height);
    if (_contentWidth > self.width) {
        [self setContentOffset:CGPointMake(_contentWidth - self.width, 0) animated:YES];
    }
}

- (void)addItems:(NSArray *)items{
    for (int i = 0; i < items.count; i++) {
        id <ECScrollViewItemDelegate> item = [items objectAtIndex:i];
        ECScrollViewButton *button = [ECScrollViewButton buttonWithType:UIButtonTypeCustom];
        NSMutableAttributedString *attributeTitle;
        if (i == 0) {
            attributeTitle = [[NSMutableAttributedString alloc]
                              initWithString:[NSString stringWithFormat:@"%@",[item itemName]]
                              attributes:nil];
        }else {
            attributeTitle = [[NSMutableAttributedString alloc]
                              initWithString:[NSString stringWithFormat:@"> %@",[item itemName]]
                              attributes:nil];
        }
        [attributeTitle addAttribute:NSFontAttributeName
                               value:self.titleFont
                               range:NSMakeRange(0, attributeTitle.length)];
        [button setAttributedTitle:attributeTitle forState:UIControlStateNormal];
        [button sizeToFit];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.frame = CGRectMake(_contentWidth, 0, button.width + 10, self.height);
        button.left -= button.width;
        button.itemId = [item itemId];
        [button addTarget:self action:@selector(buttonOnClicked:)
         forControlEvents:UIControlEventTouchUpInside];
        [self.items addObject:item];
        [self insertSubview:button atIndex:0];
        [UIView animateWithDuration:0.2f animations:^{
            button.left += button.width;
        }];
        _contentWidth += button.width;
        self.contentSize = CGSizeMake(_contentWidth, self.height);
        if (_contentWidth > self.width) {
            [self setContentOffset:CGPointMake(_contentWidth - self.width, 0) animated:YES];
        }
    }
}

-(void)buttonOnClicked:(ECScrollViewButton *)btn{
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
    if (_ecScrollViewDelegate && [_ecScrollViewDelegate respondsToSelector:@selector(eCSCrollView:didClickedItem:)]) {
        [_ecScrollViewDelegate eCSCrollView:self didClickedItem:btn.itemId];
    }
}


@end