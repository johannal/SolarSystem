//
//  Asteroid.m
//  Solar System
//
//  Copyright © 2018 Apple Inc. All rights reserved.
//

#import "Asteroid.h"
#import "Solar_System_iOS-Swift.h"

@implementation Asteroid

- (void)addDistantObject:(TransNeptunianObject *)object
{
    NSMutableArray<TransNeptunianObject *> *mutableObjects = self.distantObjects.mutableCopy;
    [mutableObjects addObject:object];
    NSArray<TransNeptunianObject *> *newDistantObjects = [NSArray arrayWithArray:mutableObjects];
    self.distantObjects = newDistantObjects;
}

@end
