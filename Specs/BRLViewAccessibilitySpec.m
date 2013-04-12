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
