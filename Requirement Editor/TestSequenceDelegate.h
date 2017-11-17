//
//  TestSequenceDelegate.h
//  Requirement Editor
//
//  Created by Eddie Tuggle on 11/17/17.
//  Copyright © 2017 etbits.coms. All rights reserved.
//

#ifndef _TestSequenceDelegate_
#define _TestSequenceDelegate_

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import "TestSequence.h"

@interface TestSequenceDelegate : NSObject <NSOutlineViewDelegate>

@property (atomic, strong) id mainView;
@end

#endif
