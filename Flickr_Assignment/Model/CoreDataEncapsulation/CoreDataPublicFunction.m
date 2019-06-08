//
//  CoreDataPublicFunction.m
//  Flickr_Assignment
//
//  Created by Xin Chen on 2019/6/8.
//  Copyright © 2019 Xin Chen. All rights reserved.
//

#import "CoreDataPublicFunction.h"
#import "CoreDataAPI.h"



static NSString * const modelName = @"Flickr_Assignment";
static NSString * const entityName = @"Images";
static NSString * const sqliteName = @"Flickr_Assignment.sqlite";
@interface CoreDataPublicFunction()
@property (nonatomic,strong) CoreDataAPI *coreDataAPI;
@end
@implementation CoreDataPublicFunction
static CoreDataPublicFunction *coreDataFunction = nil;
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        coreDataFunction = [[CoreDataPublicFunction alloc] init];
    });
    
    return coreDataFunction;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (coreDataFunction == nil) {
            coreDataFunction = [super allocWithZone:zone];
        }
    });
    
    return coreDataFunction;
}
- (instancetype)init
{
    if (self = [super init]) {
        [self initUploadCoreData];
    }
    return self;
}

- (void)initUploadCoreData
{
    _coreDataEntityName = entityName;
    _coreDataModelName = modelName;
    NSString *dataPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    _coreDataSqlPath = [dataPath stringByAppendingFormat:@"/%@.sqlite", modelName];
    NSLog(@"----%@",_coreDataSqlPath);
    self.coreDataAPI = [[CoreDataAPI alloc] initWithCoreData:self.coreDataEntityName modelName:self.coreDataModelName sqlPath:self.coreDataSqlPath success:^{
        NSLog(@"initUploadCoreData success");
    } fail:^(NSError *error) {
        NSLog(@"initUploadCoreData fail");
    }];
    
}
#pragma mark - -- 插入上传记录
- (void)insertImagesModel:(ImageModel *)model success:(void(^)(void))success fail:(void(^)(NSError *error))fail
{
    NSString *imageURL = model.imageURL;
    NSString *imageLabelTitle = model.imageTitle;
    NSString *imageOwner = model.owner;
    NSNumber *imageWidth = [NSNumber numberWithFloat:model.imageWidth];
    NSNumber *imageHeight = [NSNumber numberWithFloat: model.imageHeight];
    
    
    NSDictionary *dict =  NSDictionaryOfVariableBindings(imageHeight,imageLabelTitle,imageOwner,imageURL,imageWidth);
    
    [self.coreDataAPI insertNewEntity:dict success:^{
        if (success) {
            success();
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    }];
}

#pragma mark - -- 更新上传记录
- (void)updateImagesModel:(ImageModel *)model AtIndex:(NSInteger)index success:(void(^)(void))success fail:(void(^)(NSError *error))fail
{
    [self.coreDataAPI readEntity:nil ascending:YES filterStr:nil success:^(NSArray *results) {
        
        if (results.count>0) {
            
//            for (NSManagedObject *obj in results) {
            NSManagedObject *obj = results[index];
                [obj setValue:[NSNumber numberWithBool:model.imageWidth] forKey:@"imageWidth"];
                [obj setValue:[NSNumber numberWithBool:model.imageHeight] forKey:@"imageHeight"];
                [obj setValue:model.imageTitle forKey:@"imageLabelTitle"];
                [obj setValue:model.imageURL forKey:@"imageURL"];
                [obj setValue:model.owner forKey:@"imageOwner"];
                [self.coreDataAPI updateEntity:^{
                    if (success) {
                        success();
                    }
                } fail:^(NSError *error) {
                    if (fail) {
                        fail(error);
                    }
                }];
            
        }else{
            [self insertImagesModel:model success:^{
                NSLog(@"insert success");
            } fail:^(NSError * _Nonnull error) {
                NSLog(@"--insert error--%@",error);
            }];
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    }];
}

#pragma mark - -- 删除一条上传记录
- (void)deleteImagesModel:(ImageModel *)model success:(void(^)(void))success fail:(void(^)(NSError *error))fail
{
    [self.coreDataAPI readEntity:nil ascending:YES filterStr:nil success:^(NSArray *results) {
        if (results.count>0) {
            NSManagedObject *obj = [results firstObject];
            [self.coreDataAPI deleteEntity:obj success:^{
                if (success) {
                    success();
                }
            } fail:^(NSError *error) {
                if (fail) {
                    fail(error);
                }
            }];
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    }];
}

#pragma mark - -- 删除所有上传记录
- (void)deleteAllImagesModel:(void(^)(void))success fail:(void(^)(NSError *error))fail
{
    [self.coreDataAPI readEntity:nil ascending:YES filterStr:nil success:^(NSArray *results) {
        for (NSManagedObject *obj in results){
            [self.coreDataAPI deleteEntity:obj success:^{
                if (success) {
                    success();
                }
            } fail:^(NSError *error) {
                if (fail) {
                    fail(error);
                }
            }];
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    }];
}

#pragma mark - -- 查询所有上传记录
- (void)readAllImagesModel:(void(^)(NSArray *resultArray))success fail:(void(^)(NSError *error))fail
{
    [self.coreDataAPI readEntity:nil ascending:YES filterStr:nil success:^(NSArray *results) {
        NSMutableArray *resultArray = [NSMutableArray array];
        for (NSManagedObject *obj in results) {
            ImageModel *model = [[ImageModel alloc] init];
            // 获取数据库中各个键值的值
            model.imageURL = [obj valueForKey:@"imageURL"];
            model.imageTitle = [obj valueForKey:@"imageLabelTitle"];
            model.owner = [obj valueForKey:@"imageOwner"];
            model.imageHeight = [[obj valueForKey:@"imageHeight"] floatValue];
            model.imageWidth = [[obj valueForKey:@"imageWidth"] floatValue];
            [resultArray addObject:model];
        }
        if (success) {
            success(resultArray);
        }
    } fail:^(NSError *error) {
        if (fail) {
            fail(error);
        }
    }];
}
@end
