//
//  Utility.m
//  RealmDB
//
//  Created by Van Khanh Vuong on 8/12/20.
//  Copyright © 2020 IMT Solutions. All rights reserved.
//

#import "Utility.h"

@implementation Utility
// Using NSRegularExpression

+ (BOOL) validateEmail:(NSString*) emailAddress {
    
    NSString *regExPattern = @"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}$";
    NSRegularExpression *regEx = [[NSRegularExpression alloc]
                                  initWithPattern:regExPattern
                                  options:NSRegularExpressionCaseInsensitive
                                  error:nil];
    NSUInteger regExMatches = [regEx numberOfMatchesInString:emailAddress
                                                     options:0
                                                       range:NSMakeRange(0, [emailAddress length])];
    return (regExMatches == 0) ? NO : YES ;
    
}
@end
