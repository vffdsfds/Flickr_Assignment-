//
//  XCWaterFlowLayout.h
//  Flickr_Assignment
//
//  Created by Xin Chen on 2019/6/6.
//  Copyright © 2019 Xin Chen. All rights reserved.
//

#import <UIKit/UIKit.h>



@class XCWaterFlowLayout;

@protocol  XCWaterFallLayoutDeleaget<NSObject>

@required
/**
 * 每个item的高度
 */
- (CGFloat)waterFallLayout:(XCWaterFlowLayout *)waterFallLayout heightForItemAtIndexPath:(NSUInteger)indexPath itemWidth:(CGFloat)itemWidth;

@optional
/**
 * 有多少列
 */
- (NSUInteger)columnCountInWaterFallLayout:(XCWaterFlowLayout *)waterFallLayout;

/**
 * 每列之间的间距
 */
- (CGFloat)columnMarginInWaterFallLayout:(XCWaterFlowLayout *)waterFallLayout;

/**
 * 每行之间的间距
 */
- (CGFloat)rowMarginInWaterFallLayout:(XCWaterFlowLayout *)waterFallLayout;

/**
 * 每个item的内边距
 */
- (UIEdgeInsets)edgeInsetdInWaterFallLayout:(XCWaterFlowLayout *)waterFallLayout;


@end

@interface XCWaterFlowLayout : UICollectionViewLayout
/** 代理 */
@property (nonatomic, weak) id<XCWaterFallLayoutDeleaget> delegate;

@end
