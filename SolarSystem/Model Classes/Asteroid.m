//
//  Asteroid.m
//  Science
//
//  Copyright © 2017 Apple. All rights reserved.
//

#import "Asteroid.h"
#import "Science-Swift.h"

@implementation Asteroid

- (void)addDistantObject:(SmallPlanet *)object
{
    NSMutableArray<SmallPlanet *> *mutableObjects = self.distantObjects.mutableCopy;
    [mutableObjects addObject:object];
    NSArray<SmallPlanet *> *newDistantObjects = [NSArray arrayWithArray:mutableObjects];
    self.distantObjects = newDistantObjects;
}

@end
