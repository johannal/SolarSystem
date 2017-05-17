//
//  Asteroid.h
//  Science
//
//  Created by Russ Bishop on 5/17/17.
//  Copyright © 2017 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class TransNeptunianObject;

@interface Asteroid : NSObject

/**
 The partner TransNeptunianObject this Asteroid is associated with
 */
@property (nonatomic, nullable, weak) TransNeptunianObject *partner;

/**
The distant objects related to this Asteroid
 */
@property (nonatomic, strong) NSArray<TransNeptunianObject *> *distantObjects;

- (void)addDistantObject:(TransNeptunianObject *)object;

@end

NS_ASSUME_NONNULL_END
