//
//  GRPWineDetailsViewController.m
//  Grapes
//
//  Created by Noah Blake on 9/7/14.
//  Copyright (c) 2014 Woodcutting. All rights reserved.
//

#import "GRPWineDetailsViewController.h"

@interface GRPWineDetailsViewController ()
@property (nonatomic, assign) BOOL isCreating;
@property (nonatomic, assign) BOOL isEditing;
@end

@implementation GRPWineDetailsViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	// User is viewing a previously created wine record. Add edit button.
	if (self.wine)
	{
		self.isCreating = NO;
		self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(beginEditing)];
	}
	// User is addding a new wine in a modal context. Add save and cancel button.
	else
	{
		self.isCreating = YES;
		self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(close)];
		self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(close)];
	}
}

- (void)beginEditing
{
	self.isEditing = YES;
}

- (void)close
{
	if (self.isCreating)
	{
			[self dismissViewControllerAnimated:YES completion:nil];
	}
	else
	{
		[self.navigationController popViewControllerAnimated:YES];
	}
}

@end
