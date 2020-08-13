//
//  Car.h
//  RealmDB
//
//  Created by Van Khanh Vuong on 8/7/20.
//  Copyright © 2020 IMT Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm.h>

@interface Staff : RLMObject
@property (nonatomic,strong) NSString *staffID;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *email;
-(instancetype) initStaff:(NSString*)name email:(NSString*)email;

@end
RLM_ARRAY_TYPE(Staff)

@interface Queue : RLMObject
@property RLMArray<Staff *><Staff>* staff;
@end

