//
//  RequirementsDataSource.m
//  Requirement Editor
//
//  Created by Eddie Tuggle on 11/9/17.
//  Copyright © 2017 etbits.coms. All rights reserved.
//

#import "RequirementsDataSource.h"

@implementation RequirementsDataSource

- (id) init {
    _numbers = [[NSMutableArray alloc] initWithArray:@[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10"]];
    _numberCodes = [[NSMutableArray alloc] initWithArray:@[@"One", @"Two", @"Three", @"Four", @"Five", @"Six", @"Seven", @"Eight", @"Nine", @"Ten"]];
    
    return self;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    
    // how many rows do we have here?
    return self.numbers.count;
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    
    // populate each row of our table view with data
    // display a different value depending on each column (as identified in XIB)
    
    if ([tableColumn.identifier isEqualToString:@"numbers"]) {
        
        // first colum (numbers)
        return [self.numbers objectAtIndex:row];
        
    } else {
        
        // second column (numberCodes)
        return [self.numberCodes objectAtIndex:row];
    }
}
@end
