//
//  ECDBManager.h
//  enterpriseChat
//
//  Created by dujiepeng on 15/8/25.
//  Copyright (c) 2015年 easemob. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ECDBManager : NSObject
@property (strong, nonatomic) NSString *loginAccount;
@property (strong, nonatomic, readonly) NSString *dbPath;
+ (NSError *)openEasemobDatabaseWithAccount:(NSString *)loginAccount;
+ (void)closeEasemobDatabase;
@end
