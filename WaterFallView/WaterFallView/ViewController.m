//
//  ViewController.m
//  WaterFallView
//
//  Created by 张浩波 on 15/5/16.
//  Copyright (c) 2015年 zhb. All rights reserved.
//

#import "ViewController.h"
#import "ZHBWaterFallView.h"
#import "WaterFallCell.h"
#import "UIImageView+WebCache.h"
#import "ZHBRereshView.h";

@interface ViewController ()<ZHBWaterFallViewDatasource,ZHBWaterFallViewDelegate>

@property (nonatomic,strong) NSArray* imageArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageArray = [NSMutableArray arrayWithObjects:
                       @"http://ww1.sinaimg.cn/bmiddle/70e85378jw1dsxriz44iuj.jpg",
                       @"http://ww2.sinaimg.cn/bmiddle/70e85378jw1ds8g2gtot8j.jpg",
                       @"http://ww2.sinaimg.cn/large/5f5d4271gw1dt1i8rf47aj.jpg",
                       @"http://ww4.sinaimg.cn/bmiddle/70e85378jw1dr57belktxj.jpg",
                       @"http://ww3.sinaimg.cn/bmiddle/70e85378jw1drayzoda5dj.jpg",
                       nil];
    // Do any additional setup after loading the view, typically from a nib.
    ZHBRereshView *refreshView = [[ZHBRereshView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:refreshView];
    
    ZHBWaterFallView *waterFallView = [[ZHBWaterFallView alloc] initWithFrame:self.view.bounds];
    waterFallView.waterFallDataSource = self;
    waterFallView.waterFallDelegate = self;
    waterFallView.numberOfcolumn = 2;
    waterFallView.backgroundColor = [[UIColor alloc] initWithWhite:0.9f alpha:1.0f];
    [self.view addSubview:waterFallView];
    refreshView.scrollViewToRefresh = waterFallView;
    [waterFallView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfWaterFallCellsInWaterFallView:(ZHBWaterFallView *)waterFallView{
    return 500;
}

- (CGFloat)waterFallView:(ZHBWaterFallView *)waterFallView heightOfCellAtIndex:(NSInteger)index{
    return ((arc4random() % 3) + 20) * 10;
}

- (ZHBWaterFallViewCell *)waterFallView:(ZHBWaterFallView *)waterFallView cellAtIndex:(NSInteger)index{
    static NSString *cellIdentifier = @"cell";
    WaterFallCell *cell = [waterFallView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[WaterFallCell alloc] initWithIdentifier:cellIdentifier];
    }
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:self.imageArray[arc4random() % 4]] placeholderImage:[UIImage imageNamed:@"act"]];
    cell.descriptionLabel.text = @"Description";
    cell.layer.shadowColor = [UIColor grayColor].CGColor;
    cell.layer.shadowOffset = CGSizeMake(4, 4);
    
    return cell;
}

- (void)waterFallView:(ZHBWaterFallView *)waterFallView didSelectAtIndex:(NSInteger)index{
    NSLog(@"did select at index:%d",index);
}

@end
