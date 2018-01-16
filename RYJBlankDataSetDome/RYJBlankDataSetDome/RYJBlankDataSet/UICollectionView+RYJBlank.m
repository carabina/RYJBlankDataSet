//
//  UICollectionView+RYJBlank.m
//  RYJBlankViewDome
//
//  Created by devRen on 2018/1/15.
//  Copyright © 2018年 renyijie. All rights reserved.
//

#import "UICollectionView+RYJBlank.h"
#import <objc/runtime.h>
#import "UIView+RYJBlank.h"

@implementation UICollectionView (RYJBlank)

+ (void)load{
    
    Method reloadData = class_getInstanceMethod(self, @selector(reloadData));
    Method ryj_reloadData = class_getInstanceMethod(self, @selector(ryj_reloadData));
    method_exchangeImplementations(reloadData, ryj_reloadData);
    
    // section
    Method insertSections = class_getInstanceMethod(self, @selector(insertSections:));
    Method ryj_insertSections = class_getInstanceMethod(self, @selector(ryj_insertSections:));
    method_exchangeImplementations(insertSections, ryj_insertSections);
    
    Method deleteSections = class_getInstanceMethod(self, @selector(deleteSections:));
    Method ryj_deleteSections = class_getInstanceMethod(self, @selector(ryj_deleteSections:));
    method_exchangeImplementations(deleteSections, ryj_deleteSections);
    
    // item
    Method insertItemsAtIndexPaths = class_getInstanceMethod(self, @selector(insertItemsAtIndexPaths:));
    Method ryj_insertItemsAtIndexPaths = class_getInstanceMethod(self, @selector(ryj_insertItemsAtIndexPaths:));
    method_exchangeImplementations(insertItemsAtIndexPaths, ryj_insertItemsAtIndexPaths);
    
    Method deleteItemsAtIndexPaths = class_getInstanceMethod(self, @selector(deleteItemsAtIndexPaths:));
    Method ryj_deleteItemsAtIndexPaths = class_getInstanceMethod(self, @selector(ryj_deleteItemsAtIndexPaths:));
    method_exchangeImplementations(deleteItemsAtIndexPaths, ryj_deleteItemsAtIndexPaths);
    
}

- (void)ryj_reloadData {
    [self ryj_reloadData];
    [self getDataAndSet];
}

// section
- (void)ryj_insertSections:(NSIndexSet *)sections {
    [self ryj_insertSections:sections];
    [self getDataAndSet];
}
- (void)ryj_deleteSections:(NSIndexSet *)sections {
    [self ryj_deleteSections:sections];
    [self getDataAndSet];
}

// item
- (void)ryj_insertItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    [self ryj_insertItemsAtIndexPaths:indexPaths];
    [self getDataAndSet];
}
- (void)ryj_deleteItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    [self ryj_deleteItemsAtIndexPaths:indexPaths];
    [self getDataAndSet];
}

#pragma mark - Private Method
- (NSInteger)totalDataCount {
    NSInteger totalCount = 0;
    if ([self isKindOfClass:[UICollectionView class]]) {
        UICollectionView *collectionView = (UICollectionView *)self;
        for (NSInteger section = 0; section < collectionView.numberOfSections; section++) {
            totalCount += [collectionView numberOfItemsInSection:section];
        }
    }
    return totalCount;
}

- (void)getDataAndSet{
    
    if ([self totalDataCount] == 0) {
        [self ryj_showBlankView];
    }else{
        [self ryj_hideBlankView];
    }
}
@end
