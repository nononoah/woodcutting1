//
//  GRPUserHandler.m
//  
//
//  Created by Noah Blake on 12/26/14.
//
//

#import "GRPUserHandler.h"

#import "GRPDataSifter.h"
#import "FZCDSManager.h"

#import "GRPUser+GRP.h"

@implementation GRPUserHandler

+ (GRPUser *)currentUser
{
	GRPUser *rtnUser = [[GRPDataSifter allUsers] firstObject];
	if (!rtnUser)
	{
		rtnUser = (GRPUser *)[[FZCDSManager sharedManager] uniqueObjectForEntity:@"User" identifier:@"current"];
	}
	return rtnUser;
}

@end
