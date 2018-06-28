//
//  SegmentSubPageView.h
//  QLSegmentSubPages
//
//  Created by qianlei on 2018/6/6.
//  Copyright © 2018年 qianlei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class QLSegmentTitleView;

/** 接受子页面配置的回掉block */
typedef UIViewController * (^ConfigSubControllerBlock)(void);

/**
 `SegmentSubPageView` 是组合视图的容器，可以承接headerView、subViewControllers，并负责控件基本交互的响应处理
 
 */

NS_ASSUME_NONNULL_BEGIN

/** 控件的回掉代理 */
@protocol SegmentSubPageDelegate;

@interface SegmentSubPageView : UIView

/** 多页面的头视图 */
@property (nonatomic, strong, nullable) UIView *headerView;

/** headerView的高度 */
@property (nonatomic, assign) CGFloat headerViewHeight;

/** subpage title  */
@property (nonatomic, strong, nullable) QLSegmentTitleView *segmentTitleView;

/**
 存放配置子页面的数组

 @warning `registerSubPages` must not be `nil`.
 */
@property (nonatomic, copy) NSArray<ConfigSubControllerBlock> *registerSubPages;

/**
 设置默认选中的子页面index，从0开始

 @warning `defaultSelectPageIndex` 的值只在初始化的时候设置一次，避免多次重复设置
 */
@property (nonatomic, assign, readwrite) NSInteger defaultSelectPageIndex;

/** 当前在屏幕上显示的页面 index */
@property (nonatomic, assign, readonly) NSInteger currentPageIndex;

/** 回掉代理对象 */
@property (nonatomic, weak, nullable) id<SegmentSubPageDelegate> delegate;

@end


//___________________________________________________________________________________________________



/**
 申明控件的回掉代理，用于在切换页面时“抛出”回掉事件
 */
@protocol SegmentSubPageDelegate<NSObject>

/**
 代理方法的作用是，回掉控件上的切换页面的事件
 
 @param controller 当前选中显示的controller.
 
 @param index 显示页面对应的index
 
 */
- (void)frontPageController:(UIViewController *)controller itemIndex:(NSInteger)index;

@end


NS_ASSUME_NONNULL_END
