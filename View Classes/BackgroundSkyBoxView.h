//
//  BackgroundSkyBoxView.h
//  Solar System
//
//  Copyright © 2017. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    BackgroundViewStyle_None = 0,
    BackgroundViewStyle_Solid,
    BackgroundViewStyle_Gradient
} BackgroundSkyBoxViewStyle;

@interface BackgroundSkyBoxView: UIView

@property BackgroundSkyBoxViewStyle style;

@end
