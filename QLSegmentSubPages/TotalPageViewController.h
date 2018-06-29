//
//  TotalPageViewController.h
//  QLSegmentSubPages
//
//  Created by qianlei on 2018/6/28.
//  Copyright © 2018年 qianlei. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PageEffectType) {
    kPageEffectBasicType = 1,   //基础效果
    kPageEffectMiddleTitleType, //title居中效果
    kPageEffectHeaderViewType,  //控件存在headerView的效果
    kPageEffectDynamicHeaderViewType    //滑动时有动态效果的headerView效果
};


@interface TotalPageViewController : UIViewController

/** 区分不同的页面效果 */
@property (nonatomic, assign) PageEffectType effectType;

@end
