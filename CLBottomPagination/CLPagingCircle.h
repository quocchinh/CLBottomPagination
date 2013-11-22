//
//  CLPagingCircle.h
//
//  Created by Chinh Le on 11/8/13.
//  Copyright (c) 2013 2359 Media. All rights reserved.
//

@interface CLPagingCircle : UIView

@property (nonatomic,strong) UIColor *circleColor;

- (void)moveToFrame:(CGRect)destFrame withColor:(UIColor *)color withDuration:(NSTimeInterval)duration;
- (void)setNumber:(NSInteger)number;

@end
