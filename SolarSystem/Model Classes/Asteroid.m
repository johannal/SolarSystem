//
//  Asteroid.m
//  Science
//
//  Created by Russ Bishop on 5/17/17.
//  Copyright © 2017 Apple. All rights reserved.
//

#import "Asteroid.h"

@implementation Asteroid

- (void)addDistantObject:(TransNeptunianObject *)object
{
    NSMutableArray<TransNeptunianObject *> *mutableObjects = self.distantObjects.mutableCopy;
    [mutableObjects addObject:object];
    NSArray<TransNeptunianObject *> *newDistantObjects = [NSArray arrayWithArray:mutableObjects];
    self.distantObjects = newDistantObjects;
}

@end
