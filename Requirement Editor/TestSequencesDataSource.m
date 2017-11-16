//
//  TestSequencesDataSource.m
//  Requirement Editor
//
//  Created by Eddie Tuggle on 11/16/17.
//  Copyright © 2017 etbits.coms. All rights reserved.
//

#import "TestSequencesDataSource.h"

@implementation TestSequencesDataSource
- (instancetype)init
{
    self = [super init];
    if (self) {
        _firstParent = [NSDictionary dictionaryWithObjectsAndKeys:@"Foo",@"parent",
                        [NSArray arrayWithObjects:@"Foox",@"Fooz", nil],@"children", nil];
        _secondParent = [NSDictionary dictionaryWithObjectsAndKeys:@"Bar",@"parent",[NSArray arrayWithObjects:@"Barx",@"Barz", nil],@"children", nil];
        _list = [NSArray arrayWithObjects:_firstParent,_secondParent, nil];
    }
    return self;
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item
{
    if ([item isKindOfClass:[NSDictionary class]]) {
        return YES;
    }else {
        return NO;
    }
}

- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item
{
    
    if (item == nil) { //item is nil when the outline view wants to inquire for root level items
        return [_list count];
    }
    
    if ([item isKindOfClass:[NSDictionary class]]) {
        return [[item objectForKey:@"children"] count];
    }

    return 0;
}

- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item
{
    
    if (item == nil) { //item is nil when the outline view wants to inquire for root level items
        return [_list objectAtIndex:index];
    }
    
    if ([item isKindOfClass:[NSDictionary class]]) {
        return [[item objectForKey:@"children"] objectAtIndex:index];
    }
    
    return nil;
}

- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)theColumn byItem:(id)item
{
    
    if ([[theColumn identifier] isEqualToString:@"children"]) {
        if ([item isKindOfClass:[NSDictionary class]]) {
            return [NSString stringWithFormat:@"%lu kids",[[item objectForKey:@"children"] count]];
        }
        return item;
    }else{
        if ([item isKindOfClass:[NSDictionary class]]) {
            return [item objectForKey:@"parent"];
        }
    }
    
    return nil;
}
@end
