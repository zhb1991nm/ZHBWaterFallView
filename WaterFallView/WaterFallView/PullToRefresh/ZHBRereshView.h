//
//  ZHBRereshView.h
//  WaterFallView
//
//  Created by 张浩波 on 15/5/16.
//  Copyright (c) 2015年 zhb. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    ZHBRefreshPulling = 0,
    ZHBRefreshNormal,
    ZHBRefreshLoading,
} ZHBRereshState;

@interface ZHBRereshView : UIView

@property (nonatomic,assign) ZHBRereshState currentStaus;

@property (nonatomic,weak) UIScrollView *scrollViewToRefresh;

@end
