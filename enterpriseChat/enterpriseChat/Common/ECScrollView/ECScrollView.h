//
//  ECScrollView.h
//  TestScrollView
//
//  Created by dujiepeng on 15/9/10.
//  Copyright (c) 2015年 djp. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ECScrollViewDelegate <NSObject>
- (void)didClickedItem:(NSInteger)item;

@end

@interface ECScrollView : UIScrollView
@property (nonatomic) id <ECScrollViewDelegate> ecScrollViewDelegate;
- (void)addItem:(NSInteger)item;
@end
