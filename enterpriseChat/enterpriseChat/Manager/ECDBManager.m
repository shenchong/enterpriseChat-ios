//
//  ECDBManager.m
//  enterpriseChat
//
//  Created by dujiepeng on 15/8/25.
//  Copyright (c) 2015年 easemob. All rights reserved.
//

#import "ECDBManager.h"
#import "FMDB.h"
#import "ECDepartmentModel.h"
#import "ECContactModel.h"
#import "ECErrorDefs.h"
#import "enterpriseDefine.h"


#define ECDEPARTMENT                    @"ECDepartment"
#define ECDEPARTMENT_ID                 @"ECDepartmentId"
#define ECDEPARTMENT_NAME               @"ECDepartmentName"
#define ECDEPARTMENT_SUPID              @"ECDepartmentSupId"
#define ECDEPARTMENT_SUBIDS             @"ECDepartmentSubIds"
#define ECDEPARTMENT_MEMBERS            @"ECDepartmentMembers"
#define ECDEPARTMENT_IMAGEPATH          @"ECDepartmentImagePath"
#define ECDEPARTMENT_LEVEL              @"ECDepartmentLevel"

#define ECCONTACT                       @"ECContact"
#define ECCONTACT_EID                   @"ECContactEid"
#define ECCONTACT_NICKNAME              @"ECContactNickname"
#define ECCONTACT_IMAGEPATH             @"ECContactImagePath"
#define ECCONTACT_PHONE                 @"ECContactPhone"
#define ECCONTACT_DEPARTMENTID          @"ECContactDepartmentId"
#define ECCONTACT_BGIMAGEPATH           @"ECContactBgImagePath"



@interface ECDBManager ()
@property (strong, nonatomic) FMDatabaseQueue *databaseQueue;
@end

@implementation ECDBManager

+ (NSError *)openEasemobDatabaseWithAccount:(NSString *)loginAccount
{
    NSError *error = nil;
    ECDBManager *dbman = [ECDBManager sharedInstance];
    if (!loginAccount || loginAccount.length == 0) {
        error = [NSError errorWithDomain:@"账号不能为空" code:ECErrorNotFound userInfo:nil];
    }
    NSString *dbPath = [NSString stringWithFormat:@"%@/%@.db",[self dbPath],loginAccount];
    dbman.loginAccount = loginAccount;
    dbman.databaseQueue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
    if (dbman.databaseQueue) {
        [dbman _createTables];
    }
    
    return error;
}

+ (void)closeEasemobDatabase
{
    ECDBManager *dbman = [ECDBManager sharedInstance];
    [dbman _closeEasemobDatabase];
}

+ (instancetype)sharedInstance
{
    static ECDBManager *shareManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [[ECDBManager alloc] init];
    });
    
    return shareManager;
}

+ (NSString *)dbPath{
    NSString *path = [NSString stringWithFormat:@"%@/Library",NSHomeDirectory()];
    return path;
}

#pragma mark - private
- (void)_createTables{
    [_databaseQueue inDatabase:^(FMDatabase *db) {
        [self _createContactTableForDB:db];
        [self _createDepartmentTableForDB:db];
    }];
    NSLog(@"---log -- %@",NSHomeDirectory());
}

- (void)_closeEasemobDatabase
{
    DLog(@"begin close database -- %@", _loginAccount);
    if (_databaseQueue) {
        [_databaseQueue close];
        _databaseQueue = nil;
        DLog(@"end close database ---%@", _loginAccount);
    }
    _loginAccount = nil;
}

- (BOOL)_insertDepartment:(ECDepartmentModel *)department forDB:(FMDatabase *)db{
    BOOL ret = NO;
    if (department) {
        NSString *insertStr = [NSString stringWithFormat:@"insert into `%@` (`%@`,`%@`,`%@`,`%@`,`%@`,`%@`,`%@`) VALUES (?,?,?,?,?,?,?)",ECDEPARTMENT, ECDEPARTMENT_ID, ECDEPARTMENT_NAME, ECDEPARTMENT_SUPID, ECDEPARTMENT_MEMBERS, ECDEPARTMENT_SUBIDS,ECDEPARTMENT_IMAGEPATH,ECDEPARTMENT_LEVEL];
        NSString *members = [department.deparementMembers componentsJoinedByString:@"_"];
        NSString *subIds = [department.departmentSubIds componentsJoinedByString:@"_"];
        ret = [db executeUpdate:insertStr,department.departmentId,department.departmentName,department.departmentSupId,members,subIds,department.departmentImagePath,department.departmentLevel];
    }
    return ret;
}

- (BOOL)_insertContact:(ECContactModel *)contact forDB:(FMDatabase *)db{
    BOOL ret = NO;
    if (contact) {
        NSString *insertStr = [NSString stringWithFormat:@"insert into `%@` (`%@`,`%@`,`%@`,`%@`,`%@`,`%@`) VALUES (?,?,?,?,?,?)",ECCONTACT, ECCONTACT_EID, ECCONTACT_NICKNAME, ECCONTACT_IMAGEPATH, ECCONTACT_PHONE, ECCONTACT_DEPARTMENTID, ECCONTACT_BGIMAGEPATH];
        ret = [db executeUpdate:insertStr,contact.eid,contact.contactNickname,contact.contactHeadImagePath,contact.contactDepartmentId,contact.contactBgImagePath,contact.contactPhoneNumber];
    }
    return ret;
}

- (BOOL)_updateDepartment:(ECDepartmentModel *)department forDB:(FMDatabase *)db{
    BOOL ret = NO;
    NSString *updateStr = [NSString stringWithFormat:@"update `%@` set %@=?,%@=?,%@=?,%@=?,%@=?,%@=? where %@=?",ECDEPARTMENT, ECDEPARTMENT_NAME, ECDEPARTMENT_SUPID, ECDEPARTMENT_MEMBERS, ECDEPARTMENT_SUBIDS,ECDEPARTMENT_IMAGEPATH,ECDEPARTMENT_LEVEL,ECDEPARTMENT_ID];
    NSString *members = [department.deparementMembers componentsJoinedByString:@"_"];
    NSString *subIds = [department.departmentSubIds componentsJoinedByString:@"_"];
    ret = [db executeUpdate:updateStr,department.departmentName,department.departmentSupId,members,subIds,department.departmentImagePath,department.departmentLevel,department.departmentId];
    return ret;
}

- (BOOL)_updateContact:(ECContactModel *)contact forDB:(FMDatabase *)db{
    BOOL ret = NO;
    NSString *updateStr = [NSString stringWithFormat:@"update `%@` set %@=?,%@=?,%@=?,%@=?,%@=? where %@=?",ECCONTACT, ECCONTACT_NICKNAME, ECCONTACT_IMAGEPATH, ECCONTACT_PHONE, ECCONTACT_DEPARTMENTID,ECCONTACT_BGIMAGEPATH,ECCONTACT_EID];
    ret = [db executeUpdate:updateStr,contact.contactNickname,contact.contactHeadImagePath,contact.contactPhoneNumber,contact.contactDepartmentId,contact.contactBgImagePath,contact.contactEid];
    return ret;
}

- (BOOL)_deleteDepartmentWithId:(NSString *)departmentId{
    __block BOOL ret = NO;
    [_databaseQueue inDatabase:^(FMDatabase *db) {
        NSString *deleteString = [NSString stringWithFormat:@"DELETE FROM '%@' WHERE %@=?", ECDEPARTMENT, ECDEPARTMENT_ID];
        ret = [db executeUpdate:deleteString];
    }];
    return ret;
}

- (BOOL)_deleteContactWithEid:(NSString *)eid{
    __block BOOL ret = NO;
    [_databaseQueue inDatabase:^(FMDatabase *db) {
        NSString *deleteString = [NSString stringWithFormat:@"DELETE FROM '%@' WHERE %@=?", ECCONTACT, ECCONTACT_EID];
        ret = [db executeUpdate:deleteString];
    }];
    return ret;
}

- (ECDepartmentModel *)_loadDepartmentWithID:(NSString *)departmentId{
    __block ECDepartmentModel *ret = nil;
    [_databaseQueue inDatabase:^(FMDatabase *db) {
        NSString *queryString = [NSString stringWithFormat:@"SELECT * FROM '%@' WHERE %@=?", ECDEPARTMENT, ECDEPARTMENT_ID];
        FMResultSet *rs = [db executeQuery:queryString,departmentId];
        while ([rs next]) {
            ret = [self departmentFromResultSet:rs];
            break;
        }
        [rs close];
    }];
    return ret;
}

- (NSArray *)_loadAllDepartments{
    __block NSMutableArray *ret = nil;
    [_databaseQueue inDatabase:^(FMDatabase *db) {
        NSString *queryString = [NSString stringWithFormat:@"SELECT * FROM '%@'", ECDEPARTMENT];
        FMResultSet *rs = [db executeQuery:queryString];
        while ([rs next]) {
            ECDepartmentModel *deparment = [self departmentFromResultSet:rs];
            [ret addObject:deparment];
            break;
        }
        [rs close];
    }];
    return ret;

}

- (ECContactModel *)_loadContactWithID:(NSString *)eid{
    __block ECContactModel *ret = nil;
    [_databaseQueue inDatabase:^(FMDatabase *db) {
        NSString *queryString = [NSString stringWithFormat:@"SELECT * FROM '%@' WHERE %@=?", ECCONTACT, ECCONTACT_EID];
        FMResultSet *rs = [db executeQuery:queryString,eid];
        while ([rs next]) {
            ret = [self contactFromResultSet:rs];
            break;
        }
        [rs close];
    }];
    return ret;
}

- (NSArray *)_loadAllContacts{
    __block NSMutableArray *ret = nil;
    [_databaseQueue inDatabase:^(FMDatabase *db) {
        NSString *queryString = [NSString stringWithFormat:@"SELECT * FROM '%@'", ECCONTACT];
        FMResultSet *rs = [db executeQuery:queryString];
        while ([rs next]) {
            ECContactModel *contactModel = [self contactFromResultSet:rs];
            [ret addObject:contactModel];
            break;
        }
        [rs close];
    }];
    return ret;
}

#pragma mark - create tables
- (void)_createContactTableForDB:(FMDatabase *)db
{
    if (db) {
        NSString *createStr = [NSString stringWithFormat:@"create table if not exists `%@` (`%@` varchar primary key not null unique, `%@` varchar,`%@` varchar, `%@` varchar, `%@` varchar, `%@` varchar)", ECCONTACT, ECCONTACT_EID, ECCONTACT_NICKNAME, ECCONTACT_IMAGEPATH, ECCONTACT_PHONE, ECCONTACT_DEPARTMENTID,ECCONTACT_BGIMAGEPATH];
        [db executeUpdate:createStr];
    }
}

- (void)_createDepartmentTableForDB:(FMDatabase *)db
{
    if (db) {
        NSString *createStr = [NSString stringWithFormat:@"create table if not exists `%@` (`%@` varchar primary key not null unique, `%@` varchar,`%@` varchar, `%@` varchar, `%@` varchar, `%@` varchar, `%@` integer)", ECDEPARTMENT, ECDEPARTMENT_ID, ECDEPARTMENT_NAME, ECDEPARTMENT_MEMBERS, ECDEPARTMENT_SUBIDS, ECDEPARTMENT_SUPID,ECDEPARTMENT_IMAGEPATH,ECDEPARTMENT_LEVEL];
        [db executeUpdate:createStr];
    }
}

#pragma mark - update cell
- (BOOL)updateDepartment:(ECDepartmentModel *)deparment loginAccount:(NSString *)account{
    __block BOOL ret = NO;
    if ([self.loginAccount isEqualToString:account]) {
        [_databaseQueue inDatabase:^(FMDatabase *db) {
            ret = [self _updateDepartment:deparment forDB:db];
        }];
    }
    return ret;
}

- (BOOL)updateContact:(ECContactModel *)contact loginAccount:(NSString *)account{
    __block BOOL ret = NO;
    if (self.loginAccount == account) {
        [_databaseQueue inDatabase:^(FMDatabase *db) {
            ret = [self _updateContact:contact forDB:db];
        }];
    }
    return ret;
}

#pragma mark - insert cell
- (BOOL)insertDepartment:(ECDepartmentModel *)deparment loginAccount:(NSString *)account{
    __block BOOL ret = NO;
    if (self.loginAccount == account) {
        [_databaseQueue inDatabase:^(FMDatabase *db) {
            ret = [self _insertDepartment:deparment forDB:db];
        }];
    }
    return ret;
}

- (BOOL)insertContact:(ECContactModel *)contact loginAccount:(NSString *)account{
    __block BOOL ret = NO;
    if (self.loginAccount == account) {
        [_databaseQueue inDatabase:^(FMDatabase *db) {
            ret = [self _insertContact:contact forDB:db];
        }];
    }
    return ret;
}

#pragma mark - delete cell
- (BOOL)deleteDepartmentWithId:(NSString *)departmentId loginAccountL:(NSString *)account{
    BOOL ret = NO;
    if (self.loginAccount == account) {
        ret = [self _deleteDepartmentWithId:departmentId];
    }
    return ret;
}

- (BOOL)deleteContactWithEid:(NSString *)eid loginAccountL:(NSString *)account{
    BOOL ret = NO;
    if (self.loginAccount == account) {
        ret = [self _deleteContactWithEid:eid];
    }
    return ret;
}

#pragma mark - load db
- (ECDepartmentModel *)loadDepartmentWithID:(NSString *)departmentId loginAccount:(NSString *)account{
    __block ECDepartmentModel *ret = nil;
    if (self.loginAccount == account) {
        ret = [self _loadDepartmentWithID:departmentId];
    }
    return ret;
}

- (NSArray *)loadAllDepartmentsForAccount:(NSString *)account{
    return nil;
}

- (ECContactModel *)loadContactWithID:(NSString *)eid loginAccount:(NSString *)account{
    __block ECContactModel *ret = nil;
    if (self.loginAccount == account) {
        ret = [self _loadContactWithID:eid];
    }
    return ret;
}

- (NSArray *)loadAllContactsForAccount:(NSString *)account{
    return nil;
}

#pragma mark - actions
- (ECDepartmentModel *)departmentFromResultSet:(FMResultSet *)rs{
    ECDepartmentModel *ret = [[ECDepartmentModel alloc] init];
    ret.departmentId = [rs stringForColumn:ECDEPARTMENT_ID];
    ret.departmentName = [rs stringForColumn:ECDEPARTMENT_NAME];
    ret.departmentSupId = [rs stringForColumn:ECDEPARTMENT_SUPID];
    ret.departmentLevel = [[rs stringForColumn:ECDEPARTMENT_LEVEL] integerValue];
    ret.departmentImagePath = [rs stringForColumn:ECDEPARTMENT_IMAGEPATH];
    NSString *members = [rs stringForColumn:ECDEPARTMENT_MEMBERS];
    NSArray *memberAry = [members componentsSeparatedByString:@"_"];
    ret.deparementMembers = [[NSMutableArray alloc] initWithArray:memberAry];
    NSString *subIds = [rs stringForColumn:ECDEPARTMENT_SUBIDS];
    NSArray *subIdAry = [subIds componentsSeparatedByString:@"_"];
    ret.departmentSubIds = [[NSMutableArray alloc] initWithArray:subIdAry];
    return ret;
}

- (ECContactModel *)contactFromResultSet:(FMResultSet *)rs{
    ECContactModel *ret = [[ECContactModel alloc] init];
    ret.contactEid = [rs stringForColumn:ECCONTACT_EID];
    ret.contactNickname = [rs stringForColumn:ECCONTACT_NICKNAME];
    ret.contactBgImagePath = [rs stringForColumn:ECCONTACT_BGIMAGEPATH];
    ret.contactDepartmentId = [rs stringForColumn:ECCONTACT_DEPARTMENTID];
    ret.contactHeadImagePath = [rs stringForColumn:ECCONTACT_IMAGEPATH];
    ret.contactPhoneNumber = [rs stringForColumn:ECCONTACT_PHONE];
    return ret;
}

@end
