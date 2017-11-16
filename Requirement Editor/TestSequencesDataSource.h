//
//  TestSequencesDataSource.h
//  Requirement Editor
//
//  Created by Eddie Tuggle on 11/16/17.
//  Copyright © 2017 etbits.coms. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import "TestSequence.h"
#import "TestDefinition.h"

@interface TestSequencesDataSource : NSObject <NSOutlineViewDataSource>
@property (atomic, strong) NSDictionary *firstParent;
@property (atomic, strong) NSDictionary *secondParent;
@property (atomic, strong) NSArray *list;
@property (atomic, strong) NSMutableArray *sequences;
@end
