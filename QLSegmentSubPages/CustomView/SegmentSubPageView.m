//
//  SegmentSubPageView.m
//  QLSegmentSubPages
//
//  Created by qianlei on 2018/6/6.
//  Copyright © 2018年 qianlei. All rights reserved.
//

#import "SegmentSubPageView.h"
#import "QLSegmentTitleView.h"
#import <WebKit/WebKit.h>

@interface SegmentSubPageView () <UIScrollViewDelegate, SegmentTitleViewDelegate>

@property (nonatomic, strong) UIScrollView *totalContainerScrollView;    //页面的滑动容器view
@property (nonatomic, strong) UIScrollView *subPageContainerScrollView; //子页面容器view
@property (nonatomic, assign) NSInteger currentPageIndex; //当前显示的页面index
@property (nonatomic, strong) NSMutableDictionary *usedSubContrlllersDic;   //记录已经加载过的子页面，避免滑动时重复加载
@property (nonatomic, strong) NSMutableArray *subScrollViewsArray;    //子页面ScrollView
@property (nonatomic, assign) CGFloat totalScrollViewOffsetY;   //记录底层容器ScrollView的contentOffset

@end

@implementation SegmentSubPageView

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _defaultSelectPageIndex = 0;
        _currentPageIndex = 0;
        _titleViewHeight = 40;
        _totalScrollViewOffsetY = 0;
        [self addSubview:self.totalContainerScrollView];
        [self.totalContainerScrollView addSubview:self.segmentTitleView];
        [self.totalContainerScrollView addSubview:self.subPageContainerScrollView];
    }
    
    return self;
}

- (void)dealloc {
    if (_subScrollViewsArray) {   //移除KVO监听
        for (UIScrollView *subScrollView in self.subScrollViewsArray) {
            [subScrollView removeObserver:self forKeyPath:@"contentOffset"];
        }
    }
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
    if (scrollView == self.totalContainerScrollView) {
        CGRect scrollBounds = self.totalContainerScrollView.bounds;
        scrollBounds.origin.y = scrollView.contentOffset.y;
//        UIScrollView *currenSubScrollView = [self obtainCurrentSubPageContainerScrollViewWithUseKVOMonitor:NO];
        if (scrollView.contentOffset.y >= CGRectGetHeight(self.headerView.frame)) {
            scrollBounds.origin.y = CGRectGetHeight(self.headerView.frame);
        } else if (scrollView.contentOffset.y <= 0) {
            scrollBounds.origin.y = 0;
        }
        self.totalScrollViewOffsetY = scrollView.contentOffset.y;
        self.totalContainerScrollView.bounds = scrollBounds;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.subPageContainerScrollView) {
        NSInteger index = fabs(scrollView.contentOffset.x) / scrollView.frame.size.width;
        if (self.currentPageIndex != index) {
            self.currentPageIndex = index;
            [self resetCustomViewShow];
        }
    }
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"] && [object isKindOfClass:[UIScrollView class]]) {
        CGFloat oldOffsetY = ((NSValue *)change[NSKeyValueChangeOldKey]).UIOffsetValue.vertical;   //原来的偏移
        CGFloat newOffsetY = ((NSValue *)change[NSKeyValueChangeNewKey]).UIOffsetValue.vertical;   //新的偏移
//        UIScrollView *subPageScrollView = (UIScrollView *)object;
        if (newOffsetY > oldOffsetY) {  //页面向上滑动
            NSLog(@"页面向上滑动");
//            CGRect totalScrollBounds = self.totalContainerScrollView.bounds;
//            if (subPageScrollView.contentOffset.y >= 0 && self.totalContainerScrollView.contentOffset.y < CGRectGetHeight(self.headerView.frame)) {
//                //headerView已经滑出显示区域
//                totalScrollBounds.origin.y = totalScrollBounds.origin.y + (newOffsetY - oldOffsetY);
//                if (totalScrollBounds.origin.y > CGRectGetHeight(self.headerView.frame)) {
//                    totalScrollBounds.origin.y = CGRectGetHeight(self.headerView.frame);
//                }
//                self.totalContainerScrollView.bounds = totalScrollBounds;
//            }
        } else if(newOffsetY < oldOffsetY) {    //页面向下滑动
            NSLog(@"页面向下滑动");
//            CGRect totalScrollBounds = self.totalContainerScrollView.bounds;
//            if (self.totalContainerScrollView.contentOffset.y > 0 && self.totalContainerScrollView.contentOffset.y <= CGRectGetHeight(self.headerView.frame)) {
//                totalScrollBounds.origin.y = totalScrollBounds.origin.y - (oldOffsetY - newOffsetY);
//                if (totalScrollBounds.origin.y < 0) {
//                    totalScrollBounds.origin.y = 0;
//                }
//                self.totalContainerScrollView.bounds = totalScrollBounds;
//            }
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - event response
//根据属性的配置更新view的内部显示
- (void)resetCustomViewShow {
    if (self.registerSubPages && self.registerSubPages.count > 0) {
        self.segmentTitleView.selectedItemIndex = self.currentPageIndex;
        NSString *usedKeyString = [NSString stringWithFormat:@"%ld", (long)self.currentPageIndex];    //记录当前页面的key
        if (!_usedSubContrlllersDic || ![self.usedSubContrlllersDic.allKeys containsObject:usedKeyString]) {
            //当前页面还没有被加载
            UIViewController *frontControllerBlock = [self.registerSubPages objectAtIndex:self.currentPageIndex]();
            [self.subPageContainerScrollView addSubview:frontControllerBlock.view];
            frontControllerBlock.view.frame = CGRectMake(CGRectGetWidth(self.subPageContainerScrollView.frame) * self.currentPageIndex, 0, CGRectGetWidth(self.subPageContainerScrollView.frame), CGRectGetHeight(self.subPageContainerScrollView.frame));
            [self.usedSubContrlllersDic setValue:frontControllerBlock forKey:usedKeyString];
            [self obtainCurrentSubPageContainerScrollViewWithUseKVOMonitor:YES];  //监听子页面scrollView的contentOffset
        }
        if (_delegate && [_delegate respondsToSelector:@selector(frontPageController:itemIndex:)]) {
            [_delegate frontPageController:[self.usedSubContrlllersDic valueForKey:usedKeyString] itemIndex:[usedKeyString integerValue]];
        }
    }
}

//设置各子控件的frame
- (void)resetSubViewsFrame {
    self.segmentTitleView.frame = CGRectMake(0, CGRectGetHeight(self.headerView.frame), CGRectGetWidth(self.frame), _titleViewHeight);
    self.subPageContainerScrollView.frame = CGRectMake(0, CGRectGetMaxY(self.segmentTitleView.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - self.titleViewHeight);
    self.totalContainerScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.frame), CGRectGetHeight(_headerView.frame) + CGRectGetHeight(self.frame));
}

//设置子页面的scrollView的KVO监听，并返回对应的scrollView
- (UIScrollView *)obtainCurrentSubPageContainerScrollViewWithUseKVOMonitor:(BOOL)useKVO {
    UIScrollView *currentSubPageScrollView = nil;
    NSString *usedKeyString = [NSString stringWithFormat:@"%ld", (long)self.currentPageIndex];    //记录当前页面的key
    //当前页面还没有被加载
    UIViewController *frontControllerBlock = [self.usedSubContrlllersDic valueForKey:usedKeyString];
    if (frontControllerBlock.view.subviews.count > 0) {
        UIView *subPageView =  frontControllerBlock.view.subviews[0]; //取出底层一个子控件
        if ([subPageView isKindOfClass:[UIScrollView class]]) {
            currentSubPageScrollView = (UIScrollView *)subPageView;
        } else if ([subPageView isKindOfClass:[UIWebView class]]) {
            currentSubPageScrollView = ((UIWebView *)subPageView).scrollView;
        } else if ([subPageView isKindOfClass:[WKWebView class]]) {
            currentSubPageScrollView = ((WKWebView *)subPageView).scrollView;
        }
        if (useKVO && currentSubPageScrollView) {   //第一次需要添加KVO监听
            [currentSubPageScrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
            [self.subScrollViewsArray addObject:currentSubPageScrollView];
        }
    }
    return currentSubPageScrollView;
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

- (void)setHeaderView:(UIView *)headerView {
    if (_headerView != headerView) {
        _headerView = headerView;
        [self.totalContainerScrollView addSubview:_headerView];
        [self resetSubViewsFrame];
    }
}

- (void)setTitleViewHeight:(CGFloat)titleViewHeight {
    if (_titleViewHeight != titleViewHeight) {
        _titleViewHeight = titleViewHeight;
        [self resetSubViewsFrame];
        [self.segmentTitleView setItemsCommonUIState];  //重新设置titleView的内部UI
    }
}

- (UIScrollView *)totalContainerScrollView {
    if (!_totalContainerScrollView) {
        _totalContainerScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        _totalContainerScrollView.delegate = self;
        _totalContainerScrollView.showsVerticalScrollIndicator = NO;
        _totalContainerScrollView.pagingEnabled = NO;
        _totalContainerScrollView.scrollEnabled = YES;
    }
    
    return _totalContainerScrollView;
}

- (QLSegmentTitleView *)segmentTitleView {
    if (!_segmentTitleView) {
        _segmentTitleView = [[QLSegmentTitleView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), self.titleViewHeight)];
        _segmentTitleView.delegate = self;
    }
    
    return _segmentTitleView;
}

- (UIScrollView *)subPageContainerScrollView {
    if (!_subPageContainerScrollView) {
        _subPageContainerScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.segmentTitleView.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - CGRectGetHeight(self.segmentTitleView.frame))];
        _subPageContainerScrollView.userInteractionEnabled = YES;
        _subPageContainerScrollView.delegate = self;
        _subPageContainerScrollView.scrollEnabled = YES;
        _subPageContainerScrollView.showsHorizontalScrollIndicator = NO;
        _subPageContainerScrollView.pagingEnabled = YES;
        _subPageContainerScrollView.contentSize = CGSizeMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - CGRectGetHeight(self.segmentTitleView.frame));
    }
    
    return _subPageContainerScrollView;
}

- (NSMutableDictionary *)usedSubContrlllersDic {
    if (!_usedSubContrlllersDic) {
        _usedSubContrlllersDic = [NSMutableDictionary new];
    }
    return _usedSubContrlllersDic;
}

- (NSMutableArray *)subScrollViewsArray {
    if (!_subScrollViewsArray) {
        _subScrollViewsArray = [NSMutableArray new];
    }
    return _subScrollViewsArray;
}

@end
