//
//  ECContactModel.m
//  enterpriseChat
//
//  Created by dujiepeng on 15/8/25.
//  Copyright (c) 2015年 easemob. All rights reserved.
//

#import "ECContactModel.h"

@implementation ECContactModel

#pragma mark - ECContactDelegate
- (NSString *)eid{
    return _contactEid;
}

- (NSString *)nickname{
    return _contactNickname;
}

- (NSString *)headImagePath{
    return _contactHeadImagePath;
}

- (UIImage *)headerPlaceholderImage{
    return _contactPlaceholderImage;
}

- (NSString *)searchKey{
    return self.contactNickname?self.contactNickname:self.contactEid;
}

@end
