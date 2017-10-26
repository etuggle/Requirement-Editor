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
#import "Association.h"

@interface Requirement : NSObject

-(instancetype)initWithDict:(NSDictionary *)dict NS_DESIGNATED_INITIALIZER;
-(instancetype)init NS_UNAVAILABLE;
-(void)addAssociation:(Association *)association;
-(NSMutableArray *) getAssociations;

@property (nonatomic,readwrite, assign) NSString *mName;
@property (nonatomic,strong) NSString *mDescription;
@property (nonatomic, readwrite, assign) int mDbId;
@property (nonatomic, readwrite, assign) int mUid;

@property (nonatomic,strong)NSString *mStatus;
@property (nonatomic,strong) NSMutableArray *mAssociations;
@property (nonatomic,strong) NSString *mExternalId;
@property (nonatomic,strong) NSString *mManualStatus;
@property (nonatomic,strong) NSString *mReviewedBy;
@property (nonatomic,strong) NSString *mAssignedTo;
@property (nonatomic,strong) NSString *mVerificationMethod;
@property (nonatomic)int *mProjectId;

@end

#endif /* Requirement_h */
