//
//  UIView+BRLAccessibility.h
//  Braille
//
//  Created by Ryan Davies on 28/10/2012.
//  Copyright (c) 2012 Ryan Davies. All rights reserved.
//

#import <UIKit/UIKit.h>

/** Adds convenience methods for locating views based on accessibility properties. */
@interface UIView (BRLAccessibility)

/** Recursively searches for views within the hierarchy that have the given accessibility label.
 @param label The accessibility label to match.
 @return An array of views which match the label. */
- (NSArray *)accessibilityElementsWithLabel:(NSString *)label;

/** Recursively searches for views within the hierarchy that have the given accessibility label and hint.
 @param label The accessibility label to match.
 @param hint The accessibility hint to match.
 @return An array of views which match the label and hint. */
- (NSArray *)accessibilityElementsWithLabel:(NSString *)label hint:(NSString *)hint;

/** Recursively searches for views within the hierarchy that have the given accessibility label and value.
 @param label The accessibility label to match.
 @param value The accessibility value to match.
 @return An array of views which match the label and value. */
- (NSArray *)accessibilityElementsWithLabel:(NSString *)label value:(NSString *)value;

/** Recursively searches for views within the hierarchy that have the given accessibility label and traits.
 @param label The accessibility label to match.
 @param traits The accessibility traits to match.
 @return An array of views which match the label and traits. */
- (NSArray *)accessibilityElementsWithLabel:(NSString *)label traits:(UIAccessibilityTraits)traits;

@end
