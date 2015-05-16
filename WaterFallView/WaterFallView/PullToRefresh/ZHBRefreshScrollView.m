//
//  ZHBRefreshScrollView.m
//  WaterFallView
//
//  Created by 张浩波 on 15/5/16.
//  Copyright (c) 2015年 zhb. All rights reserved.
//

#import "ZHBRefreshScrollView.h"

@interface ZHBRefreshScrollView()<UIGestureRecognizerDelegate>{
    UIPanGestureRecognizer *panGestureRecognizer;
}

@end

@implementation ZHBRefreshScrollView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.bounces = NO;
        panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan1:)];
        panGestureRecognizer.delegate = self;
        [self addGestureRecognizer:panGestureRecognizer];
    }
    return self;
}


#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if (gestureRecognizer == panGestureRecognizer) {
        if (self.contentOffset.y <= 0) {
            return YES;
        }
        return NO;
    }
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    if (gestureRecognizer == panGestureRecognizer){
        if (self.contentOffset.y <= 0) {
            return YES;
        }
    }
    return NO;
}

-(void)handlePan1:(UIGestureRecognizer *)gestureRecognizer{
    NSLog(@"handle pan");
}

@end
