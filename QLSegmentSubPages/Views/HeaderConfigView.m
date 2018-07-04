//
//  HeaderConfigView.m
//  QLSegmentSubPages
//
//  Created by qianlei on 2018/6/7.
//  Copyright © 2018年 qianlei. All rights reserved.
//

#import "HeaderConfigView.h"

@interface HeaderConfigView ()

@property (nonatomic, strong) UILabel *headerLabel;

@end

@implementation HeaderConfigView

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor greenColor];
        [self addSubview:self.headerLabel];
    }
    
    return self;
}

#pragma mark - setter and getter
- (UILabel *)headerLabel {
    if (!_headerLabel) {
        _headerLabel = [[UILabel alloc] init];
        _headerLabel.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        _headerLabel.font = [UIFont systemFontOfSize:16.0];
        _headerLabel.textAlignment = NSTextAlignmentCenter;
        _headerLabel.text = @"header view";
    }
    
    return _headerLabel;
}

@end
