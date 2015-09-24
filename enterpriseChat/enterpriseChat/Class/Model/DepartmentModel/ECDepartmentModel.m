//
//  ECDepartmentModel.m
//  enterpriseChat
//
//  Created by dujiepeng on 15/8/31.
//  Copyright (c) 2015年 easemob. All rights reserved.
//

#import "ECDepartmentModel.h"

@implementation ECDepartmentModel

-(NSString *)description{
    return [NSString stringWithFormat:@"departmentid -- %@ , departmentName -- %@, departmentSupID -- %@, departmentImagePath -- %@, deparementMembers -- %@, departmentSubIds -- %@, departmentLevel -- %d",self.departmentId,self.departmentName,self.departmentSupId,self.departmentImagePath,self.deparementMembers, self.departmentSubIds,(int)self.departmentLevel];
}

@end
