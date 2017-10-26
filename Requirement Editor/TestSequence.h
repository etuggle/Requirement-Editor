//
//  TestSequence.h
//  Requirement Editor
//
//  Created by Eddie Tuggle on 10/26/17.
//  Copyright © 2017 etbits.coms. All rights reserved.
//

#import "TestExecElement.h"

@interface TestSequence : TestExecElement
-(instancetype)initWithDict:(NSDictionary *)dict NS_DESIGNATED_INITIALIZER;
-(instancetype)init NS_UNAVAILABLE;

@property (nonatomic,strong) NSMutableArray *testDefinitions;

@end