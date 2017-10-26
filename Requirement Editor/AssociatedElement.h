//
//  AssociatedElement.h
//  Requirement Editor
//
//  Created by Eddie Tuggle on 10/26/17.
//  Copyright © 2017 etbits.coms. All rights reserved.
//

#import "TestExecElement.h"
#import <Cocoa/Cocoa.h>
#import "TestExecElement.h"
#import "Association.h"

@interface AssociatedElement : TestExecElement {
    NSString *_mStatus;
    NSMutableArray *_mAssociations;
}

-(instancetype)initWithDict:(NSDictionary *)dict NS_DESIGNATED_INITIALIZER;
-(instancetype)init NS_UNAVAILABLE;

-(void)addAssociation:(Association *)association;
-(NSMutableArray *) getAssociations;

@property (nonatomic,strong)NSString *mStatus;
@property (nonatomic,strong) NSMutableArray *mAssociations;
@end
