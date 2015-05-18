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
#import "ZHBRefreshFooterView.h"

#define pagesize 20
#define allPage 5

@class ShowObject;

@interface ViewController ()<ZHBWaterFallViewDatasource,ZHBWaterFallViewDelegate,ZHBRefreshScrollViewDelegate>{
    NSInteger currentPage;
}

@property (nonatomic,strong) NSArray* imageArray;

@property (nonatomic,strong) ZHBWaterFallView *waterFallView;

@property (nonatomic,strong) ZHBRefreshFooterView *footerView;

@property (nonatomic,assign) BOOL loading;

@property (nonatomic,strong) NSMutableArray *arrayForShow;

@end

@implementation ViewController

#pragma mark life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    currentPage = 1;
    self.imageArray = [NSMutableArray arrayWithObjects:
                       @"http://ww1.sinaimg.cn/bmiddle/70e85378jw1dsxriz44iuj.jpg",
                       @"http://ww2.sinaimg.cn/bmiddle/70e85378jw1ds8g2gtot8j.jpg",
                       @"http://ww2.sinaimg.cn/large/5f5d4271gw1dt1i8rf47aj.jpg",
                       @"http://ww4.sinaimg.cn/bmiddle/70e85378jw1dr57belktxj.jpg",
                       @"http://ww3.sinaimg.cn/bmiddle/70e85378jw1drayzoda5dj.jpg",
                       nil];
    _arrayForShow = [NSMutableArray array];
    
    [self.view addSubview:self.waterFallView];
    [_waterFallView reloadData];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [_waterFallView pullToRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ZHBWaterFallViewDatasource & ZHBWaterFallViewDelegate

- (NSInteger)numberOfWaterFallCellsInWaterFallView:(ZHBWaterFallView *)waterFallView{
    return _arrayForShow.count;
}

- (CGFloat)waterFallView:(ZHBWaterFallView *)waterFallView heightOfCellAtIndex:(NSInteger)index{
    ShowObject *object = _arrayForShow[index];
    return object.height;
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
    ShowObject *object = _arrayForShow[index];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:object.url] placeholderImage:[UIImage imageNamed:@"act"]];
    cell.descriptionLabel.text = @"Description";
    
    return cell;
}

- (void)waterFallView:(ZHBWaterFallView *)waterFallView didSelectAtIndex:(NSInteger)index{
    NSLog(@"did select at index:%ld",(long)index);
}

- (void)waterFallViewDidScroll:(ZHBWaterFallView *)waterFallView{
    if (waterFallView.contentOffset.y >= waterFallView.contentSize.height - waterFallView.frame.size.height && !_loading && currentPage < allPage) {
        currentPage ++;
        [self requestData];
        NSLog(@"滚动到底");
    }
}

#pragma mark - ZHBRefreshScrollViewDelegate
-(void)ZHBRefreshScrollViewStartRefresh:(ZHBRefreshScrollView *)scrollView{
    if (scrollView == _waterFallView) {
        currentPage = 1;
        [self requestData];
    }
}

#pragma mark - request
-(void)requestData{
    _loading = YES;
    [self performSelector:@selector(reqestFinished) withObject:nil afterDelay:3.0f];
}

-(void)reqestFinished{
    _loading = NO;
    if (currentPage == 1) {
        [_waterFallView refreshFinishedAnimated:YES];
        [_arrayForShow removeAllObjects];
    }
    [_arrayForShow addObjectsFromArray:[self createDataWith:pagesize]];
    [_waterFallView reloadData];
    if (currentPage < allPage) {
        self.footerView.status = ZHBRefreshStatusLoading;
    }else{
        self.footerView.status = ZHBRefreshStatusNoMore;
    }
    [_waterFallView setFooterView:self.footerView];
}

#pragma mark - private methods
-(NSArray *)createDataWith:(NSInteger)count{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < count; i ++) {
        ShowObject *object = [[ShowObject alloc] init];
        object.url = self.imageArray[arc4random() % 4];
        object.height = ((arc4random() % 3) + 20) * 10;
        [array addObject:object];
    }
    return array;
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

-(ZHBRefreshFooterView *)footerView{
    if (!_footerView) {
        ZHBRefreshFooterView *footerView = [[ZHBRefreshFooterView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44) status:ZHBRefreshStatusLoading];
        footerView.backgroundColor = [UIColor clearColor];
        _footerView = footerView;
    }
    return _footerView;
}

@end


@implementation ShowObject


@end
