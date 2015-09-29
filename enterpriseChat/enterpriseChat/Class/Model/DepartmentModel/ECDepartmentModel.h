//
//  ECDepartmentModel.h
//  enterpriseChat
//
//  Created by dujiepeng on 15/8/31.
//  Copyright (c) 2015年 easemob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ECScrollView.h"
@interface ECDepartmentModel : NSObject <ECScrollViewItemDelegate>
@property (nonatomic, strong) NSString *departmentId;
@property (nonatomic, strong) NSString *departmentName;
@property (nonatomic, strong) NSString *departmentImagePath;
@property (nonatomic, strong) NSMutableArray *deparementMembers;
@property (nonatomic, strong) NSMutableArray *departmentSubIds;
@property (nonatomic, strong) NSString *departmentSupId;
@property (nonatomic) NSUInteger departmentLevel;

@end
