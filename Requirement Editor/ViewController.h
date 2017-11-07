//
//  ViewController.h
//  Requirement Editor
//
//  Created by Eddie Tuggle on 10/19/17.
//  Copyright © 2017 etbits.coms. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "XmlParserDelegate.h"

@interface ViewController : NSViewController
@property (weak) IBOutlet NSTextField *project;
@property (weak) IBOutlet NSTextField *FileLabel;
@property (atomic, strong) XmlParserDelegate * parserDelegate;
@end

