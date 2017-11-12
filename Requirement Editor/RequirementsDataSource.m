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
    Requirement *r = [_requirements objectAtIndex:row];
    
    if ([tableColumn.identifier isEqualToString:@"ID"]) {
        //NSLog(@"found ID column for row %d", row);
        // first colum (numbers)
       
        
        NSString *reqId = r.externalId;
        return reqId;
        
    } else {
        
        // second column (numberCodes)
        NSString *dbId = [[NSString alloc] initWithFormat:@"%i",r.mUid];
        return dbId;
    }
}

@end
