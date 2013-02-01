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

describe(@"-accessibilityElementsWithLabel:hint:", ^{
    it(@"should recursively search for views based on an accessibility label and hint", ^{
        [targetView setAccessibilityLabel:@"test"];
        [targetView setAccessibilityHint:@"hint"];
        expect([rootView accessibilityElementsWithLabel:@"test" hint:@"hint"]).to.contain(targetView);
    });
});

describe(@"-accessibilityElementWithLabel:value:", ^{
    it(@"should recursively search for views based on an accessibility label and value", ^{
        [targetView setAccessibilityLabel:@"test"];
        [targetView setAccessibilityValue:@"value"];
        expect([rootView accessibilityElementsWithLabel:@"test" value:@"value"]).to.contain(targetView);
    });
});

describe(@"-accessibilityElementWithLabel:traits:", ^{
    it(@"should recursively search for views based on an accessibility label and traits", ^{
        [targetView setAccessibilityLabel:@"test"];
        [targetView setAccessibilityTraits:UIAccessibilityTraitAdjustable];
        expect([rootView accessibilityElementsWithLabel:@"test" traits:UIAccessibilityTraitAdjustable]).to.contain(targetView);
    });
});

SpecEnd
