//
//  UIView+RYJBlank.m
//  RYJBlankViewDome
//
//  Created by devRen on 2018/1/15.
//  Copyright © 2018年 renyijie. All rights reserved.
//

#import "UIView+RYJBlank.h"
#import <objc/runtime.h>
#import "RYJBlankView.h"

@implementation UIView (RYJBlank)

static char kBlankViewKey;
- (void)setRyj_blankView:(RYJBlankView *)ryj_blankView {
    if (ryj_blankView != self.ryj_blankView) {
        
        objc_setAssociatedObject(self, &kBlankViewKey, ryj_blankView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        for (UIView *view in self.subviews) {
            if ([view isKindOfClass:[RYJBlankView class]]) {
                [view removeFromSuperview];
            }
        }
        [self addSubview:self.ryj_blankView];
    }
}

- (RYJBlankView *)ryj_blankView {
    return  objc_getAssociatedObject(self, &kBlankViewKey);
}

#pragma mark - Public Method
- (void)ryj_showBlankView {
    
    [self.ryj_blankView.superview layoutSubviews];
    
    self.ryj_blankView.hidden = NO;
    // 让 blankBGView 始终保持在最上层
    [self bringSubviewToFront:self.ryj_blankView];
}

- (void)ryj_hideBlankView {
    self.ryj_blankView.hidden = YES;
}

@end
