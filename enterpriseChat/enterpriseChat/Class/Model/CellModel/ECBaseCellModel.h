//
//  ECBaseCellModel.h
//  enterpriseChat
//
//  Created by dujiepeng on 15/7/31.
//  Copyright (c) 2015年 easemob. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ECContactDelegate;
@interface ECBaseCellModel : NSObject
@property (nonatomic, strong, readonly) NSString *showName;
@property (nonatomic, strong, readonly) NSString *nickname;
@property (nonatomic, strong, readonly) NSString *eid;
@property (nonatomic, strong, readonly) NSString *headerRemotePath;
@property (nonatomic, strong, readonly) UIImage *headerPlaceholderImage;
@property (nonatomic, strong, readonly) NSString *searchKey;
@property (nonatomic) id <ECContactDelegate> contactDelegate;
@property (nonatomic) CGFloat cellHeight;
+(CGFloat)heightForRowFromModel:(ECBaseCellModel *)model;
@end
