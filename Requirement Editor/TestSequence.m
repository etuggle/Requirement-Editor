//
//  TestSequence.m
//  Requirement Editor
//
//  Created by Eddie Tuggle on 10/26/17.
//  Copyright © 2017 etbits.coms. All rights reserved.
//

#import "TestSequence.h"

@implementation TestSequence
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super initWithDict:dict];
    return self;
}
- (NSString *)description {
    return [NSString stringWithFormat: @"<Requirement dbid=\"%d\" Name=\"%@\" uid=\"%d\">\n    <Description>%@</Description>", _mDbid, _mName, _mUid, _mDescription];
}
- (void) addTestDefinition:(TestDefinition *)testDef {
    [_testDefinitions addObject:testDef];
}
@end
