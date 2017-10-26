//
//  Requirement.m
//  Requirement Editor
//
//  Created by Eddie Tuggle on 10/25/17.
//  Copyright © 2017 etbits.coms. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Requirement.h"

@implementation Requirement

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super initWithDict:dict];
    return self;
}
- (NSString *)description {
    return [NSString stringWithFormat: @"<Requirement dbid=\"%d\" Name=\"%@\" status=\"%@\" uid=\"%d\">\n    <Description>%@</Description>", _mDbid, _mName, _mStatus, _mUid, _mDescription];
}

@end
