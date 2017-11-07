//
//  XmlParserDelegate.m
//  Requirement Editor
//
//  Created by Eddie Tuggle on 10/25/17.
//  Copyright © 2017 etbits.coms. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XmlParserDelegate.h"

@implementation XmlParserDelegate

- (void)parserDidStartDocument:(NSXMLParser *)parser{
    NSLog(@"File found and parsing started");
    _mstrXMLString = nil;
    
}
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString     *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict;
{
    _mCurrentElementName = elementName;
    
    if ([elementName isEqualToString:@"Project"]){
        _project = [[Project alloc] initWithDict:attributeDict];
        _topElement = _project;
    } else if ([elementName isEqualToString:@"Requirements"]) {
        //marrXMLData = [[NSMutableArray alloc] init];
        
    } else if ([elementName isEqualToString:@"Coverage"]) {
        [_currentElement setMAssociations:[[NSMutableArray alloc] init]];
    } else if ([elementName isEqualToString:@"Requirement"]) {
        _currentRequirement = [[Requirement alloc] initWithDict:attributeDict];
        [_project addRequirement:_currentRequirement];
        _currentElement = _currentRequirement;
        _topElement = _currentRequirement;
    } else if([elementName isEqualToString:@"Association"]) {
        // An Association element is associated with Requirement and
        // TestDefination elements.
        // Sadly, a Requirement element encloses the Association in
        // a Coverage element while a TestDefination
        // encloses the Association in a Covers element.
        
        Association *a = [[Association alloc]initWithDict:attributeDict];
        // Process the Association element for the requirment
        [_currentElement addAssociation:a];
    } else if ([elementName isEqualToString:@"TestPlan"]) {
        // Allocate room for Test Sequences
        [_project setTestSequences:[[NSMutableArray alloc] init]];
    } else if ([elementName isEqualToString:@"TestSequence"]) {
        // Create a sequence and add it to the project
        _currentTestSequence = [[TestSequence alloc] initWithDict:attributeDict];
        [_project addTestSequence:_currentTestSequence];
        _topElement = _currentTestSequence;
    } else if ([elementName isEqualToString:@"TestDefinition"]) {
        // Create a Test Definition and add it to the current sequence
        _currentTestDefinition = [[TestDefinition alloc] initWithDict:attributeDict];
        [_currentTestSequence addTestDefinition:_currentTestDefinition];
        _currentElement = _currentTestDefinition;
        _topElement = _currentTestSequence;
    } else if ([elementName isEqualToString:@"Script"]) {
        // Create a Script and add it to the current test definition
        _currentScript = [[Script alloc] initWithDict:attributeDict];
        [_currentTestDefinition setScript:_currentScript];
        _topElement = _currentTestSequence;
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string;
{
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (!_mstrXMLString) {
        _mstrXMLString = [[NSMutableString alloc] initWithString:string];
    }
    else {
        [_mstrXMLString appendString:string];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName;
{
    //NSLog(@"%@", elementName);
    if ([elementName isEqualToString:@"Requirement"]) {
        //NSLog(@"%@",_currentElement);
        NSMutableArray *associations = [_currentElement getAssociations];
        unsigned long numAssociations = [associations count];
        for (int i=0; i<numAssociations; i++) {
           // NSLog(@"%@", associations[i] );
        }
        
       // NSLog(@"Close requirement %@",_currentElement.mName);
        _mCurrentElementName = nil;
        _topElement = nil;
        _currentElement = nil;
    } else if ([_mCurrentElementName isEqualToString:@"Description"]) {
        NSLog(@"setting description for %@", _project.mName);
        [_topElement setMDescription:[[NSString alloc] initWithFormat:@"%@",_mstrXMLString]];
    } else if ([_mCurrentElementName isEqualToString:@"Script"]) {
        _topElement = _currentTestDefinition;
    } else if ([_mCurrentElementName isEqualToString:@"ExternalID"]) {
        [_currentRequirement setExternalId:_mstrXMLString];
    } else if ([_mCurrentElementName isEqualToString:@"ManualStatus"]) {
         [_currentRequirement setManualStatus:_mstrXMLString];
    }else if ([_mCurrentElementName isEqualToString:@"ReviewedBy"]) {
        [_currentRequirement setReviewedBy:_mstrXMLString];
    }else if ([_mCurrentElementName isEqualToString:@"AssignedTo"]) {
        [_currentRequirement setAssignedTo:_mstrXMLString];
    }else if ([_mCurrentElementName isEqualToString:@"VerificationMethod"]) {
        [_currentRequirement setVerificationMethod:_mstrXMLString];
    }else if ([_mCurrentElementName isEqualToString:@"ProjectID"]) {
        [_currentRequirement setMProjectId:[_mstrXMLString intValue]];
    } else if ([_mCurrentElementName isEqualToString:@"Arguments"]) {
        [_currentScript setArguments:_mstrXMLString];
    } else if ([_mCurrentElementName isEqualToString:@"ParamFile"]) {
        [_currentScript setParamFile:_mstrXMLString];
    } else if ([_mCurrentElementName isEqualToString:@"Globalfile"]) {
        [_currentScript setGlobalFile:_mstrXMLString];
    } else if ([_mCurrentElementName isEqualToString:@"ScriptRelPath"]) {
        [_currentScript setScriptRelPath:_mstrXMLString];
    } else if ([_mCurrentElementName isEqualToString:@"ScriptCMLoc"]) {
        [_currentScript setScriptCMLoc:_mstrXMLString];
    } else if ([_mCurrentElementName isEqualToString:@"BaseCMLoc"]) {
        [_currentScript setBaseCMLoc:_mstrXMLString];
    } else if ([_mCurrentElementName isEqualToString:@"PythonPath"]) {
        [_currentScript setPythonPath:_mstrXMLString];
    } else {
        NSLog(@"close--->%@", elementName);
    }
    _mstrXMLString = nil;
}

@end
