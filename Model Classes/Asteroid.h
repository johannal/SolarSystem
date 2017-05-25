//
//  Asteroid.h
//  Science
//
//  Copyright © 2017 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Science-Swift.h"

NS_ASSUME_NONNULL_BEGIN

@interface Asteroid : NSObject

/**
 The partner planet this object is associated with.
 */
@property (nonatomic, nullable, weak) TransNeptunianObject *partner;

/**
The distant objects related to this Asteroid
 */
@property (nonatomic, strong) NSArray<TransNeptunianObject *> *distantObjects;

/**
 Adds the given distant object.
 
 @param object the distant object to associate with this asteroid.
 */
- (void)addDistantObject:(TransNeptunianObject *)object;

@end

NS_ASSUME_NONNULL_END