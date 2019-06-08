//
//  CoreDataPublicFunction.h
//  Flickr_Assignment
//
//  Created by Xin Chen on 2019/6/8.
//  Copyright © 2019 Xin Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ImageModel.h"

NS_ASSUME_NONNULL_BEGIN
@class ImageModels;
@interface CoreDataPublicFunction : NSObject
/**
 *  上传数据库模型名称
 */
@property (nonatomic,copy,readonly) NSString *coreDataModelName;
/**
 *  上传数据库实体名称
 */
@property (nonatomic,copy,readonly) NSString *coreDataEntityName;
/**
 *  上传数据库存储路径
 */
@property (nonatomic,copy,readonly) NSString *coreDataSqlPath;

+ (instancetype)sharedInstance;
/**
 *  插入上传记录
 *
 *  @param model   数据模型
 *  @param success 成功回调
 *  @param fail    失败回调
 */
- (void)insertImagesModel:(ImageModel *)model success:(void(^)(void))success fail:(void(^)(NSError *error))fail;

/**
 *  更新上传记录
 *
 *  @param model   数据模型
 *  @param success 成功回调
 *  @param fail    失败回调
 */
- (void)updateImagesModel:(ImageModel *)model AtIndex:(NSInteger)index success:(void(^)(void))success fail:(void(^)(NSError *error))fail;

/**
 *  删除一条上传记录
 *
 *  @param model   数据模型
 *  @param success 成功回调
 *  @param fail    失败回调
 */
- (void)deleteImagesModel:(ImageModel *)model success:(void(^)(void))success fail:(void(^)(NSError *error))fail;

/**
 *  删除所有上传记录
 *
 *  @param success 成功回调
 *  @param fail    失败回调
 */
- (void)deleteAllImagesModel:(void(^)(void))success fail:(void(^)(NSError *error))fail;

/**
 *  查询上传数据库所有数据
 *
 *  @param success 成功回调（finishArray：已完成（DownLoadModel对象数组） unfinishedArray：未完成（DownLoadModel对象数组））
 *  @param fail    失败回调
 */
- (void)readAllImagesModel:(void(^)(NSArray *resultArray))success fail:(void(^)(NSError *error))fail;
@end



NS_ASSUME_NONNULL_END
