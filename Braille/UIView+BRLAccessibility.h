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
