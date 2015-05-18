//
//  ZHBRefreshFooterView.m
//  WaterFallView
//
//  Created by zhb on 15/5/18.
//  Copyright (c) 2015年 zhb. All rights reserved.
//

#import "ZHBRefreshFooterView.h"

@interface ZHBRefreshFooterView()

@property (nonatomic,strong) UIActivityIndicatorView *indicatorView;

@property (nonatomic,strong) UILabel *label;

@end

@implementation ZHBRefreshFooterView

-(instancetype)initWithFrame:(CGRect)frame status:(ZHBRefreshStatus)status{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
        self.status = status;
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubViews];
        self.status = ZHBRefreshStatusLoading;
    }
    return self;
}

#pragma mark private methods
-(void)initSubViews{
    [self addSubview:self.indicatorView];
    [self addSubview:self.label];
}

#pragma mark getter & setter
-(void)setStatus:(ZHBRefreshStatus)status{
    [_indicatorView stopAnimating];
    _label.hidden = NO;
    switch (status) {
        case ZHBRefreshStatusError:
            _label.text = @"加载失败";
            [_indicatorView stopAnimating];
            break;
        case ZHBRefreshStatusHide:
            _label.hidden = YES;
            [_indicatorView stopAnimating];
            break;
        case ZHBRefreshStatusLoading:
            _label.text = @"加载中";
            [_indicatorView startAnimating];
            break;
        case ZHBRefreshStatusNoMore:
            _label.text = @"已加载到底";
            [_indicatorView stopAnimating];
            break;
        default:
            break;
    }
}

-(UIActivityIndicatorView *)indicatorView{
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _indicatorView.hidesWhenStopped = YES;
        _indicatorView.center = CGPointMake(self.frame.size.width / 5, self.frame.size.height / 2);
    }
    return _indicatorView;
}

-(UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
        _label.backgroundColor = [UIColor clearColor];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont systemFontOfSize:14];
        _label.textColor = [UIColor grayColor];
        _label.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    }
    return _label;
}
@end
