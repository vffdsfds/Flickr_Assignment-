//
//  DetailImageInfo.h
//  Flickr_Assignment
//
//  Created by Xin Chen on 6/8/19.
//  Copyright © 2019 Xin Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
static CGFloat infoHeight = 115.0f;

@interface DetailImageInfo : UIView
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *titleText;
@property (nonatomic, copy) NSString *nameText;

-(void)show;

-(void)hide;
@end

NS_ASSUME_NONNULL_END
