//
//  Script.h
//  Requirement Editor
//
//  Created by Eddie Tuggle on 10/26/17.
//  Copyright © 2017 etbits.coms. All rights reserved.
//

#import "TestExecElement.h"

@interface Script : TestExecElement
-(instancetype)initWithDict:(NSDictionary *)dict NS_DESIGNATED_INITIALIZER;
-(instancetype)init NS_UNAVAILABLE;

@property (nonatomic,strong) NSString *arguments;
@property (nonatomic,strong) NSString *paramFile;
@property (nonatomic,strong) NSString *globalFile;
@property (nonatomic,strong) NSString *scriptRelPath;
@property (nonatomic,strong) NSString *scriptCMLoc;
@property (nonatomic,strong) NSString *baseCMLoc;
@property (nonatomic,strong) NSString *pythonPath;

@end
