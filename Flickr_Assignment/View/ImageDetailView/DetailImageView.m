//
//  DetailImageView.m
//  Flickr_Assignment
//
//  Created by Xin Chen on 6/7/19.
//  Copyright © 2019 Xin Chen. All rights reserved.
//

#import "DetailImageView.h"
#import "ImageDtailCell.h"
#import "DetailImageInfo.h"
#import "ImageModel.h"

static NSString* cellId = @"imageDtailCell";

//cell之间的间隔
static CGFloat lineSpacing = 10.0f;

@interface DetailImageView ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    //第一次加载的位置
    NSInteger _startIndex;
    //当前滚动位置
    NSInteger _currentIndex;
    //开始加载时的图片位置
    CGRect _anchorFrame;
    //图片地址
    NSArray *_imageUrls;
    //是否显示网络图片
    BOOL _showNetImages;
    
    UILabel *_nameLabel;
    UILabel *_titleLabel;
    NSMutableArray<ImageModel *>*_imageModel;
}
//滚动的ScrollView
@property (nonatomic, strong) UICollectionView *collectionView;
//工具栏
@property (nonatomic, strong) DetailImageInfo *imageInfo;
//图片容器
@property (nonatomic, weak) UIView *imageContainer;

@end
@implementation DetailImageView

+ (DetailImageView*)shareInstanse {
    
    static DetailImageView *dIView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dIView = [[DetailImageView alloc] init];
    });
    return dIView;
}
- (instancetype)init {
    
    if (self = [super init]) {
        [self buildUI];
    }
    return self;
}
- (void)buildUI{
    self.frame = [UIScreen mainScreen].bounds;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height);
    layout.minimumLineSpacing = lineSpacing;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, lineSpacing);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    CGRect frame = self.bounds;
    frame.size.width += lineSpacing;
    _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.pagingEnabled = true;
    [_collectionView registerClass:[ImageDtailCell class] forCellWithReuseIdentifier:cellId];
    _collectionView.showsHorizontalScrollIndicator = false;
    [self addSubview:_collectionView];
    
    _startIndex = 0;
    _currentIndex = 0;

    _imageInfo = [[DetailImageInfo alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - infoHeight, self.bounds.size.width, infoHeight)];
   //  NSLog(@"是图片数组吗------%@",[models valueForKey:@"imageURL"]);

    [self addSubview:_imageInfo];

}

#pragma mark -
#pragma mark CollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _imageUrls.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageDtailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    //设置属性
    cell.showNetImage = _showNetImages;
    cell.isStart = indexPath.row == _startIndex;
    cell.collectionView = collectionView;
    cell.anchorFrame = _anchorFrame;
    cell.imageViewContentMode = [self imageViewContentMode];
    cell.imageUrl = _imageUrls[indexPath.row];
    //添加回调
    __weak typeof (self)weekSelf = self;
    [cell addHideBlockStart:^{
        [weekSelf.imageInfo hide];
      
    } finish:^{
        [weekSelf removeFromSuperview];
       
    } cancle:^{
        [weekSelf.imageInfo show];
    }];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    _currentIndex = scrollView.contentOffset.x/scrollView.bounds.size.width;
    _imageInfo.text = [NSString stringWithFormat:@"%zd/%zd",_currentIndex + 1,_imageUrls.count];
     _imageInfo.nameText=[[_imageModel objectAtIndex:_currentIndex] valueForKey:@"owner"];
     _imageInfo.titleText=[[_imageModel objectAtIndex:_currentIndex] valueForKey:@"imageTitle"];

}

#pragma mark -
#pragma mark 功能方法



-(void)showImage:(NSMutableArray <ImageModel *>*)models index:(NSInteger)index container:(UIView*)imageContainer{
    _showNetImages = true;
    //设置图片容器
    _imageContainer = imageContainer;
    //设置数据源、、
    _imageModel=models;
    _imageUrls = [models valueForKey:@"imageURL"] ;
    //设置起始位置
    _startIndex = index;
    //初始化锚点
    _anchorFrame = [_imageContainer convertRect:_imageContainer.bounds toCoordinateSpace:self];
    
    //更新显示
    ImageModel *iModel= [models objectAtIndex:index];
    _imageInfo.text = [NSString stringWithFormat:@"%zd/%zd",_currentIndex + 1,_imageUrls.count];
    _imageInfo.titleText = iModel.imageTitle;
    _imageInfo.nameText = iModel.owner;

    [_imageInfo show];

    //刷新CollectionView
    [_collectionView reloadData];
    //滚动到指定位置
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:false];
    //找到指定Cell执行放大动画
    __weak typeof (self)weekSelf = self;
    [_collectionView performBatchUpdates:nil completion:^(BOOL finished) {
        ImageDtailCell *item = (ImageDtailCell *)[weekSelf.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
        [item showEnlargeAnimation];
        //添加到屏幕上
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }];

}

#pragma mark -
#pragma mark 获取上级ImageView的ContentMode
- (UIViewContentMode)imageViewContentMode {
    UIViewContentMode contentMode = UIViewContentModeScaleToFill;
    if ([_imageContainer isKindOfClass:[UIImageView class]]) {
        contentMode = _imageContainer.contentMode;
    }else{
        for (UIView *subView in _imageContainer.subviews) {
            if ([subView isKindOfClass:[UIImageView class]]) {
                contentMode = subView.contentMode;
            }else{
                for (UIView *subView2 in subView.subviews) {
                    if ([subView2 isKindOfClass:[UIImageView class]]) {
                        contentMode = subView2.contentMode;
                    }
                }
            }
        }
    }
    return contentMode;
}



@end
