//
//  GRPViewControllerFactory.m
//  Grapes
//
//  Created by Noah Blake on 9/7/14.
//  Copyright (c) 2014 Woodcutting. All rights reserved.
//

#import "GRPViewControllerFactory.h"

#import "GRPWineDetailsViewController.h"

@implementation GRPViewControllerFactory

+ (UIViewController *)wineDetailsViewControllerForWine:(GRPWine *)inWine
{
	GRPWineDetailsViewController *rtnViewController = [[UIStoryboard storyboardWithName:@"WineList" bundle:nil] instantiateViewControllerWithIdentifier:@"GRPWineDetailsViewController"];
	rtnViewController.wine = inWine;
	return rtnViewController;
}

@end
