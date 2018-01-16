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

@property (nonatomic, strong) RYJBlankView *ryj_blankView;

- (void)ryj_showBlankView;
- (void)ryj_hideBlankView;

@end
