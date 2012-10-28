//
//  LBAccessibilityElementFinder.m
//  Braille
//
//  Created by Ryan Davies on 28/10/2012.
//  Copyright (c) 2012 Ryan Davies. All rights reserved.
//

#import "LBAccessibilityElementFinder.h"

@implementation LBAccessibilityElementFinder

- (NSArray *)elementsInView:(UIView *)view
{
    NSMutableArray *elements = [NSMutableArray array];
    
    [[view subviews] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        if ([@([view accessibilityTraits]) isEqualToNumber:self.filter[@"traits"]]) {
            [elements addObject:view];
        }
    }];
    
    return [NSArray arrayWithArray:elements];
}

@end
