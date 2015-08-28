//
//  ECContactDelegate.h
//  enterpriseChat
//
//  Created by dujiepeng on 15/8/28.
//  Copyright (c) 2015年 easemob. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ECContactDelegate <NSObject>
@optional
- (NSString *)eid;
- (NSString *)searchKey;
- (UIImage *)headerPlaceholderImage;
@required
- (NSString *)nickname;
- (NSString *)headImagePath;

@end
