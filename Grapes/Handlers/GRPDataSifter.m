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

+ (NSArray *)wineTypes
{
	static NSArray *_wineTypeArray = nil;
	if (!_wineTypeArray)
	{
		_wineTypeArray = @[@"Cabernet Sauvignon",
						   @"Merlot",
						   @"Syrah",
						   @"Pinot Noir",
						   @"Zinfandel",
						   @"Malbec",
						   @"Dolcetto",
						   @"Sangiovese",
						   @"Red Meritage/Bordeaux Style",
						   @"Chardonnay",
						   @"Sauvignon Blanc",
						   @"Riesling",
						   @"Gewrurztraminer",
						   @"Pinot Gris",
						   @"Pinot Blanc",
						   @"Viognier",
						   @"Red Bordeaux",
						   @"White Bordeaux",
						   @"Sweet Bordeaux",
						   @"Red Burgundy",
						   @"White Burgundy",
						   @"Rhone",
						   @"Champagne",
						   @"Alsace",
						   @"Loire",
						   @"Vin de Pays",
						   @"Brunello",
						   @"Chianti",
						   @"Gavi",
						   @"Vino Nobile",
						   @"All Piedmont Reds",
						   @"Barbaresco",
						   @"Barolo",
						   @"Moscato d’Asti",
						   @"Sparkling Asti",
						   @"Piedmontese Dolcetto",
						   @"Port",
						   @"Madeira",
						   @"Rioja",
						   @"Ribera del Duero",
						   @"Navarra",
						   @"Penedes",
						   @"Cava",
						   @"Sherry",
						   @"Sake"];
	}
	return _wineTypeArray;
}

@end
