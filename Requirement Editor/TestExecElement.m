//
//  TestExecElement.m
//  Requirement Editor
//
//  Created by Eddie Tuggle on 10/25/17.
//  Copyright © 2017 etbits.coms. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TestExecElement.h"
@implementation TestExecElement
/*
@synthesize mName;
@synthesize mUid;
@synthesize mDbId;
@synthesize mDescription;
*/

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    
    _mName = dict[@"name"];
    _mDbId = [dict[@"dbid"] intValue];
    _mUid = [dict[@"uid"] intValue];
    _mDescription = nil;
    return self;
}

@end
