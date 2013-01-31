//
//  UIView+BRLAccessibility.m
//  Braille
//
//  Created by Ryan Davies on 28/10/2012.
//  Copyright (c) 2012 Ryan Davies. All rights reserved.
//

#import "UIView+BRLAccessibility.h"

@implementation UIView (BRLAccessibility)

- (BOOL)hasValues:(NSArray *)values forKeys:(NSArray *)keys
{
    NSAssert([values count] == [keys count], @"Must have matching number of values and keys.");
    if ([values count] == 0 && [keys count] == 0) return NO;
    
    __block BOOL result = YES;
    [values enumerateObjectsUsingBlock:^(id value, NSUInteger idx, BOOL *stop) {
        id key = [keys objectAtIndex:idx];
        if ([[self valueForKey:key] isEqual:value] == NO) result = NO;
    }];
    
    return result;
}

- (NSArray *)nestedViewsWithValues:(NSArray *)values forKeys:(NSArray *)keys
{
    NSMutableArray *matches = [NSMutableArray array];
    [[self subviews] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        NSArray *nestedMatches = [view nestedViewsWithValues:values forKeys:keys];
        if (nestedMatches) [matches addObjectsFromArray:nestedMatches];
        if ([view hasValues:values forKeys:keys] == NO) return;
        [matches addObject:view];
    }];
    return [matches count] ? matches : nil;
}

- (NSArray *)accessibilityElementsWithLabel:(NSString *)label
{
    return [self nestedViewsWithValues:@[label] forKeys:@[@"accessibilityLabel"]];
}

@end
