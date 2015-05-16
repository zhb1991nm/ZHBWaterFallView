//
//  ZHBWaterFallView.h
//  WaterFallView
//
//  Created by 张浩波 on 15/5/16.
//  Copyright (c) 2015年 zhb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHBWaterFallViewCell.h"

@protocol ZHBWaterFallViewDatasource,ZHBWaterFallViewDelegate;

@interface ZHBWaterFallView : UIScrollView<UIScrollViewDelegate>

- (instancetype)initWithFrame:(CGRect)frame;

@property (nonatomic,assign) UIEdgeInsets marginInsets;

@property (nonatomic,assign) CGFloat horizonPadding;//左右相邻元素间距

@property (nonatomic,assign) CGFloat veticalPadding;//上下相邻元素间距

@property (nonatomic,assign) NSInteger numberOfcolumn;//default 2

@property (nonatomic,weak) id <ZHBWaterFallViewDatasource> waterFallDataSource;

@property (nonatomic,weak) id <ZHBWaterFallViewDelegate> waterFallDelegate;

- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier;

- (void)reloadData;

@end

@protocol ZHBWaterFallViewDatasource <NSObject>

@required
//元素个数
- (NSInteger)numberOfWaterFallCellsInWaterFallView:(ZHBWaterFallView *)waterFallView;

- (ZHBWaterFallViewCell *)waterFallView:(ZHBWaterFallView *)waterFallView cellAtIndex:(NSInteger)index;

@optional

- (CGFloat)waterFallView:(ZHBWaterFallView *)waterFallView heightOfCellAtIndex:(NSInteger)index;

@end

@protocol ZHBWaterFallViewDelegate <NSObject>

@optional

- (void)waterFallView:(ZHBWaterFallView *)waterFallView didSelectAtIndex:(NSInteger)index;

@end

