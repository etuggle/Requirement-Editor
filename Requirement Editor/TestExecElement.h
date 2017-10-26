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
    NSString *_mName;
    NSString *_mDescription;
    int _mDbid;
    int _mUid;
}
-(instancetype)initWithDict:(NSDictionary *)dict NS_DESIGNATED_INITIALIZER;
-(instancetype)init NS_UNAVAILABLE;

@property (nonatomic,strong) NSString *mName;
@property (nonatomic,strong) NSString *mDescription;
@property (nonatomic, readwrite, assign) int mDbid;
@property (nonatomic, readwrite, assign) int mUid;

@end

#endif /* TestExecElement_h */
