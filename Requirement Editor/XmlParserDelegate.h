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
#import "Requirement.h"
#import "Association.h"

@interface XmlParserDelegate : NSObject <NSXMLParserDelegate>
@property (nonatomic,strong) NSMutableArray *marrXMLData;
@property (nonatomic,strong) NSMutableArray *mRequirements;
@property (nonatomic,strong) NSMutableString *mstrXMLString;
@property (nonatomic,strong) NSMutableDictionary *mdictXMLPart;
@property (nonatomic,strong) NSString *mCurrentElementName;
@property (nonatomic,strong) Requirement * mCurrentRequirement;
@end

#endif /* XmlParserDelegate_h */
