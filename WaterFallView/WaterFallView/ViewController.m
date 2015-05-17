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

@interface ViewController ()<ZHBWaterFallViewDatasource,ZHBWaterFallViewDelegate,ZHBRefreshScrollViewDelegate>

@property (nonatomic,strong) NSArray* imageArray;

@property (nonatomic,strong) ZHBWaterFallView *waterFallView;

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
    
    [self.view addSubview:self.waterFallView];
    [_waterFallView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ZHBWaterFallViewDatasource & ZHBWaterFallViewDelegate

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
        cell.layer.shadowColor = [UIColor blackColor].CGColor;
        cell.layer.shadowOpacity = 0.8f;
        cell.layer.shadowOffset = CGSizeMake(0, 2);
    }
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:self.imageArray[arc4random() % 4]] placeholderImage:[UIImage imageNamed:@"act"]];
    cell.descriptionLabel.text = @"Description";
    
    return cell;
}

- (void)waterFallView:(ZHBWaterFallView *)waterFallView didSelectAtIndex:(NSInteger)index{
    NSLog(@"did select at index:%d",index);
}

#pragma mark - ZHBRefreshScrollViewDelegate
-(void)ZHBRefreshScrollViewStartRefresh:(ZHBRefreshScrollView *)scrollView{
    if (scrollView == _waterFallView) {
        [self performSelector:@selector(refreshFinish) withObject:nil afterDelay:5.0f];
    }
}


#pragma mark - event response
-(void)refreshFinish{
    [_waterFallView refreshFinishedAnimated:YES];
}



#pragma mark getter&setter
-(ZHBWaterFallView *)waterFallView{
    if (!_waterFallView) {
        ZHBWaterFallView *waterFallView = [[ZHBWaterFallView alloc] initWithFrame:self.view.bounds];
        waterFallView.waterFallDataSource = self;
        waterFallView.waterFallDelegate = self;
        waterFallView.refreshDelegate = self;
        waterFallView.numberOfcolumn = 2;
        waterFallView.backgroundColor = [UIColor whiteColor];
        _waterFallView = waterFallView;
    }
    return _waterFallView;
}

@end
