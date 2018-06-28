//
//  QLSegmentTitleView.m
//  QLSegmentSubPages
//
//  Created by qianlei on 2018/6/6.
//  Copyright © 2018年 qianlei. All rights reserved.
//

#import "QLSegmentTitleView.h"

#define DefaultTitleHeight 30   //默认的高度

@interface QLSegmentTitleView ()

@property (nonatomic, strong) UIScrollView *titleScrollView;    //标题的scrollview
@property (nonatomic, strong) UIView *underlineView;  //下划线

@end

@implementation QLSegmentTitleView

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0];
        [self addSubview:self.titleScrollView];
        [self addSubview:self.underlineView];
        self.selectItemColor = [UIColor redColor];
        self.normalItemColor = [UIColor blackColor];
        self.titleTextFont = [UIFont systemFontOfSize:13.0];
        self.underlineHeight = 2;
        self.underlineWidthEqualText = YES;
        self.selectedItemIndex = 0;
    }
    
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        self = [self initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), DefaultTitleHeight)];
    }
    
    return self;
}

#pragma mark - event response
- (void)buttonClicked:(UIButton *)sender {
    BOOL hasChangeSelect = NO;  //当前选中项与原先的是否一样
    if (sender.tag != (self.selectedItemIndex + 1)) {
        hasChangeSelect = YES;
    }
    self.selectedItemIndex = sender.tag - 1;
    [self setItemsCommonUIState];
    if (_delegate && [_delegate respondsToSelector:@selector(didChangeSelectItem:atIndex:)]) {
        [_delegate didChangeSelectItem:hasChangeSelect atIndex:self.selectedItemIndex];
    }
}

#pragma mark - private
//设置标题的内容信息
- (void)setTitleItemsWithArray:(NSArray *)headList {
    if(headList && [headList count] > 0) {
        for (int i = 0; i < [headList count]; i++) {
            UIButton *titleBtn = [self.titleScrollView viewWithTag:i + 1];
            if (!titleBtn) {
                titleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
                titleBtn.backgroundColor = [UIColor clearColor];
                titleBtn.tag = i + 1;
                [titleBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
                [titleBtn setTitle:[NSString stringWithFormat:@"%@", [headList objectAtIndex:i]] forState:UIControlStateNormal];
                [self.titleScrollView addSubview:titleBtn];
            }
            [self setItemsCommonUIState];
        }
    }
}

//设置item的字体，颜色，根据itemWidth设置frame
- (void)setItemsCommonUIState {
    if (self.titlesArray && self.titlesArray.count > 0) {
        for (int i = 0; i < self.titlesArray.count; i++) {
            UIButton *titleBtn = [self.titleScrollView viewWithTag:i + 1];
            if (titleBtn) {
                titleBtn.frame = CGRectMake(self.itemWidth * i, 0, self.itemWidth, CGRectGetHeight(self.frame) - self.underlineHeight);
                titleBtn.titleLabel.font = self.titleTextFont;
                if (self.selectedItemIndex == i) {  //选中条目的UI
                    [titleBtn setTitleColor:self.selectItemColor forState:UIControlStateNormal];
                    self.underlineView.backgroundColor = self.selectItemColor;
                    NSString *titleString = [self.titlesArray objectAtIndex:i];
                    CGFloat underlineWidth = self.itemWidth;    //下划线宽度
                    if (titleString && ![titleString isEqual:[NSNull null]] && ![titleString isKindOfClass:[NSNull class]]) {
                        CGSize size = [titleString sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:self.titleTextFont, NSFontAttributeName, nil]];
                        if (self.underlineWidthEqualText) {
                            underlineWidth = size.width + 2;
                        }
                    }
                    CGFloat underlineOriginX = self.itemWidth * i + (self.itemWidth - underlineWidth) / 2;
                    self.underlineView.frame = CGRectMake(underlineOriginX, CGRectGetHeight(self.frame) - self.underlineHeight, underlineWidth, self.underlineHeight);
                } else {
                    [titleBtn setTitleColor:self.normalItemColor forState:UIControlStateNormal];
                }
            }
        }
    }
}

//计算适配item的宽度值
- (CGFloat)calculateItemWidthWithOriginalWidth:(CGFloat)width {
    CGFloat resultWidth = width;
    if (self.titlesArray.count > 0) {
        if (width == 0) {  //当宽度为0时，以item文案的最大宽度为宽度
            CGFloat maxTextWidth = 0;   //记录文案的最大宽度
            for (NSString *titleString in self.titlesArray) {
                if (titleString && ![titleString isEqual:[NSNull null]] && ![titleString isKindOfClass:[NSNull class]]) {
                    CGSize size = [titleString sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:self.titleTextFont, NSFontAttributeName, nil]];
                    if (maxTextWidth < size.width + 10) {
                        maxTextWidth = size.width + 10;
                    }
                }
            }
            resultWidth = maxTextWidth;
        }
        if (resultWidth * self.titlesArray.count < CGRectGetWidth([UIScreen mainScreen].bounds)) {    //title的宽度没有屏幕宽，则以屏幕的宽度放所有的item
            resultWidth = CGRectGetWidth([UIScreen mainScreen].bounds) / self.titlesArray.count;
        }
    }
    
    return resultWidth;
}

#pragma mark - setter and getter
- (void)setTitlesArray:(NSArray *)titlesArray {
    _titlesArray = [titlesArray copy];
    if (_titlesArray && _titlesArray.count > 0) {
        [self setItemWidth:self.itemWidth];
        [self setTitleItemsWithArray:_titlesArray];
    }
}

- (void)setSelectedItemIndex:(NSUInteger)selectedItemIndex {
    if (_selectedItemIndex != selectedItemIndex) {
        _selectedItemIndex = selectedItemIndex;
        [self setItemsCommonUIState];
    }
}

- (void)setItemWidth:(CGFloat)itemWidth {
    _itemWidth = itemWidth;
    if (self.titlesArray && self.titlesArray.count > 0) {
        _itemWidth = [self calculateItemWidthWithOriginalWidth:itemWidth];
    }
}

- (void)setNormalItemColor:(UIColor *)normalItemColor {
    _normalItemColor = normalItemColor;
    [self setItemsCommonUIState];
}

- (void)setSelectItemColor:(UIColor *)selectItemColor {
    _selectItemColor = selectItemColor;
    [self setItemsCommonUIState];
}

- (void)setTitleTextFont:(UIFont *)titleTextFont {
    _titleTextFont = titleTextFont;
    [self setItemsCommonUIState];
}

- (void)setUnderlineHeight:(NSUInteger)underlineHeight {
    _underlineHeight = underlineHeight;
    [self setItemsCommonUIState];
}

- (void)setUnderlineWidthEqualText:(BOOL)underlineWidthEqualText {
    _underlineWidthEqualText = underlineWidthEqualText;
    [self setItemsCommonUIState];
}

- (UIScrollView *)titleScrollView {
    if (!_titleScrollView) {
        _titleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        _titleScrollView.backgroundColor = [UIColor clearColor];
        _titleScrollView.showsHorizontalScrollIndicator = NO;
        _titleScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    }
    
    return _titleScrollView;
}

- (UIView *)underlineView {
    if (!_underlineView) {
        _underlineView = [[UILabel alloc] initWithFrame:CGRectZero];
        _underlineView.backgroundColor = [UIColor redColor];
    }
    
    return _underlineView;
}

@end
