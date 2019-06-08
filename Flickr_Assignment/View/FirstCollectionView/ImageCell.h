//
//  ImageCell.h
//  Flickr_Assignment
//
//  Created by Xin Chen on 2019/6/6.
//  Copyright © 2019 Xin Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ImageCell : UICollectionViewCell
-(void)showImage:(ImageModel *)model AtIndex:(NSInteger)index;
@end

NS_ASSUME_NONNULL_END
