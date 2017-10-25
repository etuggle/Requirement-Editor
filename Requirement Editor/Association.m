//
//  Association.m
//  Requirement Editor
//
//  Created by Eddie Tuggle on 10/25/17.
//  Copyright © 2017 etbits.coms. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Association.h"
@implementation Association
@synthesize mName;
@synthesize mStatus;
@synthesize mUid;
@synthesize mType;
@synthesize mExternalId;


- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    mType = dict[@"type"];
    mName = dict[@"name"];
    mUid = [dict[@"uid"] intValue];
    mStatus = dict[@"status"];
    mType = dict[@"type"];
    return self;
}

- (NSString *)description {
    NSString *formattedString;
    //When the type is TestDefinition the Association is associated with a Requirement
    if ([mType isEqualToString:@"TestDefinition"]) {
        formattedString = [NSString stringWithFormat:@"<Association name=\"%@\" status=\"%@\" type=\"%@\" uid=\"%d\" />", mName, mStatus, mType, mUid];
    } else {
        formattedString = [NSString stringWithFormat:@"<Association ExternalID=\"%@\" name=\"%@\" type=\"%@\" uid=\"%d\" />", mExternalId, mName, mType, mUid];
    }
    return formattedString;
}
@end
