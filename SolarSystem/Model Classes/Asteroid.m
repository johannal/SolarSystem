//
//  Asteroid.m
//  Science
//
//  Copyright © 2017 Apple. All rights reserved.
//

#import "Asteroid.h"
#import "Science-Swift.h"

@implementation Asteroid

- (void)addDistantObject:(TransNeptunianObject *)object
{
    NSMutableArray<TransNeptunianObject *> *mutableObjects = self.distantObjects.mutableCopy;
    [mutableObjects addObject:object];
    NSArray<TransNeptunianObject *> *newDistantObjects = [NSArray arrayWithArray:mutableObjects];
    self.distantObjects = newDistantObjects;
}

@end
