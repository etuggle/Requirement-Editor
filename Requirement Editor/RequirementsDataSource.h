//
//  RequirementsDataSource.h
//  Requirement Editor
//
//  Created by Eddie Tuggle on 11/9/17.
//  Copyright © 2017 etbits.coms. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Requirement.h"
#import "Project.h"


@interface RequirementsDataSource : NSObject  < NSTableViewDataSource >

@property (nonatomic, strong) Project *project;
@property (nonatomic, strong) NSMutableArray *requirements;
@end
