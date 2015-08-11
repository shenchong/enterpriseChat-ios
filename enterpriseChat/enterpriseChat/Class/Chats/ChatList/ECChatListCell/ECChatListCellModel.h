//
//  ECChatListCellModel.h
//  enterpriseChat
//
//  Created by dujiepeng on 15/7/30.
//  Copyright (c) 2015年 easemob. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ECBaseCellModel.h"
@interface ECChatListCellModel : ECBaseCellModel
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *msgInfo;
@end
