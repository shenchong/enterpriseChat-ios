//
//  ECDepartmentListViewController.h
//  enterpriseChat
//
//  Created by dujiepeng on 15/8/18.
//  Copyright © 2015年 easemob. All rights reserved.
//

#import "ECDepartmentModel.h"
@interface ECDepartmentListViewController : UITableViewController
+ (id)departmentListWithDepartment:(ECDepartmentModel *)departmentModel;
@end
