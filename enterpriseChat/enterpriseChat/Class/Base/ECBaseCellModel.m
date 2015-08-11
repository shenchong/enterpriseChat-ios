//
//  ECBaseCellModel.m
//  enterpriseChat
//
//  Created by dujiepeng on 15/7/31.
//  Copyright (c) 2015年 easemob. All rights reserved.
//

#import "ECBaseCellModel.h"

@implementation ECBaseCellModel
@dynamic showName;

-(NSString *)showName{
    return _nickname?_nickname:_eid;
}

-(NSString *)searchKey{
    return self.showName;
}

+(CGFloat)heightForRowFromModel:(ECBaseCellModel *)model{
    if (model.cellHeight == 0) {
        model.cellHeight = 64;
    }
    return model.cellHeight;
}

@end
