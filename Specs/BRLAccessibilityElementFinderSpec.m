//
//  BRLAccessibilityElementFinderSpec.m
//  Braille
//
//  Created by Ryan Davies on 28/10/2012.
//  Copyright (c) 2012 Ryan Davies. All rights reserved.
//

SpecBegin(BRLAccessibilityElementFinder)

__block BRLAccessibilityElementFinder *rootView;
before(^{ rootView = [[BRLAccessibilityElementFinder alloc] init]; });

describe(@"An accessibility element finder", ^{
    __block UIView *view;
    __block UIView *container;
    
    before(^{
        // Create view used as the element:
        view = [[UIView alloc] init];
        
        // Create container view:
        container = [[UIView alloc] init];
        [container addSubview:view];
        
        // Add some other subviews:
        for (NSUInteger i = 0; i < 10; i ++) [container addSubview:[UIView new]];
    });
    
    it(@"should search recursively", ^{
        [view setAccessibilityLabel:@"Add"];
        [rootView setFilter:@{@"label": @"Add"}];
        
        NSArray *hierarchy = @[[UIView new], [UIView new], [UIView new]];
        [hierarchy[2] addSubview:container];
        [hierarchy[1] addSubview:hierarchy[2]];
        [hierarchy[0] addSubview:hierarchy[1]];
        
        NSArray *results = [rootView elementsInView:hierarchy[0]];
        expect(results).to.haveCountOf(1);
        expect([results objectAtIndex:0]).to.beIdenticalTo(view);
    });
    
    it(@"should filter using an accessibility label", ^{
        [view setAccessibilityLabel:@"Add"];
        [rootView setFilter:@{@"label": @"Add"}];
        NSArray *results = [rootView elementsInView:container];
        expect(results).to.haveCountOf(1);
        expect([results objectAtIndex:0]).to.beIdenticalTo(view);
    });
    
    it(@"should filter using an accessibility hint", ^{
        [view setAccessibilityHint:@"Adds a new object."];
        [rootView setFilter:@{@"hint": @"Adds a new object."}];
        NSArray *results = [rootView elementsInView:container];
        expect(results).to.haveCountOf(1);
        expect([results objectAtIndex:0]).to.beIdenticalTo(view);
    });
    
    it(@"should filter using an accessibility value", ^{
        [view setAccessibilityValue:@"50%"];
        [rootView setFilter:@{@"value": @"50%"}];
        NSArray *results = [rootView elementsInView:container];
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
        
        [rootView setFilter:@{@"label": @"Add", @"hint": @"Adds a new object."}];
        
        NSArray *results = [rootView elementsInView:container];
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
        
        [rootView setFilter:@{@"label": @"Add", @"value": @"50%"}];
        
        NSArray *results = [rootView elementsInView:container];
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
        
        [rootView setFilter:@{@"hint": @"Adds a new object.", @"value": @"50%"}];
        
        NSArray *results = [rootView elementsInView:container];
        expect(results).to.haveCountOf(1);
        expect([results objectAtIndex:0]).to.beIdenticalTo(view);
    });
    
    it(@"should filter using the button trait", ^{
        [view setAccessibilityTraits:UIAccessibilityTraitButton];
        [rootView setFilter:@{@"trait": @(UIAccessibilityTraitButton)}];
        NSArray *results = [rootView elementsInView:container];
        expect(results).to.haveCountOf(1);
        expect([results objectAtIndex:0]).to.beIdenticalTo(view);
    });
    
    it(@"should filter using the link trait", ^{
        [view setAccessibilityTraits:UIAccessibilityTraitLink];
        [rootView setFilter:@{@"trait": @(UIAccessibilityTraitLink)}];
        NSArray *results = [rootView elementsInView:container];
        expect(results).to.haveCountOf(1);
        expect([results objectAtIndex:0]).to.beIdenticalTo(view);
    });
    
    it(@"should filter using the search field trait", ^{
        [view setAccessibilityTraits:UIAccessibilityTraitSearchField];
        [rootView setFilter:@{@"trait": @(UIAccessibilityTraitSearchField)}];
        NSArray *results = [rootView elementsInView:container];
        expect(results).to.haveCountOf(1);
        expect([results objectAtIndex:0]).to.beIdenticalTo(view);
    });
    
    it(@"should filter using the image trait", ^{
        [view setAccessibilityTraits:UIAccessibilityTraitImage];
        [rootView setFilter:@{@"trait": @(UIAccessibilityTraitImage)}];
        NSArray *results = [rootView elementsInView:container];
        expect(results).to.haveCountOf(1);
        expect([results objectAtIndex:0]).to.beIdenticalTo(view);
    });
    
    it(@"should filter using the selected trait", ^{
        [view setAccessibilityTraits:UIAccessibilityTraitSelected];
        [rootView setFilter:@{@"trait": @(UIAccessibilityTraitSelected)}];
        NSArray *results = [rootView elementsInView:container];
        expect(results).to.haveCountOf(1);
        expect([results objectAtIndex:0]).to.beIdenticalTo(view);
    });
    
    it(@"should filter using the 'plays sound' trait", ^{
        [view setAccessibilityTraits:UIAccessibilityTraitPlaysSound];
        [rootView setFilter:@{@"trait": @(UIAccessibilityTraitPlaysSound)}];
        NSArray *results = [rootView elementsInView:container];
        expect(results).to.haveCountOf(1);
        expect([results objectAtIndex:0]).to.beIdenticalTo(view);
    });
    
    it(@"should filter using the keyboard key trait", ^{
        [view setAccessibilityTraits:UIAccessibilityTraitKeyboardKey];
        [rootView setFilter:@{@"trait": @(UIAccessibilityTraitKeyboardKey)}];
        NSArray *results = [rootView elementsInView:container];
        expect(results).to.haveCountOf(1);
        expect([results objectAtIndex:0]).to.beIdenticalTo(view);
    });
    
    it(@"should filter using the static text trait", ^{
        [view setAccessibilityTraits:UIAccessibilityTraitStaticText];
        [rootView setFilter:@{@"trait": @(UIAccessibilityTraitStaticText)}];
        NSArray *results = [rootView elementsInView:container];
        expect(results).to.haveCountOf(1);
        expect([results objectAtIndex:0]).to.beIdenticalTo(view);
    });
    
    it(@"should filter using the summary element trait", ^{
        [view setAccessibilityTraits:UIAccessibilityTraitSummaryElement];
        [rootView setFilter:@{@"trait": @(UIAccessibilityTraitSummaryElement)}];
        NSArray *results = [rootView elementsInView:container];
        expect(results).to.haveCountOf(1);
        expect([results objectAtIndex:0]).to.beIdenticalTo(view);
    });
    
    it(@"should filter using the not enabled trait", ^{
        [view setAccessibilityTraits:UIAccessibilityTraitNotEnabled];
        [rootView setFilter:@{@"trait": @(UIAccessibilityTraitNotEnabled)}];
        NSArray *results = [rootView elementsInView:container];
        expect(results).to.haveCountOf(1);
        expect([results objectAtIndex:0]).to.beIdenticalTo(view);
    });
    
    it(@"should filter using the updates frequently trait", ^{
        [view setAccessibilityTraits:UIAccessibilityTraitUpdatesFrequently];
        [rootView setFilter:@{@"trait": @(UIAccessibilityTraitUpdatesFrequently)}];
        NSArray *results = [rootView elementsInView:container];
        expect(results).to.haveCountOf(1);
        expect([results objectAtIndex:0]).to.beIdenticalTo(view);
    });
    
    it(@"should filter using the starts media session trait", ^{
        [view setAccessibilityTraits:UIAccessibilityTraitStartsMediaSession];
        [rootView setFilter:@{@"trait": @(UIAccessibilityTraitStartsMediaSession)}];
        NSArray *results = [rootView elementsInView:container];
        expect(results).to.haveCountOf(1);
        expect([results objectAtIndex:0]).to.beIdenticalTo(view);
    });
    
    it(@"should filter using the adjustable trait", ^{
        [view setAccessibilityTraits:UIAccessibilityTraitAdjustable];
        [rootView setFilter:@{@"trait": @(UIAccessibilityTraitAdjustable)}];
        NSArray *results = [rootView elementsInView:container];
        expect(results).to.haveCountOf(1);
        expect([results objectAtIndex:0]).to.beIdenticalTo(view);
    });
    
    it(@"should filter using the allows direct interaction trait", ^{
        [view setAccessibilityTraits:UIAccessibilityTraitAllowsDirectInteraction];
        [rootView setFilter:@{@"trait": @(UIAccessibilityTraitAllowsDirectInteraction)}];
        NSArray *results = [rootView elementsInView:container];
        expect(results).to.haveCountOf(1);
        expect([results objectAtIndex:0]).to.beIdenticalTo(view);
    });
    
    it(@"should filter using the causes page turn trait", ^{
        [view setAccessibilityTraits:UIAccessibilityTraitCausesPageTurn];
        [rootView setFilter:@{@"trait": @(UIAccessibilityTraitCausesPageTurn)}];
        NSArray *results = [rootView elementsInView:container];
        expect(results).to.haveCountOf(1);
        expect([results objectAtIndex:0]).to.beIdenticalTo(view);
    });
});

SpecEnd
