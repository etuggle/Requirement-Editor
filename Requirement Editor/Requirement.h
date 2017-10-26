//
//  Requirement.h
//  Requirement Editor
//
//  Created by Eddie Tuggle on 10/25/17.
//  Copyright © 2017 etbits.coms. All rights reserved.
//

#ifndef Requirement_h
#define Requirement_h
#import <Cocoa/Cocoa.h>
#import "AssociatedElement.h"
#import "Association.h"

@interface Requirement : AssociatedElement

-(instancetype)initWithDict:(NSDictionary *)dict NS_DESIGNATED_INITIALIZER;
-(instancetype)init NS_UNAVAILABLE;


@property (nonatomic,strong) NSString *mExternalId;
@property (nonatomic,strong) NSString *mManualStatus;
@property (nonatomic,strong) NSString *mReviewedBy;
@property (nonatomic,strong) NSString *mAssignedTo;
@property (nonatomic,strong) NSString *mVerificationMethod;
@property (nonatomic)int *mProjectId;

@end

#endif /* Requirement_h */
