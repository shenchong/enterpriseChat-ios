//
//  NSString+Category.h
//  enterpriseChat
//
//  Created by dujiepeng on 15/9/2.
//  Copyright (c) 2015年 easemob. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Category)
+ (NSString *)trimWhiteSpace:(NSString *)str;
- (BOOL)isEffective;
@end
