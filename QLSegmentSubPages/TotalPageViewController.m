//
//  TotalPageViewController.m
//  QLSegmentSubPages
//
//  Created by qianlei on 2018/6/28.
//  Copyright © 2018年 qianlei. All rights reserved.
//

#import "TotalPageViewController.h"
#import "SegmentSubPageView.h"
#import "QLSegmentTitleView.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"

@interface TotalPageViewController () <SegmentSubPageDelegate>

@property (nonatomic, strong) SegmentSubPageView *configSubPageView;

@end

@implementation TotalPageViewController


#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"页面嵌套";
    [self.view addSubview:self.configSubPageView];
    self.configSubPageView.segmentTitleView.titlesArray = @[@"第一页", @"第二页", @"第三页"];
    
    //初始化子页面的配置
    __weak __typeof(self) weakSelf = self;
    ConfigSubControllerBlock firstPage = ^(){
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        FirstViewController *firstViewController = [[FirstViewController alloc] init];
        [strongSelf addChildViewController:firstViewController];
        return firstViewController;
    };
    ConfigSubControllerBlock secondPage = ^(){
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        SecondViewController *secondViewController = [[SecondViewController alloc] init];
        [strongSelf addChildViewController:secondViewController];
        return secondViewController;
    };
    ConfigSubControllerBlock thirdPage = ^(){
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        ThirdViewController *thirdViewController = [[ThirdViewController alloc] init];
        [strongSelf addChildViewController:thirdViewController];
        return thirdViewController;
    };
    
    self.configSubPageView.registerSubPages = [NSArray arrayWithObjects:firstPage, secondPage, thirdPage, nil];
}


#pragma mark - SegmentSubPageDelegate
/**
 切换页面时会触发这个方法回掉，可以在此处调用对应页面的刷新方法
 */
- (void)frontPageController:(UIViewController *)controller itemIndex:(NSInteger)index {
    NSLog(@"controller = %@", controller);
}


#pragma mark - event response

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - setter and getter
- (SegmentSubPageView *)configSubPageView {
    if (!_configSubPageView) {
        _configSubPageView = [[SegmentSubPageView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 64)];
        _configSubPageView.defaultSelectPageIndex = 2;
        _configSubPageView.delegate = self;
    }
    
    return _configSubPageView;
}

@end
