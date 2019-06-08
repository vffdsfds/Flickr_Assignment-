//
//  ImageModel.h
//  Flickr_Assignment
//
//  Created by Xin Chen on 2019/6/6.
//  Copyright © 2019 Xin Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ImageListCallBack)(NSArray * imageModelArray);

@interface ImageModel : NSObject
@property(assign , nonatomic)CGFloat imageWidth;
@property(assign , nonatomic)CGFloat imageHeight;
@property(strong , nonatomic)NSString *imageURL;
@property(strong , nonatomic)NSString *imageTitle;
@property(strong , nonatomic)NSString *owner;

+ (void)getImageList:(NSString *)url Page:(NSInteger)page Per_Page:(NSInteger)per_page ImageCallBack:(ImageListCallBack)callBack;
@end

NS_ASSUME_NONNULL_END
