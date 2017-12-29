//
//  AssocRequirementDataSource.h
//  Requirement Editor
//
//  Created by Eddie Tuggle on 12/21/17.
//  Copyright © 2017 etbits.coms. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Project.h"

@interface AssocRequirementDataSource : NSObject  <NSTableViewDataSource >

@property (nonatomic, strong) Project *project;
@property (nonatomic, strong) NSMutableArray<Requirement *> *requirements;
@property (nonatomic, strong) NSMutableArray<Association *> *associations;
@end
