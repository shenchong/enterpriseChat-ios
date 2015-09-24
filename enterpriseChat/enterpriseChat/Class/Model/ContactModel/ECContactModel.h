//
//  ECContactModel.h
//  enterpriseChat
//
//  Created by dujiepeng on 15/8/25.
//  Copyright (c) 2015年 easemob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RealtimeSearchUtil.h"
@interface ECContactModel : NSObject<RealtimeSearchUtilDelegate>
@property (nonatomic, strong) NSString *eid;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *headImagePath;
@property (nonatomic, strong) NSString *bgImagePath;
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) NSString *deparementId;
@property (nonatomic, strong) NSString *showName;
@property (nonatomic, strong) UIImage  *placeholderImage;
@end
