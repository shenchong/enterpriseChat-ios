//
//  ECContactModel.h
//  enterpriseChat
//
//  Created by dujiepeng on 15/8/25.
//  Copyright (c) 2015年 easemob. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ECContactModel : NSObject
@property (nonatomic, strong) NSString *eid;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *headImagePath;
@property (nonatomic, strong) NSString *bgImagePath;
@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) NSString *department;
@end
