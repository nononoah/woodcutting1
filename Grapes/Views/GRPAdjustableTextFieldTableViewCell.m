//
//  GRPAdjustableTextFieldTableViewCell.m
//  Grapes
//
//  Created by Noah Blake on 12/26/14.
//  Copyright (c) 2014 Woodcutting. All rights reserved.
//

#import "GRPAdjustableTextFieldTableViewCell.h"

@implementation GRPAdjustableTextFieldTableViewCell

- (void)editingEnabled:(BOOL)inEditingEnabled
{
	self.adjustableTextField.enabled = inEditingEnabled;
}

- (void)beginEditing
{
	self.adjustableTextField.enabled = YES;
	[self.adjustableTextField becomeFirstResponder];
}

#pragma mark - Textfield delegation -
- (IBAction)textFieldDidBeginEditing:(id)sender
{
	[self.textFieldDidBeginEditingBlock invoke];
}

- (IBAction)textFieldDidChange:(id)sender
{
	if (self.textFieldDidChangeBlock)
	{
		self.textFieldDidChangeBlock(self.adjustableTextField.text);
	}
}

- (IBAction)textFieldDidEndEditing:(id)sender
{
	if (self.textFieldDidChangeBlock)
	{
		self.textFieldDidChangeBlock(self.adjustableTextField.text);
	}
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[self.adjustableTextField resignFirstResponder];
	return NO;
}

@end
