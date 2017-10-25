//
//  TestExecElement.h
//  Requirement Editor
//
//  Created by Eddie Tuggle on 10/25/17.
//  Copyright © 2017 etbits.coms. All rights reserved.
//

#ifndef TestExecElement_h
#define TestExecElement_h
@interface TestExecElement : NSObject {
    NSString *mName;
    NSString *mDescription;
    int mDbid;
    int mUid;
}
-(instancetype)initWithDict:(NSDictionary *)dict NS_DESIGNATED_INITIALIZER;
-(instancetype)init NS_UNAVAILABLE;

@property (nonatomic,readwrite, assign) NSString *mName;
@property (nonatomic,strong) NSString *mDescription;
@property (nonatomic, readwrite, assign) int mDbId;
@property (nonatomic, readwrite, assign) int mUid;

@end

#endif /* TestExecElement_h */
