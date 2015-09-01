//
//  ECBaseCellModel.m
//  enterpriseChat
//
//  Created by dujiepeng on 15/7/31.
//  Copyright (c) 2015年 easemob. All rights reserved.
//

#import "ECBaseCellModel.h"
#import "ECContactModel.h"
@interface ECBaseCellModel ()

@end

@implementation ECBaseCellModel
@dynamic showName;

-(NSString *)showName{
    return self.nickname?self.nickname:self.eid;
}

-(NSString *)searchKey{
    return self.contactDelegate.searchKey;
}

-(NSString *)eid{
    return self.contactDelegate.eid;
}

-(NSString *)nickname{
    return self.contactDelegate.nickname;
}

-(NSString *)headerRemotePath{
    return self.contactDelegate.headImagePath;
}


+(CGFloat)heightForRowFromModel:(ECBaseCellModel *)model{
    if (model.cellHeight == 0) {
        model.cellHeight = 64;
    }
    return model.cellHeight;
}

+(ECBaseCellModel *)createModelWithContactModel:(ECContactModel *)contactModel{
    ECBaseCellModel *ret = [[ECBaseCellModel alloc] init];
    ret.contactDelegate = contactModel;
    return ret;
}

@end
