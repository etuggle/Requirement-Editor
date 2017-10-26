//
//  Project.m
//  Requirement Editor
//
//  Created by Eddie Tuggle on 10/26/17.
//  Copyright © 2017 etbits.coms. All rights reserved.
//

#import "Project.h"

@implementation Project

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super initWithDict:dict];
    _requirements = [[NSMutableArray alloc] init];
    _testSequences = [[NSMutableArray alloc] init];
    
    _mPythonPath = dict[@"PythonPath"];
    return self;
}

- (void) addTestSequence:(TestSequence *)sequence {
    [_testSequences addObject:sequence];
}
- (void) addRequirement:(Requirement *)req {
    [_requirements addObject:req];
}
@end
