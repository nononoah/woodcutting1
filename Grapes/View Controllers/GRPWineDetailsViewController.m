//
//  GRPWineDetailsViewController.m
//  Grapes
//
//  Created by Noah Blake on 9/7/14.
//  Copyright (c) 2014 Woodcutting. All rights reserved.
//

#import "GRPWineDetailsViewController.h"

@implementation GRPWineDetailsViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	// User is viewing a previously created wine record. Add edit button.
	if (self.wine)
	{
		self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(beginEditing)];
	}
	// User is addding a new wine in a modal context. Add save and cancel button.
	else
	{
		self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(close)];
		self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(close)];
	}
}

- (void)beginEditing
{
	
}

- (void)close
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

@end
