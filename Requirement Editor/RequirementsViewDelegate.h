//
//  RequirementsViewDelegate.h
//  Requirement Editor
//
//  Created by Eddie Tuggle on 11/14/17.
//  Copyright © 2017 etbits.coms. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "RequirementsDataSource.h"

@interface RequirementsViewDelegate : NSObject <NSTableViewDelegate>
@property (atomic, strong) NSMutableArray *requirements;
@property (atomic) long selectedRow;
@end
