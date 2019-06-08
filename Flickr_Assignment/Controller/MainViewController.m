//
//  ViewController.m
//  Flickr_Assignment
//
//  Created by Xin Chen on 6/6/19.
//  Copyright © 2019 Xin Chen. All rights reserved.
//

#import "MainViewController.h"
#import "XCWaterFlowLayout.h"
#import "ImageModel.h"
#import "ImageCell.h"
#import <MJRefresh.h>
#import "DetailImageView.h"
#import "Header.h"

static NSString * const cellId = @"imageCell";
NSString * const  _Nonnull flickrURL = @"https://www.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=9dc46dc917884944fbd2ab47f296971c&format=json&nojsoncallback=1&";
@interface MainViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,XCWaterFallLayoutDeleaget>
@property (nonatomic, strong) NSMutableArray  * imageModels;
@property(assign , nonatomic)NSInteger defaultPage;
@property(assign , nonatomic)NSInteger defaultPer_Page;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


/** 列数 */
@property (nonatomic, assign) NSUInteger columnCount;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupLayoutAndCollectionView];
      [self setupRefresh];
    // Do any additional setup after loading the view, typically from a nib.
}

/**
 * 创建布局和collectionView
 */
- (void)setupLayoutAndCollectionView{
    
    // 创建布局
    XCWaterFlowLayout * waterFallLayout = [[XCWaterFlowLayout alloc]init];
    waterFallLayout.delegate = self;
    self.collectionView.collectionViewLayout = waterFallLayout;
    
    
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ImageCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    
    [cell showImage:self.imageModels[indexPath.row] AtIndex: indexPath.row];
   
   
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    self.collectionView.mj_footer.hidden = self.imageModels.count == 0;
    return self.imageModels.count;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [[DetailImageView shareInstanse] showImage:self.imageModels index:indexPath.row container:[self.collectionView cellForItemAtIndexPath:indexPath]];
   
}


/**
 * 刷新控件
 */
- (void)setupRefresh{
    
    // 设置回调
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewImages)];
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    
    // 隐藏状态
//    header.stateLabel.hidden = YES;
    self.collectionView.mj_header = header;
    [self.collectionView.mj_header beginRefreshing];

    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreImages)];
    self.collectionView.mj_footer.backgroundColor = [UIColor whiteColor];
    self.collectionView.mj_footer.hidden = YES;
   
 
}

/**
 * 加载新的商品
 */
- (void)loadNewImages{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        self.defaultPage = 1;
        // 刷新表格
        [ImageModel getImageList:flickrURL Page:self.defaultPage Per_Page:20 ImageCallBack:^(NSArray * _Nonnull imageModelArray) {
            [self.imageModels removeAllObjects];
            [self.imageModels addObjectsFromArray:imageModelArray];
            [self.collectionView reloadData];
            [self.collectionView.mj_header endRefreshing];
        }];
    });
}

/**
 * 加载更多商品
 */
- (void)loadMoreImages{
    self.defaultPage += 1;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [ImageModel getImageList:flickrURL Page:self.defaultPage Per_Page:20 ImageCallBack:^(NSArray * _Nonnull imageModelArray) {
            [self.imageModels removeAllObjects];
            [self.imageModels addObjectsFromArray:imageModelArray];
            [self.collectionView reloadData];
            if (imageModelArray.count<self.defaultPage) {
                [self.collectionView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.collectionView.mj_footer endRefreshing];
            }
        }];
    });
    
}


#pragma mark  - <XCWaterFlowLayout>
- (CGFloat)waterFallLayout:(XCWaterFlowLayout *)waterFallLayout heightForItemAtIndexPath:(NSUInteger)indexPath itemWidth:(CGFloat)itemWidth{
    
    ImageModel * model = self.imageModels[indexPath];
    
    return itemWidth * model.imageHeight / model.imageWidth;
}

- (CGFloat)rowMarginInWaterFallLayout:(XCWaterFlowLayout *)waterFallLayout{
    
    return 20;
    
}

- (NSUInteger)columnCountInWaterFallLayout:(XCWaterFlowLayout *)waterFallLayout{
    
    return 2;
    
}

- (NSMutableArray *)imageModels{
    if (!_imageModels) {
        _imageModels = [NSMutableArray array];
    }
    return _imageModels;
}



@end
