//
//  ZHBRefreshIndictorView.h
//  WaterFallView
//
//  Created by zhb on 15/5/17.
//  Copyright (c) 2015年 zhb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMMaterialDesignSpinner.h"

@interface ZHBRefreshIndictorView : UIView

@property (nonatomic,strong) UIImageView *arrawImageView;

-(void)startAnimating;

-(void)stopAnimating;

@end

@interface MyMMMaterialDesignSpinner : MMMaterialDesignSpinner

@property (nonatomic,strong) NSTimer *changeTimer;

@property (nonatomic,strong) NSArray *colorArray;

@end