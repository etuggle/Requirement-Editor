//
//  Association.h
//  Requirement Editor
//
//  Created by Eddie Tuggle on 10/25/17.
//  Copyright © 2017 etbits.coms. All rights reserved.
//

#ifndef Association_h
#define Association_h
#import <Cocoa/Cocoa.h>

@interface Association : NSObject
-(instancetype)initWithDict:(NSDictionary *)dict NS_DESIGNATED_INITIALIZER;
-(instancetype)init NS_UNAVAILABLE;

@property (nonatomic,strong) NSString *mName;
@property (nonatomic,strong)NSString *mStatus;
@property (nonatomic,strong) NSString *mType;
@property (nonatomic,strong) NSString *mExternalId;
@property (nonatomic) int mUid;
@end

#endif /* Association_h */
