//
//  AssocRequirementDataSource.m
//  Requirement Editor
//
//  Created by Eddie Tuggle on 12/21/17.
//  Copyright © 2017 etbits.coms. All rights reserved.
//

#import "AssocRequirementDataSource.h"

@implementation AssocRequirementDataSource
//
//  RequirementsDataSource.m
//  Requirement Editor
//
//  Created by Eddie Tuggle on 11/9/17.
//  Copyright © 2017 etbits.coms. All rights reserved.
//

- (id) init {
    
    return self;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    
    // how many rows do we have here?
    return _associations.count;
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    
    // populate each row of our table view with data
    // display a different value depending on each column (as identified in XIB)
    //NSLog(tableColumn.identifier);
    Association *a = [_associations objectAtIndex:row];
    
    if ([tableColumn.identifier isEqualToString:@"ID"]) {
        //NSLog(@"found ID column for row %d", row);
        // first colum (numbers)
        
        NSString *reqId = a.mExternalId;
        return reqId;
        
    } else if ([tableColumn.identifier isEqualToString:@"Name"]) {
        //NSLog(@"found ID column for row %d", row);
        // first colum (numbers)
        
        NSString *name = a.mName;
        return name;
        
        // Find the requirement name
        /*for (int i=0; i<_requirements.count; i++) {
            Requirement * req = [_requirements objectAtIndex:i];
            if ([req.externalId isEqualToString:a.mExternalId]) {
                NSString *name = req.mName;
                return name;
            }
        }
        
        return @"";
         */
        
    } else {
        // second column (numberCodes)
        NSString *dbId = [[NSString alloc] initWithFormat:@"%i",a.mUid];
        return dbId;
    }
}


- (void)tableView:(NSTableView *)aTableView setObjectValue:(id)anObject forTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
    Association *a = [_associations objectAtIndex:rowIndex];
    
    if ([aTableColumn.identifier isEqualToString:@"ID"]) {
        //[r setVerificationMethod:anObject];
    } else if ([aTableColumn.identifier isEqualToString:@"Name"]) {
        [a setMName:anObject];
        for (int i=0; i<_requirements.count; i++) {

            Requirement * req = [_requirements objectAtIndex:i];
            if ([req.externalId isEqualToString:a.mExternalId]) {
                [req setMName:a.mName];
            }
            
        }
        
    } else {
        // Should handle errors here
    }
    
}

@end
