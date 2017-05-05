//
//  BackgroundView.m
//  Graphing
//
//  Created by Ken Orr on 4/28/17.
//  Copyright © 2017 Ken Orr. All rights reserved.
//

#import "BackgroundView.h"

#import <UIKit/UIKit.h>

@implementation BackgroundView

- (void)drawRect:(CGRect)rect {
    
    // grab the current context and save off the current state.
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
//    if (@available(ios 11.0, *)) {
        NSDirectionalEdgeInsets margins = self.directionalLayoutMargins;
//    }
    
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

@end
