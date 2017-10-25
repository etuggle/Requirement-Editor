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
@synthesize marrXMLData;
@synthesize mstrXMLString;
@synthesize mdictXMLPart;
@synthesize mRequirements;
@synthesize mCurrentElementName;
@synthesize mCurrentRequirement;

- (void)parserDidStartDocument:(NSXMLParser *)parser{
    NSLog(@"File found and parsing started");
    
}
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString     *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict;
{
    if ([elementName isEqualToString:@"Requirements"]) {
        //marrXMLData = [[NSMutableArray alloc] init];
        mRequirements = [[NSMutableArray alloc] init];
    } else if ([elementName isEqualToString:@"Coverage"]) {
        mCurrentRequirement.mAssociations = [[NSMutableArray alloc] init];
    } else if ([elementName isEqualToString:@"Requirement"]) {
        mCurrentElementName = elementName;
        mdictXMLPart = [[NSMutableDictionary alloc] init];
        mCurrentRequirement = [Requirement alloc];
        mCurrentRequirement.mDbId = [attributeDict[@"dbid"] intValue];
        mCurrentRequirement.mName = attributeDict[@"name"];
        mCurrentRequirement.mStatus = attributeDict[@"status"];
        mCurrentRequirement.mUid = [attributeDict[@"uid"] intValue];
        [mRequirements addObject:mCurrentRequirement];
        NSLog(@"%@",mCurrentRequirement);
    } else if([elementName isEqualToString:@"Association"]) {
        // An Association element is associated with Requirement and
        // TestDefination elements.
        // Sadly, a Requirement element encloses the Association in
        // a Coverage element while a TestDefination
        // encloses the Association in a Covers element.
        
        Association *a = [[Association alloc]initWithDict:attributeDict];
        if ([mCurrentElementName isEqualToString:@"Requirement"]) {
            // Process the Association element for the requirment
            Association *a = [Association alloc];
            
            [mAssociations addObject:a];
        }
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string;
{
    //NSLog(@"%@", string);
    if (!mstrXMLString) {
        mstrXMLString = [[NSMutableString alloc] initWithString:string];
    }
    else {
        [mstrXMLString appendString:string];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName;
{
    //NSLog(@"%@", elementName);
    if ([mCurrentElementName isEqualToString:(@"Requirement")]) {
        //[mdictXMLPart setObject:mstrXMLString forKey:elementName];
        if ([elementName isEqualToString:@"Requirement"]) {
        //    [marrXMLData addObject:mdictXMLPart];
            NSLog(@"Close requirement %@",mCurrentRequirement.mName);
            mCurrentElementName = nil;
            mCurrentRequirement = nil;
        } else {
            NSLog(@"%@", elementName);
        }
        
        mstrXMLString = nil;
    }
    
}

@end
