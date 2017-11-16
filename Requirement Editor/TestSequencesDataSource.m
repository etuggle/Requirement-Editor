//
//  TestSequencesDataSource.m
//  Requirement Editor
//
//  Created by Eddie Tuggle on 11/16/17.
//  Copyright © 2017 etbits.coms. All rights reserved.
//

#import "TestSequencesDataSource.h"

@implementation TestSequencesDataSource

- (instancetype)initWithSequences:(NSMutableArray *) seq
{
    self = [super init];
    _sequences = seq;
    
    return self;
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item
{
    if ([item isKindOfClass:[TestSequence class]]) {
        return YES;
    }else {
        return NO;
    }
}

- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item
{
    
    if (item == nil) { //item is nil when the outline view wants to inquire for root level items
        return [_sequences count];
    }
    
    if ([item isKindOfClass:[TestSequence class]]) {
        return [((TestSequence*)item).testDefinitions count];
    }

    return 0;
}

- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item
{
    
    if (item == nil) { //item is nil when the outline view wants to inquire for root level items
        return [_sequences objectAtIndex:index];
    }
    
    //if ([item isKindOfClass:[NSDictionary class]]) {
    //    return [[item objectForKey:@"children"] objectAtIndex:index];
    //}
    if ([item isKindOfClass:[TestSequence class]]) {
        TestSequence *ts = item;
        TestDefinition *td = [ts.testDefinitions objectAtIndex:index];
        return td;
    }
    
    return nil;
}

- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)theColumn byItem:(id)item
{
        if ([[theColumn identifier] isEqualToString:@"Description"]) {
            if ([item isKindOfClass:[TestSequence class]]) {
                
                return ((TestSequence *)item).mDescription;
            } else {
                return ((TestDefinition*)item).mDescription;
            }
        } else {
            TestExecElement *tee = item;
            return tee.mName;
        }
        /*
        if ([item isKindOfClass:[NSDictionary class]]) {
            NSObject *obj = [item objectForKey:@"parent"];
            if ( [obj isKindOfClass:[TestSequence class]]) {
                return ((TestSequence *)obj).mDescription;
            } else {
                TestDefinition *td = [item objectForKey:@"children"];
                return td.mDescription;
            }
        }
        return item;
         
    }else{
        if ([item isKindOfClass:[NSDictionary class]]) {
            TestSequence *ts = [item objectForKey:@"parent"];
            return ts.mName;
        }
    }
         */
    
    return nil;
}
@end
