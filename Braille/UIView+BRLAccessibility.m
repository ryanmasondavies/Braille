// The MIT License
// 
// Copyright (c) 2013 Ryan Davies
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

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

- (NSArray *)accessibilityElementsWithLabel:(NSString *)label hint:(NSString *)hint
{
    return [self nestedViewsWithValues:@[label, hint] forKeys:@[@"accessibilityLabel", @"accessibilityHint"]];
}

- (NSArray *)accessibilityElementsWithLabel:(NSString *)label value:(NSString *)value
{
    return [self nestedViewsWithValues:@[label, value] forKeys:@[@"accessibilityLabel", @"accessibilityValue"]];
}

- (NSArray *)accessibilityElementsWithLabel:(NSString *)label traits:(UIAccessibilityTraits)traits
{
    return [self nestedViewsWithValues:@[label, @(traits)] forKeys:@[@"accessibilityLabel", @"accessibilityTraits"]];
}

@end
