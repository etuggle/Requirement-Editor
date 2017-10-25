//
//  TestExecElement.h
//  Requirement Editor
//
//  Created by Eddie Tuggle on 10/25/17.
//  Copyright © 2017 etbits.coms. All rights reserved.
//

#ifndef TestExecElement_h
#define TestExecElement_h
@interface TestExecElement : NSObject
-(instancetype)initWithDict:(NSDictionary *)dict NS_DESIGNATED_INITIALIZER;
-(instancetype)init NS_UNAVAILABLE;

@property (nonatomic,readwrite, retain) NSString *mName;
@property (nonatomic,strong) NSString *mDescription;
@property (nonatomic) int mDbId;
@property (nonatomic) int mUid;

@end

#endif /* TestExecElement_h */
