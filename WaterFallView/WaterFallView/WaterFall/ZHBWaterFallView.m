//
//  ZHBWaterFallView.m
//  WaterFallView
//
//  Created by 张浩波 on 15/5/16.
//  Copyright (c) 2015年 zhb. All rights reserved.
//

#import "ZHBWaterFallView.h"

@interface ZHBWaterFallView(){
    NSMutableDictionary *reuseDict;
    NSMutableArray *cellRectArray;
    NSMutableArray *visibleCells;
    CGFloat columnWidth;
}

@end

@implementation ZHBWaterFallView

#pragma mark - life cycle

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.horizonPadding = 10.0f;
        self.veticalPadding = 10.0f;
        self.marginInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        self.numberOfcolumn = 2;
    }
    return self;
}

#pragma mark - interface

- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier{
    if (!identifier || [@"" isEqualToString:identifier]) {
        return nil;
    }
    NSMutableArray *reuseQueue = [reuseDict objectForKey:identifier];
    if (reuseQueue && [reuseQueue isKindOfClass:[NSArray class]] && reuseQueue.count > 0) {
        ZHBWaterFallViewCell *cell = [reuseQueue lastObject];
        [reuseQueue removeLastObject];
        return cell;
    }
    return nil;
}

- (void)reloadData{
    for (ZHBWaterFallViewCell *cell in visibleCells) {
        [self addReusableCell:cell];
        if (cell.superview) {
            [cell removeFromSuperview];
        }
    }
    [self initialize];
}

#pragma mark - private methods
- (void)initialize{
    reuseDict = [NSMutableDictionary dictionaryWithCapacity:10];
    cellRectArray = [NSMutableArray array];
    visibleCells = [NSMutableArray array];
    columnWidth = (self.frame.size.width - self.marginInsets.left - self.marginInsets.right - self.horizonPadding * (_numberOfcolumn - 1))/_numberOfcolumn;
    NSUInteger numberOfCell = 0;
    if (self.waterFallDataSource && [self.waterFallDataSource respondsToSelector:@selector(numberOfWaterFallCellsInWaterFallView:)]) {
        numberOfCell = [self.waterFallDataSource numberOfWaterFallCellsInWaterFallView:self];
    }
    NSMutableArray *columnHeightArray = [NSMutableArray arrayWithCapacity:_numberOfcolumn];
    for (int i = 0; i < _numberOfcolumn ;i ++) {
        [columnHeightArray addObject:[NSNumber numberWithFloat:self.marginInsets.top]];
    }
    for (int i = 0; i < numberOfCell; i ++) {
        CGFloat cellHeight = 80.0f;
        if (self.waterFallDataSource && [self.waterFallDataSource respondsToSelector:@selector(waterFallView:heightOfCellAtIndex:)]) {
            cellHeight = [self.waterFallDataSource waterFallView:self heightOfCellAtIndex:i];
        }
        NSUInteger shortestColumn = [self shortestColumn:columnHeightArray];
        NSNumber *shortestColumnHeightNum = columnHeightArray[shortestColumn];
        CGFloat originX = [self originXofColumn:shortestColumn];
        CGFloat originY = shortestColumnHeightNum.floatValue + self.veticalPadding;
        CGRect rect = CGRectMake(originX, originY, columnWidth, cellHeight);
        columnHeightArray[shortestColumn] = [NSNumber numberWithFloat:originY + cellHeight];
        [cellRectArray addObject:[NSValue valueWithCGRect:rect]];
    }
    
    self.contentSize = CGSizeMake(self.frame.size.width, [self maxColumnHeight:columnHeightArray] + self.marginInsets.bottom);
    [self waterFallViewDidScroll];
}

- (void)waterFallViewDidScroll{
    ZHBWaterFallViewCell *cell = nil;
    NSInteger basicVisibleIndex = 0;
    CGRect cellRect = CGRectZero;
    if (visibleCells.count == 0) {
        for (int i = 0; i < cellRectArray.count; ++i) {
            cellRect = [(NSValue *)[cellRectArray objectAtIndex:i] CGRectValue];
            if (![self cellRectInvisibleInScrollView:cellRect]) {
                cell = [self.waterFallDataSource waterFallView:self cellAtIndex:i];
                cell.index = i;
                cell.waterFallView = self;
                basicVisibleIndex = i;
                cell.frame = cellRect;
                if (!cell.superview) {
                    [self addSubview:cell];
                }
                [visibleCells insertObject:cell atIndex:0];
                break;
            }
        }
    }else{
        cell = visibleCells.firstObject;
        basicVisibleIndex = cell.index;
    }
    
    for (NSInteger i = basicVisibleIndex - 1; i >= 0; --i) {
        cellRect = [(NSValue *)[cellRectArray objectAtIndex:i] CGRectValue];
        if (![self cellRectInvisibleInScrollView:cellRect]) {
            if ([self containVisibleCellForIndex:i]) {
                continue ;
            }
            cell = [self.waterFallDataSource waterFallView:self cellAtIndex:i];
            cell.index = i;
            cell.frame = cellRect;
            cell.waterFallView = self;
            if (!cell.superview) {
                [self addSubview:cell];
            }
            [visibleCells insertObject:cell atIndex:0];
        }else{
            break;
        }
    }
    
    for (NSInteger i = basicVisibleIndex + 1; i < cellRectArray.count; i ++) {
        cellRect = [(NSValue *)[cellRectArray objectAtIndex:i] CGRectValue];
        if (![self cellRectInvisibleInScrollView:cellRect]) {
            if ([self containVisibleCellForIndex:i]) {
                continue ;
            }
            cell = [self.waterFallDataSource waterFallView:self cellAtIndex:i];
            cell.index = i;
            cell.frame = cellRect;
            cell.waterFallView = self;
            if (!cell.superview) {
                [self addSubview:cell];
            }
            [visibleCells insertObject:cell atIndex:0];
        }else{
            break;
        }
    }
    
    for (int i = 0; i < visibleCells.count; i ++) {
        cell = [visibleCells objectAtIndex:i];
        if ([self cellRectInvisibleInScrollView:cell.frame]) {
            [cell removeFromSuperview];
            [self addReusableCell:cell];
            [visibleCells removeObject:cell];
        }
    }
}

-(BOOL)cellRectInvisibleInScrollView:(CGRect)rect{
    CGPoint offset = self.contentOffset;
    if (CGRectGetMaxY(rect) < offset.y || CGRectGetMinY(rect) > (offset.y + self.frame.size.height)) {
        return YES;
    }
    return NO;
}

- (BOOL)containVisibleCellForIndex:(NSInteger)index{
    for (ZHBWaterFallViewCell *cell in visibleCells) {
        if (cell.index == index) {
            return YES;
        }
    }
    return NO;
}

- (void)addReusableCell:(ZHBWaterFallViewCell *)cell
{
    if (!cell.reuseIdentifier || cell.reuseIdentifier.length == 0) {
        return ;
    }
    
    NSMutableArray *reuseQueue = [reuseDict objectForKey:cell.reuseIdentifier];
    
    if(nil == reuseQueue) {
        reuseQueue = [NSMutableArray arrayWithObject:cell];
        [reuseDict setObject:reuseQueue forKey:cell.reuseIdentifier];
    } else {
        [reuseQueue addObject:cell];
    }
}

-(CGFloat)originXofColumn:(NSUInteger)column{
    return self.marginInsets.left + column * (columnWidth + self.horizonPadding);
}

-(NSUInteger)shortestColumn:(NSMutableArray *)columnHeightArray{
    NSUInteger shortestColumn = 0;
    CGFloat shortestHeight = 0;
    for (int i = 0; i < columnHeightArray.count ;i ++) {
        NSNumber *heightNum = columnHeightArray[i];
        CGFloat columnHeight = heightNum.floatValue;
        if (i == 0) {
            shortestHeight = columnHeight;
            shortestColumn = 0;
            continue;
        }else{
            if (columnHeight < shortestHeight) {
                shortestHeight = columnHeight;
                shortestColumn = i;
            }
        }
    }
    return shortestColumn;
}

-(CGFloat)maxColumnHeight:(NSMutableArray *)columnHeightArray{
    NSUInteger maxColumnHeight = 0;
    for (int i = 0; i < columnHeightArray.count ;i ++) {
        NSNumber *heightNum = columnHeightArray[i];
        CGFloat columnHeight = heightNum.floatValue;
        if (i == 0) {
            maxColumnHeight = columnHeight;
            continue;
        }else{
            if (columnHeight > maxColumnHeight) {
                maxColumnHeight = columnHeight;
            }
        }
    }
    return maxColumnHeight;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self waterFallViewDidScroll];
    if (_waterFallDelegate && [_waterFallDelegate respondsToSelector:@selector(waterFallViewDidScroll:)]) {
        [_waterFallDelegate waterFallViewDidScroll:self];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self waterFallViewDidScroll];
}

#pragma mark getter & setter
-(void)setFooterView:(UIView *)footerView{
    if (footerView) {
        footerView.frame = CGRectMake(0, self.contentSize.height, self.frame.size.width, footerView.frame.size.height);
        [self addSubview:footerView];
        self.contentSize = CGSizeMake(self.contentSize.width, self.contentSize.height + footerView.frame.size.height);
    }else{
        if (_footerView && _footerView.superview) {
            [_footerView removeFromSuperview];
            self.contentSize = CGSizeMake(self.contentSize.width, self.contentSize.height - _footerView.frame.size.height);
        }
    }
    _footerView = footerView;
}

@end
