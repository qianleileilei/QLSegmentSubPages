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
#import "FourthViewController.h"
#import "FifthViewController.h"
#import "SixthViewController.h"
#import "SeventhViewController.h"
#import "EighthViewController.h"
#import "NinthViewController.h"
#import "HeaderConfigView.h"

@interface TotalPageViewController () <SegmentSubPageDelegate>

@property (nonatomic, strong) SegmentSubPageView *configSubPageView;
@property (nonatomic, strong) HeaderConfigView *headerView;

@end

@implementation TotalPageViewController


#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"页面嵌套";
    [self.view addSubview:self.configSubPageView];
    switch (self.effectType) {
        case kPageEffectBasicType:
            [self configPageEffectBasicType];
            break;
        case kPageEffectMiddleTitleType:
            [self configPageEffectMiddleTitleType];
            break;
        case kPageEffectHeaderViewType:
            [self configPageEffectHeaderViewType];
            break;
        case kPageEffectDynamicHeaderViewType:
            [self configPageEffectDynamicHeaderViewType];
            break;
        default:
            break;
    }
}

#pragma mark - SegmentSubPageDelegate
/**
 切换页面时会触发这个方法回掉，可以在此处调用对应页面的刷新方法
 */
- (void)frontPageController:(UIViewController *)controller itemIndex:(NSInteger)index {
    NSLog(@"controller = %@", controller);
}


#pragma mark - event response
//配置基础效果
- (void)configPageEffectBasicType {
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


//配置存在headerView的效果
- (void)configPageEffectHeaderViewType {
    self.configSubPageView.segmentTitleView.titlesArray = @[@"第一页", @"第二页", @"第三页"];
    self.configSubPageView.titleViewHeight = 35.0;
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
    self.configSubPageView.headerView = self.headerView;
}

//配置动态headerView的效果
- (void)configPageEffectDynamicHeaderViewType {
    
}

//配置title居中效果
- (void)configPageEffectMiddleTitleType {
    self.configSubPageView.segmentTitleView.titlesArray = @[@"第一页", @"第二页", @"第三页", @"第四页", @"第五页", @"第六页", @"第七页", @"第八页", @"第九页"];
    self.configSubPageView.segmentTitleView.itemWidth = 70;
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
    ConfigSubControllerBlock fourthPage = ^(){
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        FourthViewController *fourthViewController = [[FourthViewController alloc] init];
        [strongSelf addChildViewController:fourthViewController];
        return fourthViewController;
    };
    ConfigSubControllerBlock fifthPage = ^(){
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        FifthViewController *fifthViewController = [[FifthViewController alloc] init];
        [strongSelf addChildViewController:fifthViewController];
        return fifthViewController;
    };
    ConfigSubControllerBlock sixthPage = ^(){
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        SixthViewController *sixthViewController = [[SixthViewController alloc] init];
        [strongSelf addChildViewController:sixthViewController];
        return sixthViewController;
    };
    ConfigSubControllerBlock seventhPage = ^(){
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        SeventhViewController *seventhViewController = [[SeventhViewController alloc] init];
        [strongSelf addChildViewController:seventhViewController];
        return seventhViewController;
    };
    ConfigSubControllerBlock eighthPage = ^(){
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        EighthViewController *eighthViewController = [[EighthViewController alloc] init];
        [strongSelf addChildViewController:eighthViewController];
        return eighthViewController;
    };
    ConfigSubControllerBlock ninthPage = ^(){
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        NinthViewController *ninthViewController = [[NinthViewController alloc] init];
        [strongSelf addChildViewController:ninthViewController];
        return ninthViewController;
    };
    self.configSubPageView.registerSubPages = [NSArray arrayWithObjects:firstPage, secondPage, thirdPage, fourthPage, fifthPage, sixthPage, seventhPage, eighthPage, ninthPage, nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setter and getter
- (SegmentSubPageView *)configSubPageView {
    if (!_configSubPageView) {
        _configSubPageView = [[SegmentSubPageView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 64)];
        _configSubPageView.delegate = self;
    }
    
    return _configSubPageView;
}

- (HeaderConfigView *)headerView {
    if (!_headerView) {
        _headerView = [[HeaderConfigView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 160)];
    }
    
    return _headerView;
}

@end
