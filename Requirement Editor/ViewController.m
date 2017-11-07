//
//  ViewController.m
//  Requirement Editor
//
//  Created by Eddie Tuggle on 10/19/17.
//  Copyright © 2017 etbits.coms. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (IBAction)foo:(NSButton *)sender {
}
 
- (IBAction) openDocument:() sender {
    NSLog(@"open document");
    NSOpenPanel* panel = [NSOpenPanel openPanel];
    
    // This method displays the panel and returns immediately.
    // The completion handler is called when the user selects an
    // item or cancels the panel.
    [panel beginWithCompletionHandler:^(NSInteger result){
        if (result == NSFileHandlingPanelOKButton) {
            NSURL*  theDoc = [[panel URLs] objectAtIndex:0];
            NSString * filePath = [theDoc path];
            
            [_FileLabel setStringValue:(filePath)];
            // Open  the document.
            //NSXMLParser *xmlparser = [[NSXMLParser alloc] initWithContentsOfURL:[NSURL URLWithString:filePath]];
            NSXMLParser *xmlparser = [[NSXMLParser alloc] initWithContentsOfURL:theDoc];
            
            _parserDelegate = [[XmlParserDelegate alloc] init];
            [xmlparser setDelegate:_parserDelegate];
            [xmlparser parse];
            
        }
        
    }];
}

- (IBAction) saveDocument:() sender {
    NSLog(@"save document");
    // create the save panel
    NSSavePanel *panel = [NSSavePanel savePanel];
    NSLog(@"blah");
    // This method displays the panel and returns immediately.
    // The completion handler is called when the user selects an
    // item or cancels the panel.
    // This method displays the panel and returns immediately.
    // The completion handler is called when the user selects an
    // item or cancels the panel.
    [panel beginWithCompletionHandler:^(NSInteger result) {
        if (result == NSFileHandlingPanelOKButton) {
            
            NSURL*  theDoc = [panel URL];
            NSString * filePath = [theDoc path];
            
            [_FileLabel setStringValue:(filePath)];
            // Open  the file and save the XML to the file.
           
            NSLog(@"open file: %@", [theDoc path]);
            
            //Project *projectToSave = [_parserDelegate getProject];
            
        }
    }];
    
}
@end
