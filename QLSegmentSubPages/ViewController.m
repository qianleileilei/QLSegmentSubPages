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

@property (nonatomic, strong) UIButton *button;

@end

@implementation ViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.button];
    
}

#pragma mark - event response
- (void)buttonClicked {
    TotalPageViewController *pageViewController = [[TotalPageViewController alloc] init];
    
    [self.navigationController pushViewController:pageViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIButton *)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeSystem];
        _button.frame = CGRectMake((CGRectGetWidth(self.view.frame) - 100) / 2, 160, 100, 60);
        _button.backgroundColor = [UIColor redColor];
        [_button setTitle:@"entry" forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _button;
}

@end
