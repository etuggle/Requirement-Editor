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

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    _mType = dict[@"type"];
    _mName = dict[@"name"];
    _mUid = [dict[@"uid"] intValue];
    _mStatus = dict[@"status"];
    _mExternalId = dict[@"ExternalID"];
    return self;
}

- (NSString *)description {
    NSString *formattedString;
    //When the type is TestDefinition the Association is associated with a Requirement
    if ([_mType isEqualToString:@"TestDefinition"]) {
        formattedString = [NSString stringWithFormat:@"<Association name=\"%@\" status=\"%@\" type=\"%@\" uid=\"%d\" />", _mName, _mStatus, _mType, _mUid];
    } else {
        formattedString = [NSString stringWithFormat:@"<Association ExternalID=\"%@\" name=\"%@\" type=\"%@\" uid=\"%d\" />", _mExternalId, _mName, _mType, _mUid];
    }
    return formattedString;
}
@end
