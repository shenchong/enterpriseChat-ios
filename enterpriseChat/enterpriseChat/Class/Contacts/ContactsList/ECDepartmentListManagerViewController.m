//
//  ECDepartmentListManagerViewController.m
//  enterpriseChat
//
//  Created by dujiepeng on 15/9/25.
//  Copyright © 2015年 easemob. All rights reserved.
//

#import "ECDepartmentListManagerViewController.h"
#import "ECDepartmentListViewController.h"
#import "ECScrollView.h"

@interface ECDepartmentListManagerViewController ()<UINavigationControllerDelegate>
@property (nonatomic, strong) ECDepartmentListViewController *departmentListVC;

@end

@implementation ECDepartmentListManagerViewController

-(instancetype)init{
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self.departmentListVC];
    nav.delegate = self;
    [nav setNavigationBarHidden:YES animated:NO];
    [self addChildViewController:nav];
    [self.view addSubview:nav.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(ECDepartmentListViewController *)departmentListVC{
    if (!_departmentListVC) {
        _departmentListVC = [ECDepartmentListViewController departmentListWithDepartment:self.topDepartment];

    }
    return _departmentListVC;
}

- (void)setupUI{

}

-(void)dealloc{
    DLog(@"dealloc");
}

- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated{

}

@end
