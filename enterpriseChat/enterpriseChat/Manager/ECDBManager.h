//
//  ECDBManager.h
//  enterpriseChat
//
//  Created by dujiepeng on 15/8/25.
//  Copyright (c) 2015年 easemob. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ECContactModel;
@class ECDepartmentModel;
@interface ECDBManager : NSObject
@property (strong, nonatomic) NSString *loginAccount;
@property (strong, nonatomic, readonly) NSString *dbPath;
+ (NSError *)openEasemobDatabaseWithAccount:(NSString *)loginAccount;
+ (void)closeEasemobDatabase;
+ (instancetype)sharedInstance;

#pragma mark - update db
- (BOOL)updateDepartment:(ECDepartmentModel *)deparment
            loginAccount:(NSString *)account;
- (BOOL)updateContact:(ECContactModel *)contact
         loginAccount:(NSString *)account;

#pragma mark - insert db
- (BOOL)insertDepartment:(ECDepartmentModel *)deparment
            loginAccount:(NSString *)account;
- (BOOL)insertContact:(ECContactModel *)contact
         loginAccount:(NSString *)account;

#pragma mark - delete db
- (BOOL)deleteDepartmentWithId:(NSString *)departmentId
                 loginAccountL:(NSString *)account;
- (BOOL)deleteContactWithEid:(NSString *)eid
               loginAccountL:(NSString *)account;

#pragma mark - load db
- (ECDepartmentModel *)loadDepartmentWithID:(NSString *)departmentId
                               loginAccount:(NSString *)account;
- (NSArray *)loadAllDepartmentsForAccount:(NSString *)account;

- (ECContactModel *)loadContactWithID:(NSString *)eid
                         loginAccount:(NSString *)account;
- (NSArray *)loadAllContactsForAccount:(NSString *)account;
@end
