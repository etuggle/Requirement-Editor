//
//  Project.h
//  Requirement Editor
//
//  Created by Eddie Tuggle on 10/26/17.
//  Copyright © 2017 etbits.coms. All rights reserved.
//

#import "TestExecElement.h"
#import <Cocoa/Cocoa.h>

@interface Project : TestExecElement
-(instancetype)initWithDict:(NSDictionary *)dict NS_DESIGNATED_INITIALIZER;
-(instancetype)init NS_UNAVAILABLE;

@property (nonatomic, strong) NSString *mPythonPath;
@end
