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
 @param label The accessibility label to match against views in the hierarchy.
 @return An array of views which matched the label. */
- (NSArray *)accessibilityElementsWithLabel:(NSString *)label;

@end
