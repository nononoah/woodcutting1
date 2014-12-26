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
