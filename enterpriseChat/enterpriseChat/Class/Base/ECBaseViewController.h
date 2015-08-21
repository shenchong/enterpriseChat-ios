//
//  ECBaseViewController.h
//  enterpriseChat
//
//  Created by dujiepeng on 15/7/29.
//  Copyright (c) 2015年 easemob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ECBaseViewController : UIViewController

- (void)setupWithTitle:(NSString *)title
 finishedSelectedImage:(UIImage *)finishImage
withFinishedUnselectedImage:(UIImage *)unselectedImage
                   tag:(NSInteger)tag;

-(UIBarButtonItem *)rightBarButtonItem;
-(UIBarButtonItem *)leftBarButtonItem;
-(void)setupBadgeValue:(NSString *)badgeValue;
@end
