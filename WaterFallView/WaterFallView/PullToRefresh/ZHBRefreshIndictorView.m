//
//  ZHBRefreshIndictorView.m
//  WaterFallView
//
//  Created by zhb on 15/5/17.
//  Copyright (c) 2015年 zhb. All rights reserved.
//

#import "ZHBRefreshIndictorView.h"

@interface ZHBRefreshIndictorView()

@property (nonatomic,strong) MyMMMaterialDesignSpinner *indictor;

@end

@implementation ZHBRefreshIndictorView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.indictor];
        [self addSubview:self.arrawImageView];
        _arrawImageView.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height *0.5);
        _indictor.center = _arrawImageView.center;
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = frame.size.width * 0.5f;
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0, 0);
        self.layer.shadowOpacity = 0.8f;
        
    }
    return self;
}

-(void)startAnimating{
    _arrawImageView.hidden = YES;
    [_indictor startAnimating];
}

-(void)stopAnimating{
    _arrawImageView.hidden = NO;
    [_indictor stopAnimating];
}

#pragma mark getter & setter
-(MyMMMaterialDesignSpinner *)indictor{
    if (!_indictor) {
        _indictor = [[MyMMMaterialDesignSpinner alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        _indictor.tintColor = [UIColor redColor];
    }
    return _indictor;
}

-(UIImageView *)arrawImageView{
    if (!_arrawImageView) {
        _arrawImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow-01"]];
        _arrawImageView.frame = CGRectMake(0, 0, 25, 25);
    }
    return _arrawImageView;
}

@end

static NSInteger n = 0;

@implementation MyMMMaterialDesignSpinner

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _colorArray = @[[UIColor redColor],[UIColor greenColor],[UIColor blueColor]];
    }
    return self;
}

-(void)startAnimating{
    [super startAnimating];
    [self startChangeTimer];
}

-(void)stopAnimating{
    [super stopAnimating];
    if (_changeTimer) {
        [_changeTimer invalidate];
    }
}

#pragma mark - getter & setter
-(void)startChangeTimer{
    _changeTimer = [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(changeColor) userInfo:nil repeats:YES];
}

-(void)changeColor{
    self.tintColor = _colorArray[++n%3];
}

@end
