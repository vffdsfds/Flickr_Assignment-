//
//  ImageDtailCell.h
//  Flickr_Assignment
//
//  Created by Xin Chen on 6/8/19.
//  Copyright © 2019 Xin Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^VoidBlock)(void);

@interface ImageDtailCell : UICollectionViewCell

@property (nonatomic ,assign) BOOL showNetImage;

//起始位置
@property (nonatomic, assign) CGRect anchorFrame;
//是否是起始Cell
@property (nonatomic, assign) BOOL isStart;
//图片地址
@property (nonatomic, copy) NSString *imageUrl;
//imageView的ContentMode，与Superview相同
@property (nonatomic, assign) UIViewContentMode imageViewContentMode;

//保存CollectionView
@property (nonatomic, weak) UICollectionView *collectionView;

//返回回调
-(void)addHideBlockStart:(VoidBlock)start finish:(VoidBlock)finish cancle:(VoidBlock)cancle;
//显示放大动画
-(void)showEnlargeAnimation;


@end
