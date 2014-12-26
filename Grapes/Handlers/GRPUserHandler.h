//
//  GRPUserHandler.h
//  
//
//  Created by Noah Blake on 12/26/14.
//
//

#import <Foundation/Foundation.h>

@class GRPUser;
@interface GRPUserHandler : NSObject

+ (GRPUser *)currentUser;

@end
