//
//  AssociatedElement.m
//  Requirement Editor
//
//  Created by Eddie Tuggle on 10/26/17.
//  Copyright © 2017 etbits.coms. All rights reserved.
//

#import "AssociatedElement.h"

@implementation AssociatedElement

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super initWithDict:dict];
    _mStatus = dict[@"status"];
    return self;
}
- (NSMutableArray *) getAssociations {
    return _mAssociations;
}
- (void) addAssociation:(Association *)association {
    [_mAssociations addObject:association];
}
@end
