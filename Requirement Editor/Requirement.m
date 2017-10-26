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
    _mStatus = dict[@"status"];
    return self;
}
- (NSString *)description {
    return [NSString stringWithFormat: @"<Requirement dbid=\"%d\" Name=\"%@\" status=\"%@\" uid=\"%d\">\n    <Description>%@</Description>", _mDbid, _mName, _mStatus, _mUid, _mDescription];
    
}
- (NSMutableArray *) getAssociations {
    return _mAssociations;
}
- (void) addAssociation:(Association *)association {
    [_mAssociations addObject:association];
}
@end
