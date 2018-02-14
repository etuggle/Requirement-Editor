//
//  TestSequenceDelegate.m
//  Requirement Editor
//
//  Created by Eddie Tuggle on 11/17/17.
//  Copyright © 2017 etbits.coms. All rights reserved.
//

#import "TestSequenceDelegate.h"
#import "ViewController.h"

@implementation TestSequenceDelegate

- (void)outlineViewSelectionDidChange:(NSNotification *)notification {
    
    //notification.
    NSOutlineView *oView = notification.object;
    
    id item = [oView itemAtRow:[oView selectedRow]];
    ViewController *vc = _mainView;
    [vc updateItem:item];
}


@end
