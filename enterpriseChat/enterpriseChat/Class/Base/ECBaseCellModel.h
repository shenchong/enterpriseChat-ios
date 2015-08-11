//
//  ECBaseCellModel.h
//  enterpriseChat
//
//  Created by dujiepeng on 15/7/31.
//  Copyright (c) 2015年 easemob. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ECBaseCellModel : NSObject
@property (nonatomic, strong) NSString *showName;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *eid;
@property (nonatomic, strong) NSString *headerRemotePath;
@property (nonatomic, strong, readonly) NSString *searchKey;
@property (nonatomic) CGFloat cellHeight;
+(CGFloat)heightForRowFromModel:(ECBaseCellModel *)model;
@end
