//
//  ECDepartmentListViewController.h
//  enterpriseChat
//
//  Created by dujiepeng on 15/8/18.
//  Copyright © 2015年 easemob. All rights reserved.
//

#import "ECBaseViewController.h"
#import "ECDepartmentModel.h"
@interface ECDepartmentListViewController : ECBaseViewController
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) ECDepartmentModel *departmentModel;
+ (id)departmentListWithDepartment:(ECDepartmentModel *)departmentModel;
@end
