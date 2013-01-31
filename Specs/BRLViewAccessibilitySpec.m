//
//  BRLViewAccessibilitySpec.m
//  Braille
//
//  Created by Ryan Davies on 31/01/2013.
//  Copyright (c) 2013 Ryan Davies. All rights reserved.
//

SpecBegin(BRLViewAccessibility)

__block UIView *rootView;
__block UIView *middleView;
__block UIView *targetView;

before(^{
    rootView = [[UIView alloc] init];
    middleView = [[UIView alloc] init];
    targetView = [[UIView alloc] init];
    
    [rootView addSubview:middleView];
    [middleView addSubview:targetView];
    
    [@[rootView, middleView] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        for (NSUInteger i = 0; i < 10; i ++) [view addSubview:[UIView new]];
    }];
});

describe(@"-accessibilityElementsWithLabel:", ^{
    it(@"should recursively search for views based on an accessibility label", ^{
        [targetView setAccessibilityLabel:@"test"];
        expect([rootView accessibilityElementsWithLabel:@"test"]).to.contain(targetView);
    });
});

SpecEnd
