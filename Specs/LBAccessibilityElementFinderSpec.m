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

__block LBAccessibilityElementFinder *subject;

before(^{
    subject = [[LBAccessibilityElementFinder alloc] init];
});

describe(@"An accessibility element finder", ^{
    __block UIView *view;
    __block UIView *container;
    
    before(^{
        // Create view used as the element:
        view = [[UIView alloc] init];
        
        // Create container view:
        container = [[UIView alloc] init];
        [container addSubview:view];
        
        // Add between 5 and 10 other subviews:
        for (NSUInteger i = 5; i < rand() % 5; i ++) {
            [container addSubview:[UIView new]];
        }
        
        // Shuffle the subviews:
        NSUInteger count = [[container subviews] count];
        for (NSUInteger i = 0; i < count; i ++) {
            NSInteger nElements = count - i;
            NSInteger n = (arc4random() % nElements) + i;
            [container exchangeSubviewAtIndex:i withSubviewAtIndex:n];
        }
    });
    
    it(@"should search recursively", ^{
        [view setAccessibilityLabel:@"Add"];
        [subject setFilter:@{@"label": @"Add"}];
        
        NSArray *hierarchy = @[[UIView new], [UIView new], [UIView new]];
        [hierarchy[2] addSubview:container];
        [hierarchy[1] addSubview:hierarchy[2]];
        [hierarchy[0] addSubview:hierarchy[1]];
        
        NSArray *results = [subject elementsInView:hierarchy[0]];
        expect(results).to.haveCountOf(1);
        expect([results objectAtIndex:0]).to.beIdenticalTo(view);
    });
    
    it(@"should filter using an accessibility label", ^{
        [view setAccessibilityLabel:@"Add"];
        [subject setFilter:@{@"label": @"Add"}];
        NSArray *results = [subject elementsInView:container];
        expect(results).to.haveCountOf(1);
        expect([results objectAtIndex:0]).to.beIdenticalTo(view);
    });
    
    it(@"should filter using an accessibility hint", ^{
        [view setAccessibilityHint:@"Adds a new object."];
        [subject setFilter:@{@"hint": @"Adds a new object."}];
        NSArray *results = [subject elementsInView:container];
        expect(results).to.haveCountOf(1);
        expect([results objectAtIndex:0]).to.beIdenticalTo(view);
    });
    
    it(@"should filter using an accessibility value", ^{
        [view setAccessibilityValue:@"50%"];
        [subject setFilter:@{@"value": @"50%"}];
        NSArray *results = [subject elementsInView:container];
        expect(results).to.haveCountOf(1);
        expect([results objectAtIndex:0]).to.beIdenticalTo(view);
    });
    
    it(@"should filter using an accessibility label and hint", ^{
        [view setAccessibilityLabel:@"Add"];
        [view setAccessibilityHint:@"Adds a new object."];
        
        NSMutableArray *decoys = [NSMutableArray array];
        decoys[0] = [[UIView alloc] init];
        decoys[1] = [[UIView alloc] init];
        [decoys[0] setAccessibilityLabel:@"Add"];
        [decoys[1] setAccessibilityHint:@"Adds a new object."];
        [container addSubview:decoys[0]];
        [container addSubview:decoys[1]];
        
        [subject setFilter:@{@"label": @"Add", @"hint": @"Adds a new object."}];
        
        NSArray *results = [subject elementsInView:container];
        expect(results).to.haveCountOf(1);
        expect([results objectAtIndex:0]).to.beIdenticalTo(view);
    });
    
    it(@"should filter using an accessibility label and value", ^{
        [view setAccessibilityLabel:@"Add"];
        [view setAccessibilityValue:@"50%"];
        
        NSMutableArray *decoys = [NSMutableArray array];
        decoys[0] = [[UIView alloc] init];
        decoys[1] = [[UIView alloc] init];
        [decoys[0] setAccessibilityLabel:@"Add"];
        [decoys[1] setAccessibilityValue:@"50%"];
        [container addSubview:decoys[0]];
        [container addSubview:decoys[1]];
        
        [subject setFilter:@{@"label": @"Add", @"value": @"50%"}];
        
        NSArray *results = [subject elementsInView:container];
        expect(results).to.haveCountOf(1);
        expect([results objectAtIndex:0]).to.beIdenticalTo(view);
    });
    
    it(@"should filter using an accessibility hint and value", ^{
        [view setAccessibilityHint:@"Adds a new object."];
        [view setAccessibilityValue:@"50%"];
        
        NSMutableArray *decoys = [NSMutableArray array];
        decoys[0] = [[UIView alloc] init];
        decoys[1] = [[UIView alloc] init];
        [decoys[0] setAccessibilityHint:@"Adds a new object."];
        [decoys[1] setAccessibilityValue:@"50%"];
        [container addSubview:decoys[0]];
        [container addSubview:decoys[1]];
        
        [subject setFilter:@{@"hint": @"Adds a new object.", @"value": @"50%"}];
        
        NSArray *results = [subject elementsInView:container];
        expect(results).to.haveCountOf(1);
        expect([results objectAtIndex:0]).to.beIdenticalTo(view);
    });
    
    it(@"should filter using the button trait", ^{
        [view setAccessibilityTraits:UIAccessibilityTraitButton];
        [subject setFilter:@{@"trait": @(UIAccessibilityTraitButton)}];
        NSArray *results = [subject elementsInView:container];
        expect(results).to.haveCountOf(1);
        expect([results objectAtIndex:0]).to.beIdenticalTo(view);
    });
    
    it(@"should filter using the link trait", ^{
        [view setAccessibilityTraits:UIAccessibilityTraitLink];
        [subject setFilter:@{@"trait": @(UIAccessibilityTraitLink)}];
        NSArray *results = [subject elementsInView:container];
        expect(results).to.haveCountOf(1);
        expect([results objectAtIndex:0]).to.beIdenticalTo(view);
    });
    
    it(@"should filter using the search field trait", ^{
        [view setAccessibilityTraits:UIAccessibilityTraitSearchField];
        [subject setFilter:@{@"trait": @(UIAccessibilityTraitSearchField)}];
        NSArray *results = [subject elementsInView:container];
        expect(results).to.haveCountOf(1);
        expect([results objectAtIndex:0]).to.beIdenticalTo(view);
    });
    
    it(@"should filter using the image trait", ^{
        [view setAccessibilityTraits:UIAccessibilityTraitImage];
        [subject setFilter:@{@"trait": @(UIAccessibilityTraitImage)}];
        NSArray *results = [subject elementsInView:container];
        expect(results).to.haveCountOf(1);
        expect([results objectAtIndex:0]).to.beIdenticalTo(view);
    });
    
    it(@"should filter using the selected trait", ^{
        [view setAccessibilityTraits:UIAccessibilityTraitSelected];
        [subject setFilter:@{@"trait": @(UIAccessibilityTraitSelected)}];
        NSArray *results = [subject elementsInView:container];
        expect(results).to.haveCountOf(1);
        expect([results objectAtIndex:0]).to.beIdenticalTo(view);
    });
    
    it(@"should filter using the 'plays sound' trait", ^{
        [view setAccessibilityTraits:UIAccessibilityTraitPlaysSound];
        [subject setFilter:@{@"trait": @(UIAccessibilityTraitPlaysSound)}];
        NSArray *results = [subject elementsInView:container];
        expect(results).to.haveCountOf(1);
        expect([results objectAtIndex:0]).to.beIdenticalTo(view);
    });
    
    it(@"should filter using the keyboard key trait", ^{
        [view setAccessibilityTraits:UIAccessibilityTraitKeyboardKey];
        [subject setFilter:@{@"trait": @(UIAccessibilityTraitKeyboardKey)}];
        NSArray *results = [subject elementsInView:container];
        expect(results).to.haveCountOf(1);
        expect([results objectAtIndex:0]).to.beIdenticalTo(view);
    });
    
    it(@"should filter using the static text trait", ^{
        [view setAccessibilityTraits:UIAccessibilityTraitStaticText];
        [subject setFilter:@{@"trait": @(UIAccessibilityTraitStaticText)}];
        NSArray *results = [subject elementsInView:container];
        expect(results).to.haveCountOf(1);
        expect([results objectAtIndex:0]).to.beIdenticalTo(view);
    });
    
    it(@"should filter using the summary element trait", ^{
        [view setAccessibilityTraits:UIAccessibilityTraitSummaryElement];
        [subject setFilter:@{@"trait": @(UIAccessibilityTraitSummaryElement)}];
        NSArray *results = [subject elementsInView:container];
        expect(results).to.haveCountOf(1);
        expect([results objectAtIndex:0]).to.beIdenticalTo(view);
    });
    
    it(@"should filter using the not enabled trait", ^{
        [view setAccessibilityTraits:UIAccessibilityTraitNotEnabled];
        [subject setFilter:@{@"trait": @(UIAccessibilityTraitNotEnabled)}];
        NSArray *results = [subject elementsInView:container];
        expect(results).to.haveCountOf(1);
        expect([results objectAtIndex:0]).to.beIdenticalTo(view);
    });
    
    it(@"should filter using the updates frequently trait", ^{
        [view setAccessibilityTraits:UIAccessibilityTraitUpdatesFrequently];
        [subject setFilter:@{@"trait": @(UIAccessibilityTraitUpdatesFrequently)}];
        NSArray *results = [subject elementsInView:container];
        expect(results).to.haveCountOf(1);
        expect([results objectAtIndex:0]).to.beIdenticalTo(view);
    });
    
    it(@"should filter using the starts media session trait", ^{
        [view setAccessibilityTraits:UIAccessibilityTraitStartsMediaSession];
        [subject setFilter:@{@"trait": @(UIAccessibilityTraitStartsMediaSession)}];
        NSArray *results = [subject elementsInView:container];
        expect(results).to.haveCountOf(1);
        expect([results objectAtIndex:0]).to.beIdenticalTo(view);
    });
    
    it(@"should filter using the adjustable trait", ^{
        [view setAccessibilityTraits:UIAccessibilityTraitAdjustable];
        [subject setFilter:@{@"trait": @(UIAccessibilityTraitAdjustable)}];
        NSArray *results = [subject elementsInView:container];
        expect(results).to.haveCountOf(1);
        expect([results objectAtIndex:0]).to.beIdenticalTo(view);
    });
    
    it(@"should filter using the allows direct interaction trait", ^{
        [view setAccessibilityTraits:UIAccessibilityTraitAllowsDirectInteraction];
        [subject setFilter:@{@"trait": @(UIAccessibilityTraitAllowsDirectInteraction)}];
        NSArray *results = [subject elementsInView:container];
        expect(results).to.haveCountOf(1);
        expect([results objectAtIndex:0]).to.beIdenticalTo(view);
    });
    
    it(@"should filter using the causes page turn trait", ^{
        [view setAccessibilityTraits:UIAccessibilityTraitCausesPageTurn];
        [subject setFilter:@{@"trait": @(UIAccessibilityTraitCausesPageTurn)}];
        NSArray *results = [subject elementsInView:container];
        expect(results).to.haveCountOf(1);
        expect([results objectAtIndex:0]).to.beIdenticalTo(view);
    });
});

SpecEnd
