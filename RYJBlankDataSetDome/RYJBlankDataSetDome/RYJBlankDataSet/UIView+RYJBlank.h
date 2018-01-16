//
//  UIView+RYJBlank.h
//  RYJBlankViewDome
//
//  Created by devRen on 2018/1/15.
//  Copyright © 2018年 renyijie. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RYJBlankView;

@interface UIView (RYJBlank)

/** 用来显示的空白页 */
@property (nonatomic, strong) RYJBlankView *ryj_blankView;

/** 手动显示 */
- (void)ryj_showBlankView;
/** 手动隐藏 */
- (void)ryj_hideBlankView;

@end
