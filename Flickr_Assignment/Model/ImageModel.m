//
//  ImageModel.m
//  Flickr_Assignment
//
//  Created by Xin Chen on 2019/6/6.
//  Copyright © 2019 Xin Chen. All rights reserved.
//

#import "ImageModel.h"
#import "AFNetworking.h"
#import "CoreDataEncapsulation/CoreDataPublicFunction.h"


@implementation ImageModel
+ (void)getImageList:(NSString *)url Page:(NSInteger)page Per_Page:(NSInteger)per_page ImageCallBack:(ImageListCallBack)callBack{
   
    NSString * newURL = [url stringByAppendingFormat:@"per_page=%ld&page=%ld",per_page,page];
    
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    [manage GET:newURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *jsonDic = responseObject;
        NSArray *array = jsonDic[@"photos"][@"photo"];
        int count = 0;
        
        if (page == 1) {
            [[CoreDataPublicFunction sharedInstance] deleteAllImagesModel:^{
                NSLog(@"---delete success");
            } fail:^(NSError * _Nonnull error) {
                NSLog(@"---delete error");
            }];
        }
        
        for (NSDictionary *dic in array) {
            NSString *imageURL = @"https://farm66.staticflickr.com/";
            imageURL = [imageURL stringByAppendingFormat:@"%@/%@_%@_b.jpg",dic[@"server"],dic[@"id"],dic[@"secret"]];
            ImageModel * model = [[ImageModel alloc] init];
            
            model.imageURL = imageURL;
            model.imageTitle = dic[@"title"];
            model.owner = dic[@"owner"];
            if (count%2==0) {
                model.imageWidth = 200;
                model.imageHeight = 275;
            }else{
                model.imageWidth = 200;
                model.imageHeight = 300;
            }
            
            [[CoreDataPublicFunction sharedInstance] insertImagesModel:model success:^{
                NSLog(@"insert success");
            } fail:^(NSError * _Nonnull error) {
                NSLog(@"--insert error--%@",error);
            }];
            
            count++;
        }
        [[CoreDataPublicFunction sharedInstance] readAllImagesModel:^(NSArray * _Nonnull resultArray) {
            callBack(resultArray);
        } fail:^(NSError * _Nonnull error) {
            NSLog(@"--search error---%@",error);
        }];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"---%@",error);
        [[CoreDataPublicFunction sharedInstance] readAllImagesModel:^(NSArray * _Nonnull resultArray) {
            callBack(resultArray);
        } fail:^(NSError * _Nonnull error) {
            NSLog(@"--search error---%@",error);
        }];
    }];

}
@end
