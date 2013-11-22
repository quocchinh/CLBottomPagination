//
//  CLBottomPagination.h
//
//  Created by Chinh Le on 11/12/13.
//  Copyright (c) 2013 2359 Media. All rights reserved.
//

@interface CLBottomPagination : UIView

@property (nonatomic) NSInteger circleSize;
@property (nonatomic,strong) UIColor *pageSeenCircleColor, *pageNotSeenCircleColor;

- (void)registerPages:(NSArray *)pages withCircleSize:(NSInteger)circleSize withSpaceBetweenCircles:(NSInteger)space;
- (void)display;

@end
