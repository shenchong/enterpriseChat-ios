//
//  ECContactModel.h
//  enterpriseChat
//
//  Created by dujiepeng on 15/8/25.
//  Copyright (c) 2015年 easemob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ECContactDelegate.h"

@interface ECContactModel : NSObject <ECContactDelegate>
@property (nonatomic, strong) NSString *contactEid;
@property (nonatomic, strong) NSString *contactNickname;
@property (nonatomic, strong) NSString *contactHeadImagePath;
@property (nonatomic, strong) NSString *contactBgImagePath;
@property (nonatomic, strong) NSString *contactPhoneNumber;
@property (nonatomic, strong) NSString *contactDepartment;
@property (nonatomic, strong) UIImage *contactPlaceholderImage;
@end
