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
        _mProject = [[Project alloc] initWithDict:attributeDict];
    } else if ([elementName isEqualToString:@"Requirements"]) {
        //marrXMLData = [[NSMutableArray alloc] init];
        _mRequirements = [[NSMutableArray alloc] init];
    } else if ([elementName isEqualToString:@"Coverage"]) {
        [_currentElement setMAssociations:[[NSMutableArray alloc] init]];
    } else if ([elementName isEqualToString:@"Requirement"]) {
        _currentRequirement = [[Requirement alloc] initWithDict:attributeDict];
        [_mRequirements addObject:_currentRequirement];
        _currentElement = _currentRequirement;
    } else if([elementName isEqualToString:@"Association"]) {
        // An Association element is associated with Requirement and
        // TestDefination elements.
        // Sadly, a Requirement element encloses the Association in
        // a Coverage element while a TestDefination
        // encloses the Association in a Covers element.
        
        Association *a = [[Association alloc]initWithDict:attributeDict];
        // Process the Association element for the requirment
        [_currentElement addAssociation:a];
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
        NSLog(@"%@",_currentElement);
        NSMutableArray *associations = [_currentElement getAssociations];
        unsigned long numAssociations = [associations count];
        for (int i=0; i<numAssociations; i++) {
            NSLog(@"%@", associations[i] );
        }
        
        NSLog(@"Close requirement %@",_currentElement.mName);
        _mCurrentElementName = nil;
        _currentElement = nil;
    } else if ([_mCurrentElementName isEqualToString:@"Description"]) {
        [_currentElement setMDescription:_mstrXMLString];
    } else if ([_mCurrentElementName isEqualToString:@"Project"]) {
        [_mProject setMDescription:_mstrXMLString];
    } else {
        NSLog(@"%@", elementName);
    }
    _mstrXMLString = nil;
}

@end
