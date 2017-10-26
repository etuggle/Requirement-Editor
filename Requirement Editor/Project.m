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
    _mPythonPath = dict[@"PythonPath"];
    return self;
}
@end
