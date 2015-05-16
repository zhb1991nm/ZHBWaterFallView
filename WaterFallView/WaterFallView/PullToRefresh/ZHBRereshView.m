//
//  ZHBRereshView.m
//  WaterFallView
//
//  Created by 张浩波 on 15/5/16.
//  Copyright (c) 2015年 zhb. All rights reserved.
//

#import "ZHBRereshView.h"

@interface ZHBRereshView()<UIGestureRecognizerDelegate>

@end

@implementation ZHBRereshView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initGesture];
    }
    return self;
}

-(void)initGesture{
    UIGestureRecognizer *guestRecognizer = [[UIGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
//    guestRecognizer.delegate = self;
    [self addGestureRecognizer:guestRecognizer];
}

-(void)handleGesture:(UIGestureRecognizer *)gestureRecognizer{
    
}

//#pragma mark UIGestureRecognizerDelegate
//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
//    if (_scrollViewToRefresh.contentOffset.y > 0) {
//        return NO;
//    }
//    return YES;
//}


@end
