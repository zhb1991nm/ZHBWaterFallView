//
//  ZHBRefreshScrollView.m
//  WaterFallView
//
//  Created by 张浩波 on 15/5/16.
//  Copyright (c) 2015年 zhb. All rights reserved.
//

#import "ZHBRefreshScrollView.h"
#import "ZHBRefreshIndictorView.h"

#define IndictorViewOriginY -50

@interface ZHBRefreshScrollView()<UIGestureRecognizerDelegate>{
    UIPanGestureRecognizer *panGestureRecognizer;
    BOOL shouldReceiveTouch;
}

@property (nonatomic,strong) ZHBRefreshIndictorView *indictorView;

@end
static CGFloat startY = 0;
static CGFloat lastY = 0;
@implementation ZHBRefreshScrollView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.bounces = NO;
        _pullDistance = 40;
        shouldReceiveTouch = YES;
        panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan1:)];
        panGestureRecognizer.delegate = self;
        [self addGestureRecognizer:panGestureRecognizer];
    }
    return self;
}


#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if (gestureRecognizer == panGestureRecognizer) {
        if (self.superview && !self.indictorView.superview) {
            [self.superview addSubview:self.indictorView];
        }
        if (self.contentOffset.y <= 0 && shouldReceiveTouch) {
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
    CGPoint touchPoint = [gestureRecognizer locationInView:self];
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        startY = touchPoint.y;
        lastY = touchPoint.y;
    }else if (gestureRecognizer.state == UIGestureRecognizerStateChanged){
        CGFloat delta = (touchPoint.y - lastY) * 0.5;
        lastY = touchPoint.y;
        _indictorView.frame = CGRectMake(_indictorView.frame.origin.x, _indictorView.frame.origin.y + delta, _indictorView.frame.size.width, _indictorView.frame.size.height);
        _indictorView.arrawImageView.transform = CGAffineTransformMakeRotation((lastY - startY)/_pullDistance * M_PI / 4);
        CGFloat alpha = (lastY - startY + IndictorViewOriginY)/_pullDistance;
        if (alpha > 0) {
            _indictorView.arrawImageView.alpha = alpha;
        }
        NSLog(@"%f",alpha);
    }else if (gestureRecognizer.state == UIGestureRecognizerStateEnded || gestureRecognizer.state ==UIGestureRecognizerStateCancelled){
        if (_indictorView.frame.origin.y > _pullDistance) {
            [UIView animateWithDuration:0.1f animations:^{
                _indictorView.frame = CGRectMake(_indictorView.frame.origin.x, _pullDistance, _indictorView.frame.size.width, _indictorView.frame.size.height);
            } completion:^(BOOL finished) {
                _indictorView.frame = CGRectMake(_indictorView.frame.origin.x, _pullDistance, _indictorView.frame.size.width, _indictorView.frame.size.height);
                shouldReceiveTouch = NO;
                [_indictorView startAnimating];
                if (_refreshDelegate && [_refreshDelegate respondsToSelector:@selector(ZHBRefreshScrollViewStartRefresh:)]) {
                    [_refreshDelegate ZHBRefreshScrollViewStartRefresh:self];
                }
            }];
        }else{
            [self refreshFinishedAnimated:YES];
        }
        
    }
}

#pragma mark public methods
-(void)pullToRefresh{
    if (self.superview && !self.indictorView.superview) {
        [self.superview addSubview:self.indictorView];
    }
    [UIView animateWithDuration:0.3f animations:^{
         _indictorView.frame = CGRectMake(_indictorView.frame.origin.x, _pullDistance, _indictorView.frame.size.width, _indictorView.frame.size.height);
        _indictorView.transform = CGAffineTransformMakeRotation(M_PI);
    } completion:^(BOOL finished) {
        [_indictorView startAnimating];
        if (_refreshDelegate && [_refreshDelegate respondsToSelector:@selector(ZHBRefreshScrollViewStartRefresh:)]) {
            [_refreshDelegate ZHBRefreshScrollViewStartRefresh:self];
        }
    }];
}

-(void)refreshFinishedAnimated:(BOOL)animated{
    if (animated) {
        [UIView animateWithDuration:0.2f animations:^{
            _indictorView.frame = CGRectMake(_indictorView.frame.origin.x, IndictorViewOriginY, _indictorView.frame.size.width, _indictorView.frame.size.height);
        } completion:^(BOOL finished) {
            _indictorView.frame = CGRectMake(_indictorView.frame.origin.x, IndictorViewOriginY, _indictorView.frame.size.width, _indictorView.frame.size.height);
            shouldReceiveTouch = YES;
            [_indictorView stopAnimating];
        }];
    }else{
        _indictorView.frame = CGRectMake(_indictorView.frame.origin.x, IndictorViewOriginY, _indictorView.frame.size.width, _indictorView.frame.size.height);
        shouldReceiveTouch = YES;
        [_indictorView stopAnimating];
    }
}

#pragma mark getter&setter
-(ZHBRefreshIndictorView *)indictorView{
    if (!_indictorView) {
        _indictorView = [[ZHBRefreshIndictorView alloc] initWithFrame:CGRectMake(0, IndictorViewOriginY, 40, 40)];
        _indictorView.center = CGPointMake(self.frame.size.width * 0.5, _indictorView.center.y);
    }
    return _indictorView;
}

@end
