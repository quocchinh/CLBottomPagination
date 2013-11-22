//
//  CLPagingCircle.m
//
//  Created by Chinh Le on 11/8/13.
//  Copyright (c) 2013 2359 Media. All rights reserved.
//

#import "CLPagingCircle.h"

@interface CLPagingCircle()

@property (nonatomic) CGRect destinationFrame;
@property (nonatomic) UIColor *destinationColor;
@property (nonatomic) UILabel *numberLabel;

@end

@implementation CLPagingCircle

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.numberLabel.textAlignment = NSTextAlignmentCenter;
        self.numberLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.numberLabel];
    }
    return self;
}

+ (Class)layerClass {
    return [CAShapeLayer class];
}

- (void)setNumber:(NSInteger)number
{
    self.numberLabel.text = [NSString stringWithFormat:@"%ld",(long)number];
}

- (void)layoutSubviews {
    [self setLayerProperties];
    
}

- (void)setLayerProperties {
    CAShapeLayer *layer = (CAShapeLayer *)self.layer;
    layer.path = [UIBezierPath bezierPathWithOvalInRect:self.bounds].CGPath;
    layer.fillColor = self.circleColor.CGColor;
    
}

- (void)moveToFrame:(CGRect)destFrame withColor:(UIColor *)color withDuration:(NSTimeInterval)duration
{
    self.destinationFrame = destFrame;
    self.destinationColor = color;
    CGRect destinationFrameInRelationToSelfFrame = CGRectMake(destFrame.origin.x - self.frame.origin.x, destFrame.origin.y - self.frame.origin.y, destFrame.size.width, destFrame.size.height);
    [self attachPathAnimationToFrame:destinationFrameInRelationToSelfFrame withDuration:duration];
    [self attachNumberLabelAnimationToFrame:destinationFrameInRelationToSelfFrame withDuration:duration];
    [self attachColorAnimationToColor:color withDuration:duration];
}

- (void)attachNumberLabelAnimationToFrame:(CGRect)destFrame withDuration:(NSTimeInterval)duration
{
    [UIView animateWithDuration:duration animations:^{self.numberLabel.frame = destFrame;}];
}

- (void)attachPathAnimationToFrame:(CGRect)destFrame withDuration:(NSTimeInterval)duration
{
    CABasicAnimation *animation = [self animationWithKeyPath:@"path" withDuration:duration];
    animation.toValue = (__bridge id)[UIBezierPath bezierPathWithOvalInRect:destFrame].CGPath;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.delegate = self;
    [self.layer addAnimation:animation forKey:animation.keyPath];
}

- (void)attachColorAnimationToColor:(UIColor *)color withDuration:(NSTimeInterval)duration
{
    CABasicAnimation *animation = [self animationWithKeyPath:@"fillColor" withDuration:duration];
    animation.toValue = (__bridge id)color.CGColor;
    [self.layer addAnimation:animation forKey:animation.keyPath];
}

- (CABasicAnimation *)animationWithKeyPath:(NSString *)keyPath withDuration:(NSTimeInterval)duration {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:keyPath];
    animation.autoreverses = NO;
    animation.repeatCount = 0;
    animation.duration = duration;
    return animation;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    self.frame = self.destinationFrame;
    self.numberLabel.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.circleColor = self.destinationColor;
    [self setLayerProperties];
}

@end
