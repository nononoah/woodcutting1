//
//  GRPWineDetailsViewController.m
//  Grapes
//
//  Created by Noah Blake on 9/7/14.
//  Copyright (c) 2014 Woodcutting. All rights reserved.
//

#import "GRPReviewDetailsViewController.h"

@interface GRPReviewDetailsViewController ()
@property (nonatomic, assign) BOOL isCreatingReview;
@property (nonatomic, assign) BOOL isEditingReview;
@end

@implementation GRPReviewDetailsViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	// User is viewing a previously created wine record. Add edit button.
	if (self.review)
	{
		self.isCreatingReview = NO;
		self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(beginEditing)];
	}
	// User is addding a new wine in a modal context. Add save and cancel button.
	else
	{
		self.isCreatingReview = YES;
		self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(close)];
		self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(close)];
	}
}

- (void)beginEditing
{
	self.isEditingReview = YES;
}

- (void)close
{
	if (self.isCreatingReview)
	{
			[self dismissViewControllerAnimated:YES completion:nil];
	}
	else
	{
		[self.navigationController popViewControllerAnimated:YES];
	}
}

@end
