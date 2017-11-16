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
-(instancetype)initWithSequences:(NSMutableArray *)seq NS_DESIGNATED_INITIALIZER;
-(instancetype)init NS_UNAVAILABLE;

@property (atomic, strong) NSMutableArray *sequences;
@end
