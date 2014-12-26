//
//  GRPDataGenerator.m
//  Grapes
//
//  Created by Noah Blake on 12/26/14.
//  Copyright (c) 2014 Woodcutting. All rights reserved.
//

#import "GRPDataGenerator.h"

#import "FZCDSManager.h"
#import "GRPDataSifter.h"
#import "GRPUserHandler.h"

#import "GRPWine+GRP.h"
#import "GRPUser+GRP.h"
#import "GRPReview+GRP.h"

@implementation GRPDataGenerator


+ (void)generateDefaultData
{
	if ([GRPDataSifter allWines].count < 1)
	{
		[self generateWines];
		[self generateReviews];
	}
}

+ (void)generateWines
{
	GRPWine *tmpWine = (GRPWine *)[[FZCDSManager sharedManager] uniqueObjectForEntity:@"Wine" identifier:@"1"];
	tmpWine.type = @"Riesling";
	tmpWine.name = @"Clean Slate";
	
	tmpWine = (GRPWine *)[[FZCDSManager sharedManager] uniqueObjectForEntity:@"Wine" identifier:@"2"];
	tmpWine.type = @"Molly Dooker";
	tmpWine.name = @"Merlot";
	
	tmpWine = (GRPWine *)[[FZCDSManager sharedManager] uniqueObjectForEntity:@"Wine" identifier:@"3"];
	tmpWine.type = @"Marietta Lot 49";
	tmpWine.name = @"Syrah";
	
	[[FZCDSManager sharedManager] save];
}

+ (void)generateReviews
{
	GRPReview *tmpReview = (GRPReview *)[[FZCDSManager sharedManager] uniqueObjectForEntity:@"Review" identifier:@"1"];
	tmpReview.text = @"Great wine, Wen loves it.";
	tmpReview.created = [NSDate date];
	tmpReview.lastModified = [NSDate date];;
	tmpReview.rating = @10;
	tmpReview.wine = (GRPWine *)[[FZCDSManager sharedManager] uniqueObjectForEntity:@"Wine" identifier:@"1"];
	tmpReview.user = [GRPUserHandler currentUser];
	
	tmpReview = (GRPReview *)[[FZCDSManager sharedManager] uniqueObjectForEntity:@"Review" identifier:@"2"];
	tmpReview.text = @"One of Noah's favorites. Flavorful and dense.";
	tmpReview.created = [NSDate date];
	tmpReview.lastModified = [NSDate date];;
	tmpReview.rating = @9;
	tmpReview.wine = (GRPWine *)[[FZCDSManager sharedManager] uniqueObjectForEntity:@"Wine" identifier:@"2"];
	tmpReview.user = [GRPUserHandler currentUser];
	
	tmpReview = (GRPReview *)[[FZCDSManager sharedManager] uniqueObjectForEntity:@"Review" identifier:@"3"];
	tmpReview.text = @"Nothing makes me remember Mom and Dad quite like Marietta.";
	tmpReview.created = [NSDate date];
	tmpReview.lastModified = [NSDate date];;
	tmpReview.rating = @8;
	tmpReview.wine = (GRPWine *)[[FZCDSManager sharedManager] uniqueObjectForEntity:@"Wine" identifier:@"3"];
	tmpReview.user = [GRPUserHandler currentUser];
	
	[[FZCDSManager sharedManager] save];
}

@end
