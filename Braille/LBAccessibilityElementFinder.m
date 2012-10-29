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
    
    NSString *label = self.filter[@"label"];
    NSString *hint = self.filter[@"hint"];
    NSString *value = self.filter[@"value"];
    NSNumber *trait = self.filter[@"trait"];
    
    [[view subviews] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        NSArray *subviewElements = [self elementsInView:view];
        if (subviewElements)
            [elements addObjectsFromArray:subviewElements];
        
        if (label && ([[view accessibilityLabel] isEqualToString:label] == NO))
            return;
        
        if (hint && ([[view accessibilityHint] isEqualToString:hint] == NO))
            return;
        
        if (value && ([[view accessibilityValue] isEqualToString:value] == NO))
            return;
        
        if (trait && ([@([view accessibilityTraits]) isEqualToNumber:trait] == NO))
            return;
        
        [elements addObject:view];
    }];
    
    return ([elements count] ? [NSArray arrayWithArray:elements] : nil);
}

@end
