//
//  TestDefinition.h
//  Requirement Editor
//
//  Created by Eddie Tuggle on 10/26/17.
//  Copyright © 2017 etbits.coms. All rights reserved.
//

#import "AssociatedElement.h"
#import "Script.h"

@interface TestDefinition : AssociatedElement
-(instancetype)initWithDict:(NSDictionary *)dict NS_DESIGNATED_INITIALIZER;
-(instancetype)init NS_UNAVAILABLE;

@property (nonatomic,strong) Script *script;
@property (nonatomic,strong) NSMutableArray *testSteps;
@property (nonatomic,strong) NSMutableArray *attachments;

@end
