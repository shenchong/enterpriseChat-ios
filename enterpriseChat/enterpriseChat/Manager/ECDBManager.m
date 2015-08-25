//
//  ECDBManager.m
//  enterpriseChat
//
//  Created by dujiepeng on 15/8/25.
//  Copyright (c) 2015年 easemob. All rights reserved.
//

#import "ECDBManager.h"
#import "FMDB.h"

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
    dbman.loginAccount = loginAccount;
    dbman.databaseQueue = [FMDatabaseQueue databaseQueueWithPath:[self dbPath]];
    if (dbman.databaseQueue) {
        [dbman createTables];
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
    return nil;
}

#pragma mark - private
- (void)createTables{
    [_databaseQueue inDatabase:^(FMDatabase *db) {
        [self createContactTableForDB:db];
    }];
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

#pragma mark - create tables
- (void)createContactTableForDB:(FMDatabase *)db
{
    if (db) {
       
    }
}

@end
