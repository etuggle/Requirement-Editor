//
//  XmlParserDelegate.h
//  Requirement Editor
//
//  Created by Eddie Tuggle on 10/25/17.
//  Copyright © 2017 etbits.coms. All rights reserved.
//

#ifndef XmlParserDelegate_h
#define XmlParserDelegate_h
#import <Cocoa/Cocoa.h>
#import "Project.h"
#import "Requirement.h"
#import "Association.h"

@interface XmlParserDelegate : NSObject <NSXMLParserDelegate>
@property (nonatomic, strong) Project *mProject;

@property (nonatomic,strong) NSMutableArray *marrXMLData;
@property (nonatomic,strong) NSMutableArray *mRequirements;
@property (nonatomic,strong) NSMutableString *mstrXMLString;
@property (nonatomic,strong) NSMutableDictionary *mdictXMLPart;
@property (nonatomic,strong) NSString *mCurrentElementName;
@property (nonatomic,strong) AssociatedElement * currentElement;
@property (nonatomic,strong) Requirement *currentRequirement;
@end
#endif /* XmlParserDelegate_h */
