//
//  Project.h
//  Requirement Editor
//
//  Created by Eddie Tuggle on 10/26/17.
//  Copyright © 2017 etbits.coms. All rights reserved.
//

#import "TestExecElement.h"
#import <Cocoa/Cocoa.h>
#import "TestSequence.h"
#import "Requirement.h"

@interface Project : TestExecElement
-(instancetype)initWithDict:(NSDictionary *)dict NS_DESIGNATED_INITIALIZER;
-(instancetype)init NS_UNAVAILABLE;
-(void)addTestSequence:(TestSequence*)sequence;
-(void)addRequirement:(Requirement*)req;

@property (nonatomic, strong) NSString *mPythonPath;
@property (nonatomic,strong) NSMutableArray *testSequences;
@property (nonatomic,strong) NSMutableArray *requirements;

@end
