//
//  DetailImageView.h
//  Flickr_Assignment
//
//  Created by Xin Chen on 6/7/19.
//  Copyright © 2019 Xin Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailImageView : UIView

+(DetailImageView*)shareInstanse;


-(void)showImage:(NSArray <ImageModel *>*)models index:(NSInteger)index container:(UIView*)imageContainer;

@end

NS_ASSUME_NONNULL_END
