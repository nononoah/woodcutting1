//
//  GRPDataSifter.m
//  Grapes
//
//  Created by Noah Blake on 12/26/14.
//  Copyright (c) 2014 Woodcutting. All rights reserved.
//

#import "GRPDataSifter.h"

#import "FZCDSManager.h"

@implementation GRPDataSifter

+ (NSArray *)allWines
{
	return [self arrayForEntitiesNamed:@"Wine"];
}

+ (NSArray *)allReviews
{
	return [self arrayForEntitiesNamed:@"Review"];
}

+ (NSArray *)allUsers
{
	return [self arrayForEntitiesNamed:@"User"];
}

+ (NSArray *)arrayForEntitiesNamed:(NSString *)inString
{
	NSFetchRequest *tmpFetchRequest = [NSFetchRequest fetchRequestWithEntityName:inString];
	NSArray *rtnArray = [[FZCDSManager sharedManager].managedObjectContext executeFetchRequest:tmpFetchRequest error:nil];
	return rtnArray;
}

@end
