//
//  ECScrollView.h
//  TestScrollView
//
//  Created by dujiepeng on 15/9/10.
//  Copyright (c) 2015年 djp. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ECScrollView;

@protocol ECScrollViewItemDelegate <NSObject>
- (NSString *)itemName;
- (NSString *)itemId;
@end

@protocol ECScrollViewDelegate <NSObject>
- (void)eCSCrollView:(ECScrollView *)scrollVeiw
     didClickedItem:(NSString *)itemId;

@end

@interface ECScrollView : UIScrollView
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic) id <ECScrollViewDelegate> ecScrollViewDelegate;
@property (nonatomic, strong) UIColor *latestTitleColor;
@property (nonatomic, strong) UIFont *titleFont;
-(instancetype)initWithFrame:(CGRect)frame;
- (void)addItem:(id <ECScrollViewItemDelegate>)item;
- (void)addItems:(NSArray *)items;
@end
