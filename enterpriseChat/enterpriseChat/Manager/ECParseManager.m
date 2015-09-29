//
//  ECParseManager.m
//  enterpriseChat
//
//  Created by dujiepeng on 15/9/29.
//  Copyright © 2015年 easemob. All rights reserved.
//

#import "ECParseManager.h"
#import "ECDBManager.h"
#import "ECDepartmentModel.h"
@implementation ECParseManager
// 更新department
- (void)updateDepartmentsFromParse{
    PFQuery *query = [PFQuery queryWithClassName:DEPARTMENT];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        for (id object in objects) {
            if ([objects isKindOfClass:[PFObject class]]) {
                PFObject *deparment = (PFObject *)object;
                
            }
        }
    }];
}

-(ECDepartmentModel *)departmentPFObject2ECDepartment:(PFObject *)departmentPFObject{
    ECDepartmentModel *ret = [[ECDepartmentModel alloc] init];
    ret.departmentId = departmentPFObject[DEPARTMENTID];
    ret.departmentName = departmentPFObject[DEPARTMENTNAME];
    ret.departmentSupId = departmentPFObject[DEPARTMENTSUPID];
    ret.departmentImagePath = departmentPFObject[DEPARTMENTHEADPATH];
    ret.departmentLevel = [departmentPFObject[DEPARTMENTLEVEL] integerValue];
    ret.deparementMembers = departmentPFObject[DEPARTMENTMEMBERS];
    ret.departmentSubIds = departmentPFObject[DEPARTMENTID];
    return ret;
}
@end
