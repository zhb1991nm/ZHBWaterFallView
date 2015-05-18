//
//  ZHBRefreshScrollView.h
//  WaterFallView
//
//  Created by 张浩波 on 15/5/16.
//  Copyright (c) 2015年 zhb. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZHBRefreshScrollViewDelegate;

@interface ZHBRefreshScrollView : UIScrollView

@property (nonatomic,weak) id<ZHBRefreshScrollViewDelegate> refreshDelegate;

@property (nonatomic,assign) CGFloat pullDistance;//下拉多少距离刷新

-(void)refreshFinishedAnimated:(BOOL)animated;

-(void)pullToRefresh;

@end

@protocol ZHBRefreshScrollViewDelegate <NSObject>

@required

-(void)ZHBRefreshScrollViewStartRefresh:(ZHBRefreshScrollView *)scrollView;

@end