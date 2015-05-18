//
//  ZHBRefreshFooterView.h
//  WaterFallView
//
//  Created by zhb on 15/5/18.
//  Copyright (c) 2015年 zhb. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ZHBRefreshStatusHide,
    ZHBRefreshStatusLoading,
    ZHBRefreshStatusNoMore,
    ZHBRefreshStatusError
} ZHBRefreshStatus;

@interface ZHBRefreshFooterView : UIView

@property (nonatomic,assign)ZHBRefreshStatus status;

-(instancetype)initWithFrame:(CGRect)frame status:(ZHBRefreshStatus)status;

@end
