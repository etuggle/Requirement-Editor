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
    return self.requirements.count;
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    
    // populate each row of our table view with data
    // display a different value depending on each column (as identified in XIB)
    //NSLog(tableColumn.identifier);
    
    if ([tableColumn.identifier isEqualToString:@"ID"]) {
        //NSLog(@"found ID column for row %d", row);
        // first colum (numbers)
       
        Requirement *r = [_requirements objectAtIndex:row];
        NSString *reqId = r.externalId;
        return reqId;
        
    } else {
        
        // second column (numberCodes)
        NSLog(@"return: %@", [_numberCodes objectAtIndex:row]);
        return [self.numberCodes objectAtIndex:row];
    }
}

@end
