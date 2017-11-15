//
//  RequirementsViewDelegate.m
//  Requirement Editor
//
//  Created by Eddie Tuggle on 11/14/17.
//  Copyright © 2017 etbits.coms. All rights reserved.
//

#import "RequirementsViewDelegate.h"

@implementation RequirementsViewDelegate

- (BOOL)tableView:(NSTableView *)tableView shouldEditTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    if ([tableColumn.identifier isEqualToString:@"ID"]) {
        return NO;
    } else {
        return YES;
    }
}

- (void)tableViewSelectionDidChange:(NSNotification *)notification {
    
    //notification.
    
}
@end
