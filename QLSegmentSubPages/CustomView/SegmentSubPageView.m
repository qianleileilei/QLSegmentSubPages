//
//  SegmentSubPageView.m
//  QLSegmentSubPages
//
//  Created by qianlei on 2018/6/6.
//  Copyright © 2018年 qianlei. All rights reserved.
//

#import "SegmentSubPageView.h"
#import "QLSegmentTitleView.h"

@interface SegmentSubPageView () <UIScrollViewDelegate, SegmentTitleViewDelegate>

@property (nonatomic, strong) UIScrollView *totalContainerScrollView;    //页面的上线滑动view
@property (nonatomic, strong) UIScrollView *subPageContainerScrollView; //子页面容器view
@property (nonatomic, assign) NSInteger currentPageIndex; //当前显示的页面index
@property (nonatomic, strong) NSMutableDictionary *usedSubContrlllersDic;   //记录已经加载过的子页面，避免滑动时重复加载

@end

@implementation SegmentSubPageView

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _defaultSelectPageIndex = 0;
        _currentPageIndex = 0;
        [self addSubview:self.totalContainerScrollView];
        [self.totalContainerScrollView addSubview:self.segmentTitleView];
        [self.totalContainerScrollView addSubview:self.subPageContainerScrollView];
    }
    
    return self;
}

#pragma mark - SegmentTitleViewDelegate
- (void)didChangeSelectItem:(BOOL)hasChange atIndex:(NSUInteger)itemIndex {
    if (hasChange) {    //只有切换item的点击下，才响应事件
        self.currentPageIndex = itemIndex;
        [self resetCustomViewShow];
        [UIView animateWithDuration:0.3 animations:^{
            self.subPageContainerScrollView.contentOffset = CGPointMake(self.currentPageIndex * CGRectGetWidth(self.frame), 0);
        }];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}                                               

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;
    if (self.currentPageIndex != index) {
        self.currentPageIndex = index;
        [self resetCustomViewShow];
    }
}

#pragma mark - event response
//根据属性的配置更新view的内部显示
- (void)resetCustomViewShow {
    if (self.registerSubPages && self.registerSubPages.count > 0) {
        self.segmentTitleView.selectedItemIndex = self.currentPageIndex;
        NSString *usedKeyString = [NSString stringWithFormat:@"%ld", self.currentPageIndex];    //记录当前页面的key
        if (!_usedSubContrlllersDic || ![self.usedSubContrlllersDic.allKeys containsObject:usedKeyString]) {
            //当前页面还没有被加载
            UIViewController *frontControllerBlock = [self.registerSubPages objectAtIndex:self.currentPageIndex]();
            [self.subPageContainerScrollView addSubview:frontControllerBlock.view];
            frontControllerBlock.view.frame = CGRectMake(CGRectGetWidth(self.subPageContainerScrollView.frame) * self.currentPageIndex, 0, CGRectGetWidth(self.subPageContainerScrollView.frame), CGRectGetHeight(self.subPageContainerScrollView.frame));
            [self.usedSubContrlllersDic setValue:frontControllerBlock forKey:usedKeyString];
        }
        if (_delegate && [_delegate respondsToSelector:@selector(frontPageController:itemIndex:)]) {
            [_delegate frontPageController:[self.usedSubContrlllersDic valueForKey:usedKeyString] itemIndex:[usedKeyString integerValue]];
        }
    }
}

#pragma mark - setter and getter
- (void)setRegisterSubPages:(NSArray<ConfigSubControllerBlock> *)registerSubPages {
    _registerSubPages = [registerSubPages copy];
    if (_registerSubPages && _registerSubPages.count > 0) {
        self.subPageContainerScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.frame) * _registerSubPages.count, CGRectGetHeight(self.subPageContainerScrollView.frame));
        [self resetCustomViewShow];
        self.subPageContainerScrollView.contentOffset = CGPointMake(self.currentPageIndex * CGRectGetWidth(self.frame), 0);
    }
}

- (void)setDefaultSelectPageIndex:(NSInteger)defaultSelectPageIndex {
    _defaultSelectPageIndex = defaultSelectPageIndex;
    //设置了默认选中页，调用刷新view显示的方法
    if (_defaultSelectPageIndex > 0) {
        self.currentPageIndex = _defaultSelectPageIndex;
        [self resetCustomViewShow];
        self.subPageContainerScrollView.contentOffset = CGPointMake(self.currentPageIndex * CGRectGetWidth(self.frame), 0);
    }
}

- (UIScrollView *)totalContainerScrollView {
    if (!_totalContainerScrollView) {
        _totalContainerScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        _totalContainerScrollView.showsVerticalScrollIndicator = NO;
        _totalContainerScrollView.pagingEnabled = NO;
        _totalContainerScrollView.scrollEnabled = YES;
    }
    
    return _totalContainerScrollView;
}

- (QLSegmentTitleView *)segmentTitleView {
    if (!_segmentTitleView) {
        _segmentTitleView = [[QLSegmentTitleView alloc] initWithFrame:CGRectMake(0, self.headerViewHeight, CGRectGetWidth(self.frame), 40)];
        _segmentTitleView.delegate = self;
    }
    
    return _segmentTitleView;
}

- (UIScrollView *)subPageContainerScrollView {
    if (!_subPageContainerScrollView) {
        _subPageContainerScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.segmentTitleView.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - CGRectGetMaxY(self.segmentTitleView.frame))];
        _subPageContainerScrollView.userInteractionEnabled = YES;
        _subPageContainerScrollView.delegate = self;
        _subPageContainerScrollView.scrollEnabled = YES;
        _subPageContainerScrollView.showsHorizontalScrollIndicator = NO;
        _subPageContainerScrollView.pagingEnabled = YES;
        _subPageContainerScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - CGRectGetMaxY(self.segmentTitleView.frame));
    }
    
    return _subPageContainerScrollView;
}

- (NSMutableDictionary *)usedSubContrlllersDic {
    if (!_usedSubContrlllersDic) {
        _usedSubContrlllersDic = [NSMutableDictionary new];
    }
    
    return _usedSubContrlllersDic;
}

@end
