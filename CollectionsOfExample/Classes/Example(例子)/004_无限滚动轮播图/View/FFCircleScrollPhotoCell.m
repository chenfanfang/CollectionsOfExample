//
//  FFCircleScrollPhotoCell.m
//  CollectionsOfExample
//
//  Created by mac on 16/7/31.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "FFCircleScrollPhotoCell.h"

@interface FFCircleScrollPhotoCell ()

/** 广告图片的 imageView */
@property (weak, nonatomic) IBOutlet UIImageView *adPictureView;

@end

@implementation FFCircleScrollPhotoCell

- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    self.adPictureView.image = [UIImage imageNamed:imageName];
}

@end
