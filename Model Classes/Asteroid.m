//
//  Asteroid.m
//  Solar System
//
//  Copyright © 2017 Apple Inc. All rights reserved.
//

#import "Asteroid.h"
#import "Solar_System-Swift.h"

@implementation Asteroid

- (void)addDistantObject:(TransNeptunianObject *)object
{
    NSMutableArray<TransNeptunianObject *> *mutableObjects = self.distantObjects.mutableCopy;
    [mutableObjects addObject:object];
    NSArray<TransNeptunianObject *> *newDistantObjects = [NSArray arrayWithArray:mutableObjects];
    self.distantObjects = newDistantObjects;
}

@end
