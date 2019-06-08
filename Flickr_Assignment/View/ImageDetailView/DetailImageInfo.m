//
//  DetailImageInfo.m
//  Flickr_Assignment
//
//  Created by Xin Chen on 6/8/19.
//  Copyright © 2019 Xin Chen. All rights reserved.
//

#import "DetailImageInfo.h"
#import "Header.h"

@implementation DetailImageInfo{
    
    UILabel *_pageLabel;
    
    UILabel *_nameLabel;
    UILabel *_titleLabel;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}

-(void)buildUI{
    //显示分页的label
    CGFloat viewMargin = 10.0f;

    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(viewMargin, 0, SCREEN_WIDTH-20, 20)];
    _nameLabel.backgroundColor = [UIColor whiteColor];
    _nameLabel.alpha=0.4;
    _nameLabel.layer.masksToBounds = true;
    _nameLabel.textColor = [UIColor blackColor];
    _nameLabel.font = [UIFont systemFontOfSize:14];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_nameLabel];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(viewMargin,20, SCREEN_WIDTH-20, 60)];
    _titleLabel.backgroundColor = [UIColor whiteColor];
    _titleLabel.layer.masksToBounds = true;
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.lineBreakMode = NSLineBreakByWordWrapping|NSLineBreakByTruncatingTail;
    _titleLabel.numberOfLines = 4;
    _titleLabel.font = [UIFont systemFontOfSize:12];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    // _titleLabel.text=[_imageModel valueForKey:@"imageTitle"];
    // NSLog(@"q当前的值是多少-----%@",[_imageModel valueForKey:@"imageTitle"]);
    [self addSubview:_titleLabel];
    
    CGFloat viewWidth = 80.0f;
    CGFloat viewHeignt = 30.0f;
    
    _pageLabel = [[UILabel alloc] initWithFrame:CGRectMake(viewMargin, 80, viewWidth, viewHeignt)];
    _pageLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    _pageLabel.layer.cornerRadius = 5.0f;
    _pageLabel.layer.masksToBounds = true;
    _pageLabel.textColor = [UIColor whiteColor];
    _pageLabel.font = [UIFont systemFontOfSize:16];
    _pageLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_pageLabel];
    self.alpha = 0;
}


-(void)setText:(NSString *)text{
    _pageLabel.text = text;
}
-(void)setNameText:(NSString *)nameText
{
    _nameLabel.text = nameText;
}
-(void)setTitleText:(NSString *)titleText{
    _titleLabel.text = titleText;
}
-(void)show{
    [UIView animateWithDuration:0.35 animations:^{
        self.alpha = 1;
    }];
}

-(void)hide{
    [UIView animateWithDuration:0.35 animations:^{
        self.alpha = 0;
    }];
}

@end
