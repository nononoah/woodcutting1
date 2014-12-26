//
//  GRPReviewTextViewTableViewCell.m
//  Grapes
//
//  Created by Noah Blake on 12/26/14.
//  Copyright (c) 2014 Woodcutting. All rights reserved.
//

#import "GRPReviewTextViewTableViewCell.h"

@implementation GRPReviewTextViewTableViewCell

- (void)awakeFromNib
{
	[super awakeFromNib];
	self.messagesViewMediator = [FZMessagesViewMediator new];
	[self.messagesView connectToMediator:self.messagesViewMediator];
	self.messagesView.messagesTextView.textContainerInset = UIEdgeInsetsZero;
	self.messagesView.messagesTextView.textContainer.lineFragmentPadding = 0;
	
	self.messagesView.placeholderLabel.text = @"Enter a review.";
	self.messagesViewMediator.maximumCharacterCount = 200;
	self.messagesViewMediator.maximumVisibleLineCount = 6;
	self.messagesViewMediator.maximumLineCount = 6;
}

- (void)beginEditing
{
	[self.messagesView.messagesTextView becomeFirstResponder];
}

- (void)editingEnabled:(BOOL)inEditingEnabled
{
	self.messagesView.messagesTextView.editable = inEditingEnabled;
}

@end
