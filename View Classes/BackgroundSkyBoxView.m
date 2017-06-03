//
//  BackgroundSkyBoxView.m
//  Solar System
//
//  Copyright © 2017 Apple Inc. All rights reserved.
//

#import "BackgroundSkyBoxView.h"

#import <UIKit/UIKit.h>
#import "Solar_System-Swift.h"

@implementation BackgroundSkyBoxView

- (void)drawRect:(CGRect)rect {
    
    
    
    // grab the current context and save off the current state.
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    // calculate our starting and ending points.
    CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
    
    // create the starting and ending colors.
    UIColor *startingColor = [[UIColor alloc] initWithWhite:1.0 alpha:1.0];
    UIColor *endingColor = [[UIColor alloc] initWithWhite:0.95 alpha:1.0];
    
    // create the gradient.
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    NSArray *colors = @[startingColor, endingColor];
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)colors, locations);
    
    // draw a graident background.
    CGContextAddRect(context, rect);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
}

- (void)adjustToMargins:(NSDirectionalEdgeInsets)layoutMargins {
    
}

- (void)_updateBackground {
    
}

- (void)_setupContextForNone:(CGContextRef)context {
    
}

- (void)_setupContextForSolid:(CGContextRef)context {
    
}

- (void)_setupContextForGradient:(CGContextRef)context {
    
}

@end
