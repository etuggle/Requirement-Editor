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


@property (nonatomic,strong) NSString *externalId;
@property (nonatomic,strong) NSString *manualStatus;
@property (nonatomic,strong) NSString *reviewedBy;
@property (nonatomic,strong) NSString *assignedTo;
@property (nonatomic,strong) NSString *verificationMethod;
@property (nonatomic)int mProjectId;

@end

#endif /* Requirement_h */
