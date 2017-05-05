//
//  BackgroundView.h
//  Graphing
//
//  Created by Ken Orr on 4/28/17.
//  Copyright © 2017 Ken Orr. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    BackgroundViewStyle_None = 0,
    BackgroundViewStyle_Solid,
    BackgroundViewStyle_Gradient
} BackgroundViewStyle;

@interface BackgroundView: UIView

@property BackgroundViewStyle style;

@end
