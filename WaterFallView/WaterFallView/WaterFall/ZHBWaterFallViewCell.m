//
//  ZHBWaterFallViewCell.m
//  WaterFallView
//
//  Created by 张浩波 on 15/5/16.
//  Copyright (c) 2015年 zhb. All rights reserved.
//

#import "ZHBWaterFallViewCell.h"
#import "ZHBWaterFallView.h"

@interface ZHBWaterFallViewCell()

@end

@implementation ZHBWaterFallViewCell

-(id)initWithIdentifier:(NSString *)identifier{
    self = [super init];
    if (self) {
        self.reuseIdentifier = identifier;
        UIView *contentView = [[UIView alloc] initWithFrame:self.bounds];
        contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        contentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:contentView];
        _contentView = contentView;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

-(void)tap:(UITapGestureRecognizer *)gesture{
    if (self.waterFallView) {
        if (self.waterFallView.waterFallDelegate && [self.waterFallView.waterFallDelegate respondsToSelector:@selector(waterFallView:didSelectAtIndex:)]) {
            [self.waterFallView.waterFallDelegate waterFallView:self.waterFallView didSelectAtIndex:self.index];
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
