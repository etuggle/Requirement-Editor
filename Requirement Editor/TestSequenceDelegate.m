//
//  TestSequenceDelegate.m
//  Requirement Editor
//
//  Created by Eddie Tuggle on 11/17/17.
//  Copyright © 2017 etbits.coms. All rights reserved.
//

#import "TestSequenceDelegate.h"

@implementation TestSequenceDelegate

- (void)outlineViewSelectionDidChange:(NSNotification *)notification {
    
    //notification.
    NSOutlineView *oView = notification.object;
    
    id item = [oView itemAtRow:[oView selectedRow]];
    NSString *foo;
    if ([item isKindOfClass:[TestSequence class]]) {
        TestSequence *ts = item;
        foo = ts.mName;
    } else {
        TestDefinition *td = item;
        foo = td.mName;
    }
    NSLog(@"received notification: %@ for row %ld, name=%@", notification.name, oView.selectedRow, foo);
    
    //[tView setNeedsDisplay:YES];
   
    
}
@end
