//
//  HeaderConfigView.m
//  QLSegmentSubPages
//
//  Created by qianlei on 2018/6/7.
//  Copyright © 2018年 qianlei. All rights reserved.
//

#import "HeaderConfigView.h"

@interface HeaderConfigView ()

@property (nonatomic, strong) UIButton *headerButton;

@end

@implementation HeaderConfigView

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.headerButton];
    }
    
    return self;
}

#pragma mark - event response
- (void)buttonClicked:(UIButton *)sender {
    NSLog(@"button touch up inside");
}

#pragma mark - setter and getter
- (UIButton *)headerButton {
    if (!_headerButton) {
        _headerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _headerButton.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        [_headerButton setTitle:@"header button" forState:UIControlStateNormal];
        _headerButton.backgroundColor = [UIColor blueColor];
        [_headerButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _headerButton;
}

@end
