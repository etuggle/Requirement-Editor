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
            
            // temp
            
            // end temp
            
            
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
            
            Project * projectToSave = _parserDelegate.project;
           
            
            // Create the top level element
            NSXMLElement *root = (NSXMLElement *)[NSXMLNode elementWithName:@"TestExec"];
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy:D:HH:mm:ss"];
            
            dict[@"gendate"] = [dateFormatter stringFromDate:[NSDate date]];
            dict[@"version"] = @"0.3";
            [root setAttributesWithDictionary:dict];
            NSXMLDocument *xmlDoc;
            xmlDoc = [[NSXMLDocument alloc] initWithRootElement:root];
            
            // Add the project if one exists
            if (projectToSave) {
                NSXMLElement *projectElement = (NSXMLElement *)[NSXMLNode elementWithName:@"Project"];
                dict = [[NSMutableDictionary alloc] init];
                dict[@"PythonPath"] = projectToSave.mPythonPath;
                dict[@"dbid"] = [[NSString alloc]initWithFormat:@"%d", projectToSave.mDbid];
                dict[@"name"] = projectToSave.mName;
                dict[@"uid"] = [[NSString alloc]initWithFormat:@"%d", projectToSave.mUid];
                [projectElement setAttributesWithDictionary:dict];
                
                // A project will always have a description
                NSXMLElement *projectDescription = (NSXMLElement *)[NSXMLNode elementWithName:@"Description"];
                
                NSString *str = @"Please enter a description";
                if (projectToSave.mDescription) {
                    str = projectToSave.mDescription;
                }
                [projectDescription setStringValue:str];
                [projectElement addChild:projectDescription];
                [root addChild:projectElement];
                
                // A project may or may not have requirements associated but should always have a place holder for them
                NSXMLElement *requirements = (NSXMLElement *)[NSXMLNode elementWithName:@"Requirements"];
                for (int i=0; i<[projectToSave.requirements count]; i++) {
                    [requirements addChild:[self createRequirementElement:projectToSave.requirements[i]]];
                }
                [projectElement addChild:requirements];
            }
                        
            NSData *xmlData = [xmlDoc XMLDataWithOptions:NSXMLNodePrettyPrint];
            
            NSLog(@"writing xml doc");
            if (![xmlData writeToFile:filePath atomically:YES]) {
                NSBeep();
                NSLog(@"Could not write document out...");
                //return NO;
            }
            
            NSLog(@"done writing xml doc");

            
            NSLog(@"%@", xmlDoc.name);
            
        }
    }];
    
}

- (NSXMLElement *) createRequirementElement:(Requirement *)req {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    NSXMLElement *requirementElement = (NSXMLElement *)[NSXMLNode elementWithName:@"Requirement"];
    dict = [[NSMutableDictionary alloc] init];
    dict[@"status"] = req.mStatus;
    dict[@"dbid"] = [[NSString alloc]initWithFormat:@"%d", req.mDbid];
    dict[@"name"] = req.mName;
    dict[@"uid"] = [[NSString alloc]initWithFormat:@"%d", req.mUid];
    [requirementElement setAttributesWithDictionary:dict];
    // Each requirement should have a description
    NSXMLElement *desc = (NSXMLElement *)[NSXMLNode elementWithName:@"Description"];
    
    NSString *str = @"Please enter a description for this requirement.  This should be the requirement text.";
    if (req.mDescription) {
        str = req.mDescription;
    }
    [desc setStringValue:str];
    [requirementElement addChild:desc];
    
    // Process the coverage for this requirement
    NSXMLElement *coverage = (NSXMLElement *)[NSXMLNode elementWithName:@"Coverage"];
    for (int coverageIdx=0; coverageIdx<[req.mAssociations count]; coverageIdx++) {
        Association *a = req.mAssociations[coverageIdx];
        [coverage addChild:[self createAssociationElement:a]];
    }
    [requirementElement addChild:coverage];
    [requirementElement addChild:[self createSimpleElement:@"ExternalID" :req.externalId]];
    [requirementElement addChild:[self createSimpleElement:@"ManualStatus" :req.manualStatus]];
    [requirementElement addChild:[self createSimpleElement:@"ReviewedBy" :req.reviewedBy]];
    [requirementElement addChild:[self createSimpleElement:@"AssignedTo" :req.assignedTo]];
    [requirementElement addChild:[self createSimpleElement:@"VerificationMethod" :req.verificationMethod]];
    [requirementElement addChild:[self createSimpleElement:@"ProjectID" :[[NSString alloc] initWithFormat:@"%d",req.mProjectId]]];

    return requirementElement;
}

- (NSXMLElement *) createAssociationElement:(Association *)assoc {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

    NSXMLElement *associationElement = (NSXMLElement *)[NSXMLNode elementWithName:@"Association"];
    dict = [[NSMutableDictionary alloc] init];
    dict[@"status"] = assoc.mStatus;
    dict[@"type"] =  assoc.mType;
    dict[@"name"] = assoc.mName;
    dict[@"uid"] = [[NSString alloc]initWithFormat:@"%d", assoc.mUid];
    [associationElement setAttributesWithDictionary:dict];
    
    return associationElement;
}
- (NSXMLElement *) createSimpleElement:(NSString*)name :(NSString *)value {
    NSXMLElement *element = (NSXMLElement *)[NSXMLNode elementWithName:name];
    [element setStringValue:value];
    return element;
}
@end
