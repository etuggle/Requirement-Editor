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
        
    } else if ([tableColumn.identifier isEqualToString:@"Name"]) {
        //NSLog(@"found ID column for row %d", row);
        // first colum (numbers)
        
        NSString *reqId = r.mName;
        return reqId;
        
    } else if ([tableColumn.identifier isEqualToString:@"Description"]) {
        //NSLog(@"found ID column for row %d", row);
        // first colum (numbers)
        
        NSString *reqId = r.mDescription;
        return reqId;
        
    }  else if ([tableColumn.identifier isEqualToString:@"Manual"]) {
        //NSLog(@"found ID column for row %d", row);
        // first colum (numbers)
        
        NSString *reqId = r.manualStatus;
        if ([reqId isEqualToString:@"X"]) {
            return [[NSString alloc] initWithFormat:@"%d",1];
        }
        else
            return 0;
        //return reqId;
        
    } else if ([tableColumn.identifier isEqualToString:@"Verification"]) {
        //NSLog(@"found ID column for row %d", row);
        // first colum (numbers)
        
        NSString *value = r.verificationMethod;
        if ([[value uppercaseString] isEqualToString:@"DEMONSTRATION"]) {
            return @"Demonstration";
        } else if ([[value uppercaseString] isEqualToString:@"TEST"]) {
            return @"Test";
        } else if ([[value uppercaseString] isEqualToString:@"ANALYSIS"]) {
            return @"Analysis";
        } else if ([[value uppercaseString] isEqualToString:@"INSPECTION"]) {
            return @"Inspection";
        } else {
            return @"Unknown";
        }
        
    } else {
        
        // second column (numberCodes)
        NSString *dbId = [[NSString alloc] initWithFormat:@"%i",r.mUid];
        return dbId;
    }
}


- (void)tableView:(NSTableView *)aTableView setObjectValue:(id)anObject forTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
    Requirement *r = [_requirements objectAtIndex:rowIndex];
    
    if ([aTableColumn.identifier isEqualToString:@"ID"]) {
        [r setVerificationMethod:anObject];
    } else if ([aTableColumn.identifier isEqualToString:@"Name"]) {
        [r setMName:anObject];
    } else if ([aTableColumn.identifier isEqualToString:@"Description"]) {
        [r setMDescription:anObject];

    }  else if ([aTableColumn.identifier isEqualToString:@"Manual"]) {
        // first colum (numbers)
        NSString *manualIndicator;
        NSNumber *value = anObject;
        
        if ([value isEqual:@(YES)]) {
            manualIndicator = @"X";
        } else {
            manualIndicator = @"";
        }
        [r setManualStatus:manualIndicator];
        
    } else if ([aTableColumn.identifier isEqualToString:@"Verification"]) {
        //NSLog(@"found ID column for row %d", row);
        // first colum (numbers)
        
        NSString *verMethodString = anObject;

        if ([[verMethodString uppercaseString] isEqualToString:@"DEMONSTRATION"] ||
            [[verMethodString uppercaseString] isEqualToString:@"TEST"] ||
            [[verMethodString uppercaseString] isEqualToString:@"ANALYSIS"] ||
            [[verMethodString uppercaseString] isEqualToString:@"INSPECTION"]) {
            [r setVerificationMethod:verMethodString];
        } else {
            NSAlert *alert = [[NSAlert alloc] init];
            [alert addButtonWithTitle:@"OK"];
            [alert setMessageText:@"Invalid Verification Method Specified."];
            [alert setInformativeText:@"Valid options are 'Demonstration', 'Test', Analysis', 'Inspection'"];
            [alert setAlertStyle:NSAlertStyleWarning];
            if ([alert runModal] == NSAlertFirstButtonReturn) {
               
            }
        }
        
    } else {
        
        
    }
    
}


@end
