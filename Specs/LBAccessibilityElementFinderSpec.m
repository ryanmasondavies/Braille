//
//  LBAccessibilityElementFinderSpec.m
//  Braille
//
//  Created by Ryan Davies on 28/10/2012.
//  Copyright (c) 2012 Ryan Davies. All rights reserved.
//

#define EXP_SHORTHAND
#import <Expecta/Expecta.h>
#import <Specta/Specta.h>

#import "LBAccessibilityElementFinder.h"

SpecBegin(LBAccessibilityElementFinder)

NSArray *traits = @[
    @(UIAccessibilityTraitNone),
    @(UIAccessibilityTraitButton),
    @(UIAccessibilityTraitLink),
    @(UIAccessibilityTraitSearchField),
    @(UIAccessibilityTraitImage),
    @(UIAccessibilityTraitSelected),
    @(UIAccessibilityTraitPlaysSound),
    @(UIAccessibilityTraitKeyboardKey),
    @(UIAccessibilityTraitStaticText),
    @(UIAccessibilityTraitSummaryElement),
    @(UIAccessibilityTraitNotEnabled),
    @(UIAccessibilityTraitUpdatesFrequently),
    @(UIAccessibilityTraitStartsMediaSession),
    @(UIAccessibilityTraitAdjustable),
    @(UIAccessibilityTraitAllowsDirectInteraction),
    @(UIAccessibilityTraitCausesPageTurn)
];

NSDictionary *descriptions = @{
    @(UIAccessibilityTraitNone): @"elements with no traits",
    @(UIAccessibilityTraitButton): @"buttons",
    @(UIAccessibilityTraitLink): @"links",
    @(UIAccessibilityTraitSearchField): @"search fields",
    @(UIAccessibilityTraitImage): @"images",
    @(UIAccessibilityTraitSelected): @"selected elements",
    @(UIAccessibilityTraitPlaysSound): @"elements that play sound",
    @(UIAccessibilityTraitKeyboardKey): @"keyboard keys",
    @(UIAccessibilityTraitStaticText): @"static text",
    @(UIAccessibilityTraitSummaryElement): @"summary elements",
    @(UIAccessibilityTraitNotEnabled): @"disabled elements",
    @(UIAccessibilityTraitUpdatesFrequently): @"elements that update frequently",
    @(UIAccessibilityTraitStartsMediaSession): @"elements that start media sessions",
    @(UIAccessibilityTraitAdjustable): @"adjustable elements",
    @(UIAccessibilityTraitAllowsDirectInteraction): @"elements that allow direct interaction",
    @(UIAccessibilityTraitCausesPageTurn): @"elements that cause page turns"
};

__block LBAccessibilityElementFinder *subject;

before(^{
    subject = [[LBAccessibilityElementFinder alloc] init];
});

describe(@"An accessibility element finder", ^{
    __block UIView *view;
    __block NSArray *elementsFound;
    
    [traits enumerateObjectsUsingBlock:^(NSNumber *trait, NSUInteger idx, BOOL *stop) {
        before(^{
            [subject setFilter:@{@"traits": trait}];
            
            view = [[UIView alloc] init];
            [view setAccessibilityTraits:[trait integerValue]];
            
            UIView *containerView = [[UIView alloc] init];
            [containerView addSubview:view];
            
            // Add between 5 and 10 other subviews:
            for (NSUInteger i = 5; i < rand() % 5; i ++) {
                [containerView addSubview:[UIView new]];
            }
            
            // Shuffle the subviews:
            NSUInteger count = [[containerView subviews] count];
            for (NSUInteger i = 0; i < count; i ++) {
                NSInteger nElements = count - i;
                NSInteger n = (arc4random() % nElements) + i;
                [containerView exchangeSubviewAtIndex:i withSubviewAtIndex:n];
            }
            
            elementsFound = [subject elementsInView:containerView];
        });
        
        describe([NSString stringWithFormat:@"when finding %@", descriptions[trait]], ^{
            it(@"should return 1 element", ^{
                expect(elementsFound).to.haveCountOf(1);
            });
            
            describe(@"the found element", ^{
                it(@"should be the view", ^{
                    expect([elementsFound objectAtIndex:0]).to.beIdenticalTo(view);
                });
            });
        });
    }];
    
    context(@"using two traits", ^{});
    context(@"using three traits", ^{});
    context(@"using four traits", ^{});
    context(@"using five traits", ^{});
    context(@"using six traits", ^{});
    context(@"using seven traits", ^{});
    context(@"using eight traits", ^{});
    context(@"using nine traits", ^{});
    context(@"using ten traits", ^{});
    context(@"using eleven traits", ^{});
    context(@"using twelve traits", ^{});
    context(@"using thirteen traits", ^{});
    context(@"using fourteen traits", ^{});
    context(@"using every trait", ^{});
});

SpecEnd
