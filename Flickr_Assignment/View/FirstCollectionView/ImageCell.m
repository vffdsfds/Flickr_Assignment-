//
//  ImageCell.m
//  Flickr_Assignment
//
//  Created by Xin Chen on 2019/6/6.
//  Copyright © 2019 Xin Chen. All rights reserved.
//

#import "ImageCell.h"
#import <SDWebImage/SDWebImage.h>
@interface ImageCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageIconView;
@property (weak, nonatomic) IBOutlet UILabel *imageTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *imageNameLabel;

@end

@implementation ImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)showImage:(ImageModel *)model AtIndex:(NSInteger)index{
    [self.imageIconView sd_setImageWithURL:[NSURL URLWithString:model.imageURL] placeholderImage:[UIImage imageNamed:@"PlaceHolder.png"]];
    if ([model.imageTitle isEqualToString:@""]) {
        self.imageTitleLabel.hidden = true;
    }else{
        self.imageTitleLabel.hidden = false;
    }
    self.imageTitleLabel.text = model.imageTitle;
    NSString * string = [NSString stringWithFormat:@"    By:%@", model.owner];
    self.imageNameLabel.text = string;

    
}
@end
