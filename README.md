Braille
=======

A collection of Objective-C classes and extensions used for finding and handling accessibility elements.

Within a view hierarchy, views can be retrieved based on their accessibility properties.

For example, in order to find an accessibility element labelled 'Add' (the default label for an Add button in a navigation bar), the following code example would suffice:

    LBAccessibilityElementFinder *finder = [[LBAccessibilityElementFinder alloc] init];
    [finder setFilter:@{@"label": @"Add"}];
    NSArray *elements = [finder elementsInView:[self view]];
    UIBarButtonItem *addButton = [elements objectAtIndex:0];

This library is very much a work in progress, and so the API may be subject to potentially drastic change and simplification.
