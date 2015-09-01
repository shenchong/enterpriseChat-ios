//
//  enterpriseChat_Tests.m
//  enterpriseChat Tests
//
//  Created by dujiepeng on 15/9/1.
//  Copyright (c) 2015年 easemob. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "ECDBManager.h"
#import "ECDepartmentModel.h"
#import "ECContactModel.h"
#import "ECErrorDefs.h"
@interface enterpriseChat_Tests : XCTestCase

@end

@implementation enterpriseChat_Tests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
}

- (void)testCreateDB{
    [ECDBManager openEasemobDatabaseWithAccount:@"test"];
}

- (void)qtestInsertDB{
    ECDepartmentModel *departmentModel = [[ECDepartmentModel alloc] init];
    departmentModel.departmentId = @"100";
    departmentModel.departmentLevel = 1;
    departmentModel.departmentName = @"1level";
    BOOL success = [[ECDBManager sharedInstance] insertDepartment:departmentModel loginAccount:@"test"];
    if (success) {
        NSLog(@"dp插入成功");
    }else {
        NSLog(@"dp插入失败");
    }
    
    ECContactModel *contact = [[ECContactModel alloc] init];
    contact.contactEid = @"1000001";
    contact.contactNickname = @"nick";
    contact.contactDepartmentId = @"3";
    contact.contactPhoneNumber = @"10086";

    success = [[ECDBManager sharedInstance] insertContact:contact loginAccount:@"test"];
    if (success) {
        NSLog(@"c插入成功");
    }else {
        NSLog(@"c插入失败");
    }
}

- (void)qtestLoadDB{
    ECDepartmentModel *departmentModel = [[ECDBManager sharedInstance] loadDepartmentWithID:@"100" loginAccount:@"test"];
    NSLog(@"ECDepartmentModel -- %@",departmentModel.departmentId);
    
    ECContactModel *contactModel = [[ECDBManager sharedInstance] loadContactWithID:@"1000001" loginAccount:@"test"];
    NSLog(@"contactModel -- %@",contactModel.contactEid);
}

- (void)qtestUpdateDB{
    ECDepartmentModel *departmentModel = [[ECDepartmentModel alloc] init];
    departmentModel.departmentId = @"100";
    departmentModel.departmentLevel = 2;
    departmentModel.departmentName = @"123123";
    BOOL success = [[ECDBManager sharedInstance] updateDepartment:departmentModel loginAccount:@"test"];
    if (success) {
        NSLog(@"更新成功");
    }else {
        NSLog(@"更新失败");
    }
    
    ECContactModel *contact = [[ECContactModel alloc] init];
    contact.contactEid = @"1000001";
    contact.contactNickname = @"1221nick";
    contact.contactDepartmentId = @"32";
    contact.contactPhoneNumber = @"10111086";
    
    success = [[ECDBManager sharedInstance] updateContact:contact loginAccount:@"test"];
    if (success) {
        NSLog(@"c更新成功");
    }else {
        NSLog(@"c更新失败");
    }
}


- (void)testDeleteDB{
    BOOL success = [[ECDBManager sharedInstance] deleteDepartmentWithId:@"100" loginAccountL:@"test"];
    if (success) {
        NSLog(@"dp删除成功");
    }else {
        NSLog(@"dp删除失败");
    }
    
    success = [[ECDBManager sharedInstance] deleteContactWithEid:@"1000001" loginAccountL:@"test"];
    if (success) {
        NSLog(@"c删除成功");
    }else {
        NSLog(@"c删除失败");
    }
}

@end
