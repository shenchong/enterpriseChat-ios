//
//  NSString+Category.m
//  enterpriseChat
//
//  Created by dujiepeng on 15/9/2.
//  Copyright (c) 2015年 easemob. All rights reserved.
//

#import "NSString+Category.h"

@implementation NSString (Category)
+ (NSString *)trimWhiteSpace:(NSString *)str{
    NSString *trimmedString = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return trimmedString;
}

- (BOOL)isEffective{
    return self.length > 0;
}
@end
