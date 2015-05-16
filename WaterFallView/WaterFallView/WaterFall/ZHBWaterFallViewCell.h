//
//  ZHBWaterFallViewCell.h
//  WaterFallView
//
//  Created by 张浩波 on 15/5/16.
//  Copyright (c) 2015年 zhb. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHBWaterFallView;

@interface ZHBWaterFallViewCell : UIView

@property (nonatomic,assign) NSInteger index;

@property (nonatomic,copy) NSString *reuseIdentifier;

@property (nonatomic,weak) UIView *contentView;

@property (nonatomic,weak) ZHBWaterFallView *waterFallView;


-(id)initWithIdentifier:(NSString *)identifier;

@end
