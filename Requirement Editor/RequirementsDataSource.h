//
//  RequirementsDataSource.h
//  Requirement Editor
//
//  Created by Eddie Tuggle on 11/9/17.
//  Copyright © 2017 etbits.coms. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface RequirementsDataSource : NSObject  < NSTableViewDataSource >
@property (nonatomic, strong) NSMutableArray *numbers;
@property (nonatomic, strong) NSMutableArray *numberCodes;

@end
