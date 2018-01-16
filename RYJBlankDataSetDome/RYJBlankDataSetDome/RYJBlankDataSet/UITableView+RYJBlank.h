//
//  UITableView+RYJBlank.h
//  RYJBlankViewDome
//
//  Created by devRen on 2018/1/15.
//  Copyright © 2018年 renyijie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (RYJBlank)

/** 是否自动显示空白页 */
@property (nonatomic, assign) BOOL ryj_autoShowBlankView;
/** 是否自动添加默认空白页 */
@property (nonatomic, assign) BOOL ryj_autoAddBlankView;

@end
