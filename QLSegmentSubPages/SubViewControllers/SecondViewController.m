//
//  SecondViewController.m
//  QLSegmentSubPages
//
//  Created by qianlei on 2018/6/7.
//  Copyright © 2018年 qianlei. All rights reserved.
//

#import "SecondViewController.h"
#import "CustomTableViewCell.h"
#import "Masonry.h"

@interface SecondViewController ()

@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UIImageView *tipImageView;

@end

@implementation SecondViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tipLabel];
    [self.view addSubview:self.tipImageView];
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(10);
        make.left.equalTo(self.view).with.offset(10);
        make.right.equalTo(self.view).with.offset(-10);
        make.height.equalTo(@45);
    }];
    [self.tipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tipLabel.mas_bottom).with.offset(10);
        make.left.equalTo(self.view).with.offset(10);
        make.right.equalTo(self.view).with.offset(-10);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}

#pragma mark - event response

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setter and getter
- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.font = [UIFont systemFontOfSize:16.0];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.text = @"静态页面";
    }
    
    return _tipLabel;
}

- (UIImageView *)tipImageView {
    if (!_tipImageView) {
        _tipImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"9KnqqgZBFe.jpg"]];
    }
    
    return _tipImageView;
}

@end
