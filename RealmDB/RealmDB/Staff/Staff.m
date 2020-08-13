//
//  Car.m
//  RealmDB
//
//  Created by Van Khanh Vuong on 8/7/20.
//  Copyright © 2020 IMT Solutions. All rights reserved.
//

#import "Staff.h"

@implementation Staff
+ (NSString *)primaryKey {
    return @"staffID";
}
-(void)Staff:(NSString* )name :(NSString* )email{
    NSUUID *uuid = [NSUUID UUID];
    self.staffID = [uuid UUIDString];
    self.name = name.self;
    self.email = email.self;
}
- (instancetype)initStaff:(NSString *)name email:(NSString *)email {
    self = [super init];
    if (self) {
        NSUUID *uuid = [NSUUID UUID];
        self.staffID = [uuid UUIDString];
        self.name = name;
        self.email = email;
    }
    return self;
}

@end
