//
//  WaterFallCell.m
//  WaterFallView
//
//  Created by 张浩波 on 15/5/16.
//  Copyright (c) 2015年 zhb. All rights reserved.
//

#import "WaterFallCell.h"

@implementation WaterFallCell

-(instancetype)initWithIdentifier:(NSString *)identifier{
    self = [super initWithIdentifier:identifier];
    if (self) {
        [self initSubViews];
    }
    return self;
}

-(void)initSubViews{
    _imageView = [[UIImageView alloc] init];
    [self.contentView addSubview:_imageView];
    _descriptionLabel = [[UILabel alloc] init];
    _descriptionLabel.backgroundColor = [UIColor whiteColor];
    _descriptionLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.contentView addSubview:_descriptionLabel];
    [self.contentView bringSubviewToFront:_descriptionLabel];
}

-(void)layoutSubviews{
    _imageView.frame = self.contentView.bounds;
    
    _descriptionLabel.frame = CGRectMake(0, self.frame.size.height - 25, self.frame.size.width, 25);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
