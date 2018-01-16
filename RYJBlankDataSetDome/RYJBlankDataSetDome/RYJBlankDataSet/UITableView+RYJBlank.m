//
//  UITableView+RYJBlank.m
//  RYJBlankViewDome
//
//  Created by devRen on 2018/1/15.
//  Copyright © 2018年 renyijie. All rights reserved.
//

#import "UITableView+RYJBlank.h"
#import <objc/runtime.h>
#import "UIView+RYJBlank.h"
#import "RYJBlankView.h"

#define kScreen_Height   ([UIScreen mainScreen].bounds.size.height)
#define kScreen_Width    ([UIScreen mainScreen].bounds.size.width)

@implementation UITableView (RYJBlank)

+ (void)load {
    Method initWithFrame = class_getInstanceMethod(self, @selector(initWithFrame:style:));
    Method ryj_initWithFrame = class_getInstanceMethod(self, @selector(ryj_initWithFrame:style:));
    method_exchangeImplementations(initWithFrame, ryj_initWithFrame);
    
    Method reloadData = class_getInstanceMethod(self, @selector(reloadData));
    Method ryj_reloadData = class_getInstanceMethod(self, @selector(ryj_reloadData));
    method_exchangeImplementations(reloadData, ryj_reloadData);
    
    // section
    Method insertSections = class_getInstanceMethod(self, @selector(insertSections:withRowAnimation:));
    Method ryj_insertSections = class_getInstanceMethod(self, @selector(ryj_insertSections:withRowAnimation:));
    method_exchangeImplementations(insertSections, ryj_insertSections);
    
    Method deleteSections = class_getInstanceMethod(self, @selector(deleteSections:withRowAnimation:));
    Method ryj_deleteSections = class_getInstanceMethod(self, @selector(ryj_deleteSections:withRowAnimation:));
    method_exchangeImplementations(deleteSections, ryj_deleteSections);
    
    // row
    Method insertRowsAtIndexPaths = class_getInstanceMethod(self, @selector(insertRowsAtIndexPaths:withRowAnimation:));
    Method ryj_insertRowsAtIndexPaths = class_getInstanceMethod(self, @selector(ryj_insertRowsAtIndexPaths:withRowAnimation:));
    method_exchangeImplementations(insertRowsAtIndexPaths, ryj_insertRowsAtIndexPaths);
    
    Method deleteRowsAtIndexPaths = class_getInstanceMethod(self, @selector(deleteRowsAtIndexPaths:withRowAnimation:));
    Method ryj_deleteRowsAtIndexPaths = class_getInstanceMethod(self, @selector(ryj_deleteRowsAtIndexPaths:withRowAnimation:));
    method_exchangeImplementations(deleteRowsAtIndexPaths, ryj_deleteRowsAtIndexPaths);    
}

- (instancetype)ryj_initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    [self ryj_initWithFrame:frame style:style];
    self.ryj_autoShowBlankView = YES;
    self.ryj_autoAddBlankView = NO;
    return self;
}

#pragma mark - GET & SET
static bool KAutoShowBlankViewKey;
- (void)setRyj_autoShowBlankView:(BOOL)ryj_autoShowBlankView {
    objc_setAssociatedObject(self, &KAutoShowBlankViewKey, @(ryj_autoShowBlankView), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)ryj_autoShowBlankView {
    return [(NSNumber*)objc_getAssociatedObject(self, &KAutoShowBlankViewKey) boolValue];
}

static bool KAutoAddBlankViewKey;
- (void)setRyj_autoAddBlankView:(BOOL)ryj_autoAddBlankView {
    objc_setAssociatedObject(self, &KAutoAddBlankViewKey, @(ryj_autoAddBlankView), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)ryj_autoAddBlankView {
    return [(NSNumber*)objc_getAssociatedObject(self, &KAutoAddBlankViewKey) boolValue];
}

- (void)ryj_reloadData {
    [self ryj_reloadData];
    
    if (self.ryj_autoAddBlankView && !self.ryj_blankView) {
        self.ryj_blankView = [[RYJBlankView alloc] initWithFrame:CGRectMake(kScreen_Width/2-50, kScreen_Height/2-50, 100, 100)];
    }
    
    [self getDataAndSet];
}

// section
- (void)ryj_insertSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    [self ryj_insertSections:sections withRowAnimation:animation];
    [self getDataAndSet];
}
- (void)ryj_deleteSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    [self ryj_insertSections:sections withRowAnimation:animation];
    [self getDataAndSet];
}

// row
- (void)ryj_insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    [self ryj_insertRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self getDataAndSet];
}
- (void)ryj_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    [self ryj_deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
    [self getDataAndSet];
}

#pragma mark - Private Method
- (NSInteger)totalDataCount {
    NSInteger totalCount = 0;
    if ([self isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self;
        for (NSInteger section = 0; section < tableView.numberOfSections; section++) {
            totalCount += [tableView numberOfRowsInSection:section];
        }
    }
    return totalCount;
}

- (void)getDataAndSet{
    if ([self totalDataCount] == 0) {
        [self ryj_autoShow];
    }else{
        [self ryj_autoHide];
    }
}

- (void)ryj_autoShow{
    if (!self.ryj_autoShowBlankView) {
        self.ryj_blankView.hidden = YES;
        return;
    }
    [self ryj_showBlankView];
}

- (void)ryj_autoHide{
    if (!self.ryj_autoShowBlankView) {
        self.ryj_blankView.hidden = YES;
        return;
    }
    [self ryj_hideBlankView];
}

@end
