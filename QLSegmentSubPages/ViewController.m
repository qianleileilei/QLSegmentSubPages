//
//  ViewController.m
//  QLSegmentSubPages
//
//  Created by qianlei on 2018/6/6.
//  Copyright © 2018年 qianlei. All rights reserved.
//

#import "ViewController.h"
#import "TotalPageViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UIButton *button2;
@property (nonatomic, strong) UIButton *button3;
@property (nonatomic, strong) UIButton *button4;

@end

@implementation ViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.button1];
    [self.view addSubview:self.button2];
    [self.view addSubview:self.button3];
    [self.view addSubview:self.button4];
}

#pragma mark - event response
- (void)buttonClicked:(UIButton *)sender {
    TotalPageViewController *pageViewController = [[TotalPageViewController alloc] init];
    pageViewController.effectType = sender.tag;
    [self.navigationController pushViewController:pageViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIButton *)button1 {
    if (!_button1) {
        _button1 = [UIButton buttonWithType:UIButtonTypeSystem];
        _button1.frame = CGRectMake((CGRectGetWidth(self.view.frame) - 260) / 2, 160, 260, 40);
        _button1.backgroundColor = [UIColor redColor];
        _button1.tag = kPageEffectBasicType;
        [_button1 setTitle:@"基础页面切换" forState:UIControlStateNormal];
        [_button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_button1 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _button1;
}

- (UIButton *)button2 {
    if (!_button2) {
        _button2 = [UIButton buttonWithType:UIButtonTypeSystem];
        _button2.frame = CGRectMake((CGRectGetWidth(self.view.frame) - 260) / 2, CGRectGetMaxY(self.button1.frame) + 20, 260, 40);
        _button2.tag = kPageEffectMiddleTitleType;
        _button2.backgroundColor = [UIColor redColor];
        [_button2 setTitle:@"选中title居中" forState:UIControlStateNormal];
        [_button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_button2 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _button2;
}

- (UIButton *)button3 {
    if (!_button3) {
        _button3 = [UIButton buttonWithType:UIButtonTypeSystem];
        _button3.frame = CGRectMake((CGRectGetWidth(self.view.frame) - 260) / 2, CGRectGetMaxY(self.button2.frame) + 20, 260, 40);
        _button3.backgroundColor = [UIColor redColor];
        _button3.tag = kPageEffectHeaderViewType;
        [_button3 setTitle:@"headerView的效果" forState:UIControlStateNormal];
        [_button3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_button3 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _button3;
}

- (UIButton *)button4 {
    if (!_button4) {
        _button4 = [UIButton buttonWithType:UIButtonTypeSystem];
        _button4.frame = CGRectMake((CGRectGetWidth(self.view.frame) - 260) / 2, CGRectGetMaxY(self.button3.frame) + 20, 260, 40);
        _button4.backgroundColor = [UIColor redColor];
        _button4.tag = kPageEffectDynamicHeaderViewType;
        [_button4 setTitle:@"动态headerView的效果" forState:UIControlStateNormal];
        [_button4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_button4 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _button4;
}

@end
