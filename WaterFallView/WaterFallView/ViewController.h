//
//  ViewController.h
//  WaterFallView
//
//  Created by 张浩波 on 15/5/16.
//  Copyright (c) 2015年 zhb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@end

@interface ShowObject : NSObject

@property (nonatomic,copy) NSString *url;

@property (nonatomic,assign) CGFloat height;

@end