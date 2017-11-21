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
    [_itemDescription setDelegate:self];
    [_typeLabel setStringValue:@""];

    
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
            Project * currentProject = _parserDelegate.project;
            NSMutableArray *requirements = currentProject.requirements;
            NSMutableArray *sequences = currentProject.testSequences;
            
            _reqDS = [[RequirementsDataSource alloc] init];
            _reqDelegate = [[RequirementsViewDelegate alloc] init];
            _testSeqDS = [[TestSequencesDataSource alloc] initWithSequences:sequences];
            _testSeqDelegate = [[TestSequenceDelegate alloc] init];
            [_testSeqDelegate setMainView:self];
            
            [_reqDS setRequirements:requirements];
            [_reqViewCtrl setDataSource:_reqDS];
            [_reqViewCtrl setDelegate:_reqDelegate];
            [_seqViewControl setDataSource:_testSeqDS];
            [_seqViewControl setDelegate:_testSeqDelegate];
            
            _project.stringValue=currentProject.mName;
            _numRequirements.stringValue = [[NSString alloc] initWithFormat:@"%lu",(unsigned long)[requirements count] ];
            _numSequences.stringValue = [[NSString alloc] initWithFormat:@"%lu",(unsigned long)[sequences count] ];
            
            int numTestDefs = 0;
            // Since each sequence may contain
            for (int i=0; i<[sequences count]; i++) {
                //numTestDefs = sequences[i]
                TestSequence *currentSequence = [sequences objectAtIndex:i];
                numTestDefs += [currentSequence.testDefinitions count];
            }
            _numTests.stringValue = [[NSString alloc] initWithFormat:@"%lu",(unsigned long)numTestDefs ];

        }
    }];
}

- (IBAction) saveDocument:() sender {
    NSLog(@"save document");
    // create the save panel
    NSSavePanel *panel = [NSSavePanel savePanel];

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
            [xmlDoc setVersion:@"1.0"];
            //[xmlDoc setDTD:(NSXMLDTD * _Nullable)]
            [xmlDoc setMIMEType:@"text/xsl"];
            [xmlDoc setURI:@"atProjectReport.xsl"];
            [xmlDoc setStandalone:YES];
            [xmlDoc setCharacterEncoding:@"UTF-8"];
            
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
                
                // A project must have a test plan section.  This section defines the actual tests
                NSXMLElement *testPlan = (NSXMLElement *)[NSXMLNode elementWithName:@"TestPlan"];
                for (int i=0; i<[projectToSave.testSequences count]; i++) {
                    TestSequence *ts = projectToSave.testSequences[i];
                    NSXMLElement *sequenceElement = [self createElement:ts :@"TestSequence"];
                    for (int j=0; j< [ts.testDefinitions count]; j++) {
                        [sequenceElement addChild:[self createTestDefinitionElement:ts.testDefinitions[j]]];
                    }
                    [testPlan addChild:sequenceElement];
                }
                [projectElement addChild:testPlan];
            }
            
            NSData *xmlData = [xmlDoc XMLDataWithOptions:NSXMLNodePrettyPrint];
            
            if (![xmlData writeToFile:filePath atomically:YES]) {
                NSBeep();
                NSLog(@"Could not write document out...");
                //return NO;
            }
        }
    }];
    
}

- (NSXMLElement *) createElement:(TestExecElement *)teElement :(NSString *)elementName {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    
    NSXMLElement *element = (NSXMLElement *)[NSXMLNode elementWithName:elementName];
    dict = [[NSMutableDictionary alloc] init];
    dict[@"dbid"] = [[NSString alloc]initWithFormat:@"%d", teElement.mDbid];
    dict[@"name"] = teElement.mName;
    dict[@"uid"] = [[NSString alloc]initWithFormat:@"%d", teElement.mUid];
    [element setAttributesWithDictionary:dict];
    
    // Each requirement should have a description
    NSXMLElement *desc = (NSXMLElement *)[NSXMLNode elementWithName:@"Description"];
    
    NSString *str = @"Please enter a description for this requirement.  This should be the requirement text.";
    if (teElement.mDescription) {
        str = teElement.mDescription;
    }
    [desc setStringValue:str];
    [element addChild:desc];
    
    return element;
}

- (NSXMLElement *) createRequirementElement:(Requirement *)req {
    
    NSXMLElement *requirementElement = [self createElement:req :@"Requirement"];
    [requirementElement addAttribute:[NSXMLNode attributeWithName:@"status" stringValue:req.mStatus]];
    
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
- (NSXMLElement *) createTestDefinitionElement:(TestDefinition *)testDef {
    
    NSXMLElement *testDefElement = [self createElement:testDef :@"TestDefinition"];
    [testDefElement addAttribute:[NSXMLNode attributeWithName:@"status" stringValue:testDef.mStatus]];

    [testDefElement addChild:[self createScript:testDef.script]];
    
    // Process the coverage for this requirement
    NSXMLElement *coverage = (NSXMLElement *)[NSXMLNode elementWithName:@"Covers"];
    for (int coverageIdx=0; coverageIdx<[testDef.mAssociations count]; coverageIdx++) {
        Association *a = testDef.mAssociations[coverageIdx];
        [coverage addChild:[self createAssociationElement:a]];
    }
    [testDefElement addChild:coverage];
    [testDefElement addChild:[self createSimpleElement:@"TestSteps" :@""]];
    [testDefElement addChild:[self createSimpleElement:@"Attachments" :@""]];
   
    return testDefElement;
}

- (NSXMLElement *) createScript:(Script *) script {
    NSXMLElement *scriptElement = [self createElement:script :@"Script"];
    [scriptElement addChild:[self createSimpleElement:@"Arguments" :script.arguments]];
    [scriptElement addChild:[self createSimpleElement:@"ParamFile" :script.paramFile]];
    [scriptElement addChild:[self createSimpleElement:@"GlobalFile" :script.globalFile]];
    [scriptElement addChild:[self createSimpleElement:@"ScriptRelPath" :script.scriptRelPath]];
    [scriptElement addChild:[self createSimpleElement:@"ScriptCMLoc" :script.scriptCMLoc]];
    [scriptElement addChild:[self createSimpleElement:@"BaseCMLoc" :script.baseCMLoc]];
    [scriptElement addChild:[self createSimpleElement:@"PythonPath" :script.pythonPath]];

    return scriptElement;
}
- (NSXMLElement *) createAssociationElement:(Association *)assoc {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];

    NSXMLElement *associationElement = (NSXMLElement *)[NSXMLNode elementWithName:@"Association"];
    dict = [[NSMutableDictionary alloc] init];
    dict[@"status"] = assoc.mStatus;
    dict[@"type"] =  assoc.mType;
    dict[@"name"] = assoc.mName;
    dict[@"ExternalID"] = assoc.mExternalId;
    
    dict[@"uid"] = [[NSString alloc]initWithFormat:@"%d", assoc.mUid];
    [associationElement setAttributesWithDictionary:dict];
    
    return associationElement;
}
- (NSXMLElement *) createSimpleElement:(NSString*)name :(NSString *)value {
    NSXMLElement *element = (NSXMLElement *)[NSXMLNode elementWithName:name];
    [element setStringValue:value];
    return element;
}

- (void) updateItem:(id)item {
    if ([item isKindOfClass:[TestSequence class]]) {
        TestSequence *ts = item;
        [self clearValues];
        [_itemName setStringValue:ts.mName];
        [_itemDescription setString:ts.mDescription];
        [_typeLabel setStringValue:@"Test Sequence"];
        
        [_itemStatus setEnabled:NO];
        [_itemArguments setEnabled:NO];
        [_itemParamFile setEnabled:NO];
        [_itemGlobalFile setEnabled:NO];
        [_itemScriptPath setEnabled:NO];
        [_itemScriptCmLoc setEnabled:NO];
        [_itemPythonPath setEnabled:NO];


        
    } else {
        TestDefinition *td = item;
        [self clearValues];
        [_itemName setStringValue:td.mName ?: @"None"];
        [_itemStatus setStringValue:td.mStatus ?: @"UNTESTED"];
        [_itemArguments setStringValue:td.script.arguments ?: @"-v"];
        [_itemParamFile setStringValue:td.script.paramFile ?:@""];
        [_itemGlobalFile setStringValue:td.script.globalFile ?:@""];
        [_itemScriptPath setStringValue:td.script.scriptRelPath ?:@""];
        [_itemScriptCmLoc setStringValue:td.script.scriptCMLoc ?:@"" ] ;
        [_itemPythonPath setStringValue:td.script.pythonPath ?:@""];
        [_itemDescription setString:td.mDescription ?:@""];
        [_typeLabel setStringValue:@"Test Definition "];
        
        [_itemStatus setEnabled:YES];
        [_itemArguments setEnabled:YES];
        [_itemParamFile setEnabled:YES];
        [_itemGlobalFile setEnabled:YES];
        [_itemScriptPath setEnabled:YES];
        [_itemScriptCmLoc setEnabled:YES];
        [_itemPythonPath setEnabled:YES];


    }
}
- (IBAction)valueChanged:(id)sender {
    [self updateItem];
}
-(void)textDidChange:(NSNotification *)notification {
    [self updateItem];
}

-(void) updateItem {
    id item = [_seqViewControl itemAtRow:[_seqViewControl selectedRow]];
    if ([item isKindOfClass:[TestSequence class]]) {
        TestSequence *ts = item;
        NSString *desc = [[NSString alloc] initWithFormat:@"%@",_itemDescription.string];
        [ts setMDescription:desc];
        [ts setMName:[_itemName stringValue]];
    } else {
        TestDefinition *td = item;
        NSString *value;

        [td setMName:[_itemName stringValue]];
        [td setMStatus:[_itemStatus stringValue]];
        [td.script setArguments:[_itemArguments stringValue]];
        [td.script setParamFile:[_itemParamFile stringValue]];
        [td.script setGlobalFile:[_itemGlobalFile stringValue]];
        [td.script setScriptRelPath:[_itemScriptPath stringValue]];
        [td.script setScriptCMLoc:[_itemScriptCmLoc stringValue]];
        [td.script setPythonPath:[_itemPythonPath stringValue]];

        value = [[NSString alloc] initWithFormat:@"%@",_itemDescription.string];
        [td setMDescription:value];
    }
    [_seqViewControl setNeedsDisplay:YES];


}

-(void) clearValues {
    [_itemName setStringValue:@""];
    [_itemStatus setStringValue:@""];
    [_itemArguments setStringValue:@""];
    [_itemParamFile setStringValue:@""];
    [_itemGlobalFile setStringValue:@""];
    [_itemScriptPath setStringValue:@""];
    [_itemScriptCmLoc setStringValue:@""];
    [_itemPythonPath setStringValue:@""];

    [_itemDescription setString:@""];


}
@end
