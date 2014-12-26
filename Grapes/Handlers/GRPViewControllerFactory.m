//
//  GRPViewControllerFactory.m
//  Grapes
//
//  Created by Noah Blake on 9/7/14.
//  Copyright (c) 2014 Woodcutting. All rights reserved.
//

#import "GRPViewControllerFactory.h"

#import "GRPReviewDetailsViewController.h"

#import "GRPReview+GRP.h"

@implementation GRPViewControllerFactory

+ (UIViewController *)wineDetailsViewControllerForWine:(GRPReview *)inReview
{
	GRPReviewDetailsViewController *rtnViewController = [[UIStoryboard storyboardWithName:@"WineList" bundle:nil] instantiateViewControllerWithIdentifier:@"GRPReviewDetailsViewController"];
	rtnViewController.review = inReview;
	return rtnViewController;
}

@end
