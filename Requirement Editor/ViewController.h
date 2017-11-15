//
//  ViewController.h
//  Requirement Editor
//
//  Created by Eddie Tuggle on 10/19/17.
//  Copyright © 2017 etbits.coms. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "XmlParserDelegate.h"
#import "RequirementsDataSource.h"
#import "RequirementsViewDelegate.h"

@interface ViewController : NSViewController
@property (weak) IBOutlet NSTextField *project;
@property (weak) IBOutlet NSTextField *FileLabel;
@property (weak) IBOutlet NSTableView *reqViewCtrl;
@property (weak) IBOutlet NSTextField *numRequirements;
@property (weak) IBOutlet NSTextField *numSequences;
@property (weak) IBOutlet NSTextField *numTests;

@property (atomic, strong) XmlParserDelegate * parserDelegate;
@property (atomic, strong) RequirementsDataSource *reqDS;
@property (atomic, strong) RequirementsViewDelegate *reqDelegate;
@end

