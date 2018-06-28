//
//  CustomTableViewCell.m
//  QLSegmentSubPages
//
//  Created by qianlei on 2018/6/7.
//  Copyright © 2018年 qianlei. All rights reserved.
//

#import "CustomTableViewCell.h"

@interface CustomTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation CustomTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setContentString:(NSString *)contentString {
    if (_contentString != contentString) {
        _contentString = [contentString copy];
        self.contentLabel.text = _contentString;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
