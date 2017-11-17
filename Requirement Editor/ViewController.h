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
#import "TestSequencesDataSource.h"
#import "TestSequenceDelegate.h"

@interface ViewController : NSViewController <NSTextViewDelegate>
-(void) updateItem:(id)item;

@property (weak) IBOutlet NSTextField *project;
@property (weak) IBOutlet NSTextField *FileLabel;
@property (weak) IBOutlet NSTableView *reqViewCtrl;
@property (weak) IBOutlet NSTextField *numRequirements;
@property (weak) IBOutlet NSTextField *numSequences;
@property (weak) IBOutlet NSTextField *numTests;
@property (weak) IBOutlet NSOutlineView *seqViewControl;

@property (weak) IBOutlet NSTextField *itemName;
@property (weak) IBOutlet NSTextField *itemStatus;
@property (weak) IBOutlet NSTextField *itemArguments;
@property (weak) IBOutlet NSTextField *itemParamFile;
@property (weak) IBOutlet NSTextField *itemGlobalFile;
@property (weak) IBOutlet NSTextField *itemScriptPath;
@property (weak) IBOutlet NSTextField *itemScriptCmLoc;
@property (weak) IBOutlet NSTextField *itemPythonPath;
@property (unsafe_unretained) IBOutlet NSTextView *itemDescription;

@property (atomic, strong) XmlParserDelegate * parserDelegate;
@property (atomic, strong) RequirementsDataSource *reqDS;
@property (atomic, strong) RequirementsViewDelegate *reqDelegate;
@property (atomic, strong) TestSequencesDataSource *testSeqDS;
@property (atomic) TestSequenceDelegate *testSeqDelegate;

@end

