//
//  CLBottomPagination.m
//
//  Created by Chinh Le on 11/12/13.
//  Copyright (c) 2013 2359 Media. All rights reserved.
//

#import "CLBottomPagination.h"
#import "CLPagingCircle.h"

@interface CLBottomPagination()

@property (nonatomic,strong) NSArray *pages;
@property (nonatomic) NSInteger currentPage;
@property (nonatomic) NSMutableArray *pagingCircles;
@property (nonatomic) NSInteger spaceBetweenCircles;
@property (nonatomic,strong) UIButton *pageNameButton;


@end

@implementation CLBottomPagination

-(NSMutableArray *)pagingCircles
{
    if ( !_pagingCircles ) {
        _pagingCircles = [[NSMutableArray alloc] init];
    }
    
    return _pagingCircles;
}

-(UIButton *)pageNameButton
{
    if (!_pageNameButton ) {
        _pageNameButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _pageNameButton.frame = CGRectMake((self.bounds.size.width-100)/2, (self.bounds.size.height-40)/2+5, 100, 40);
        [_pageNameButton addTarget:self action:@selector(goToNextPage) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_pageNameButton];
    }
    return _pageNameButton;
}

-(UIColor *)pageSeenCircleColor
{
    if (!_pageSeenCircleColor) {
        _pageSeenCircleColor = [UIColor colorWithRed:51.0f/255.0f green:102.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    }
    return _pageSeenCircleColor;
}

-(UIColor *)pageNotSeenCircleColor
{
    if (!_pageNotSeenCircleColor) {
        _pageNotSeenCircleColor = [UIColor blueColor];
    }
    return _pageNotSeenCircleColor;
}

-(NSInteger)currentPage
{
    return _currentPage+1;
}

- (void)registerPages:(NSArray *)pages withCircleSize:(NSInteger)circleSize withSpaceBetweenCircles:(NSInteger)space
{
    _pages = pages;
    _currentPage = 0;
    self.circleSize = circleSize;
    self.spaceBetweenCircles = space;
}

-(void)setButtonToPage:(NSInteger)page
{
    [self.pageNameButton setTitle:[self.pages objectAtIndex:page] forState:UIControlStateNormal];
}

-(void)goToNextPage
{
    if ( _currentPage+1 == self.pages.count ) return;
    _currentPage++;
    CLPagingCircle *currentCircle = [self.pagingCircles objectAtIndex:_currentPage];
    NSInteger moveToX = 5 + _currentPage*(self.circleSize + self.spaceBetweenCircles);
    [currentCircle moveToFrame:CGRectMake(moveToX, -self.circleSize / 2, self.circleSize, self.circleSize) withColor:self.pageSeenCircleColor withDuration:0.5];
    [self setButtonToPage:_currentPage];
}

-(void)display
{
    CLPagingCircle *firstOne = [[CLPagingCircle alloc] initWithFrame:CGRectMake(5, -self.circleSize / 2, self.circleSize, self.circleSize)];
    firstOne.circleColor = self.pageSeenCircleColor;
    [firstOne setNumber:1];
    
    [self.pagingCircles addObject:firstOne];
    [self addSubview:firstOne];
    
    CLPagingCircle *secondOne = [[CLPagingCircle alloc] initWithFrame:CGRectMake((self.bounds.size.width - self.circleSize)/2, -self.circleSize / 2, self.circleSize, self.circleSize)];
    secondOne.circleColor = self.pageNotSeenCircleColor;
    [secondOne setNumber:2];
    
    [self.pagingCircles addObject:secondOne];
    [self addSubview:secondOne];
    
    for (int i=2; i<_pages.count; i++) {
        NSInteger nextOneX = (self.bounds.size.width - 5 - self.circleSize) - (_pages.count-1-i)*(self.circleSize + self.spaceBetweenCircles);
        CLPagingCircle *nextOne = [[CLPagingCircle alloc] initWithFrame:CGRectMake(nextOneX, -self.circleSize / 2, self.circleSize, self.circleSize)];
        nextOne.circleColor = self.pageNotSeenCircleColor;
        [nextOne setNumber:i+1];
        [self.pagingCircles addObject:nextOne];
        [self addSubview:nextOne];
    }
    
    [self setButtonToPage:0];
}


@end
