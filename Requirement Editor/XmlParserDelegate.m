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
    
}
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString     *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict;
{
    _mCurrentElementName = elementName;

    if ([elementName isEqualToString:@"Requirements"]) {
        //marrXMLData = [[NSMutableArray alloc] init];
        _mRequirements = [[NSMutableArray alloc] init];
    } else if ([elementName isEqualToString:@"Coverage"]) {
        _mCurrentRequirement.mAssociations = [[NSMutableArray alloc] init];
    } else if ([elementName isEqualToString:@"Requirement"]) {
        _mCurrentRequirement = [[Requirement alloc] initWithDict:attributeDict];
        [_mRequirements addObject:_mCurrentRequirement];
    } else if([elementName isEqualToString:@"Association"]) {
        // An Association element is associated with Requirement and
        // TestDefination elements.
        // Sadly, a Requirement element encloses the Association in
        // a Coverage element while a TestDefination
        // encloses the Association in a Covers element.
        
        Association *a = [[Association alloc]initWithDict:attributeDict];
        if (_mCurrentRequirement != nil) {
            // Process the Association element for the requirment
            [_mCurrentRequirement addAssociation:a];
        } else {
            // Process the Association element for the test definition
        }
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string;
{
    NSLog(@"--->%@<---", string);
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
    if (_mCurrentRequirement != nil) {

        if ([elementName isEqualToString:@"Requirement"]) {
            NSLog(@"%@",_mCurrentRequirement);
            NSMutableArray *associations = [_mCurrentRequirement getAssociations];
            unsigned long numAssociations = [associations count];
            for (int i=0; i<numAssociations; i++) {
                NSLog(@"%@", associations[i] );
            }
            NSLog(@"Close requirement %@",_mCurrentRequirement.mName);
            _mCurrentElementName = nil;
            _mCurrentRequirement = nil;
        } else if ([_mCurrentElementName isEqualToString:@"Description"]) {
            NSString *trimmed = [_mstrXMLString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            [self setDescription:trimmed];
            NSLog(@"trimmed ->%@<-", trimmed);
            NSLog(@"nontrim ->%@<-", _mstrXMLString);
        } else {
            NSLog(@"%@", elementName);
        }
        
    }
    _mstrXMLString = nil;

}

- (void) setDescription:(NSString *)desc {
    if (_mCurrentRequirement != nil) {
        [_mCurrentRequirement setMDescription:desc];
    } else {
        // Set the description on the test def
    }
}

@end
