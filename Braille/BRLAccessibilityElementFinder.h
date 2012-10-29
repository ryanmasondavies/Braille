//
//  BRLAccessibilityElementFinder.h
//  Braille
//
//  Created by Ryan Davies on 28/10/2012.
//  Copyright (c) 2012 Ryan Davies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BRLAccessibilityElementFinder : NSObject
@property (strong, nonatomic) NSDictionary *filter;
- (NSArray *)elementsInView:(UIView *)view;
@end
