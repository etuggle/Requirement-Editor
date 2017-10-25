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

/*
@synthesize mStatus;
@synthesize mAssociations;
@synthesize mExternalId;
@synthesize mManualStatus;
@synthesize mReviewedBy;
@synthesize mAssignedTo;
@synthesize mVerificationMethod;
@synthesize mProjectId;
 */
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super initWithDict:dict];
    _mStatus = dict[@"status"];
    return self;
}
- (NSString *)description {
    return [NSString stringWithFormat: @"<Requirement dbid=\"%d\" Name=\"%@\" status=\"%@\" uid=\"%d\">", mDbid,
            mName, _mStatus, mUid];
    
}
@end
