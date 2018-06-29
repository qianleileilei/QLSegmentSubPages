//
//  QLSegmentTitleView.h
//  QLSegmentSubPages
//
//  Created by qianlei on 2018/6/6.
//  Copyright © 2018年 qianlei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 selected the items callback `protocol`
 */
@protocol SegmentTitleViewDelegate <NSObject>

/**
 throw the event callback for select detail item
 
 @prama hasChange The current selected item is different from last one
 @prama itemIndex current selected item index, the first item index is `0`
 
 */
- (void)didChangeSelectItem:(BOOL)hasChange atIndex:(NSUInteger)itemIndex;

@end

@interface QLSegmentTitleView : UIView

/**
 titles for all items
 
 @warning `titlesArray` must not be `nil`.
 */
@property (nonatomic, copy) NSArray *titlesArray;

/** the index of select index */
@property (nonatomic, assign, readwrite) NSUInteger selectedItemIndex;

/** the selected item title color, default is "red" */
@property (nonatomic, strong, nullable) UIColor *selectItemColor;

/** unselected items title color, default is "black" */
@property (nonatomic, strong, nullable) UIColor *normalItemColor;

/** the item text font */
@property (nonatomic, assign, nullable) UIFont *titleTextFont;

/**
 单个item的宽度；主要用于在item数目较多超过屏幕能显示的返回时，方便用户自己设置宽度；
 
 可以不设置这个值，系统会根据item的信息自动计算一个比价合理的默认值
 */
@property (nonatomic, assign) CGFloat itemWidth;

/** auto Correct the select item position to middle，default is 'YES'  */
@property (nonatomic, assign) BOOL autoCorrectItemPosition;

/** the underline height, default is '2' */
@property (nonatomic, assign) NSUInteger underlineHeight;

/** Whether the underline width is equal to the item text, default is 'YES' */
@property (nonatomic, assign) BOOL underlineWidthEqualText;

/** the delegate for view event */
@property (nonatomic, weak) id<SegmentTitleViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
