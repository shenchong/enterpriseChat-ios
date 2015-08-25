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
    return self.showName;
}

-(NSString *)eid{
    return self.contactModel.eid;
}

-(NSString *)nickname{
    return self.contactModel.nickname;
}

-(NSString *)headerRemotePath{
    return self.contactModel.headImagePath;
}


+(CGFloat)heightForRowFromModel:(ECBaseCellModel *)model{
    if (model.cellHeight == 0) {
        model.cellHeight = 64;
    }
    return model.cellHeight;
}

+(ECBaseCellModel *)createModelWithContactModel:(ECContactModel *)contactModel{
    ECBaseCellModel *ret = [[ECBaseCellModel alloc] init];
    ret.contactModel = contactModel;
    return ret;
}

@end
