//
//  GRPKeyboardAttachementView.m
//  Grapes
//
//  Created by Noah Blake on 12/26/14.
//  Copyright (c) 2014 Woodcutting. All rights reserved.
//

#import "GRPKeyboardAttachementView.h"

@interface GRPKeyboardAttachmentView ()
@property (nonatomic, weak) id <GRPKeyboardAttachmentResponder> responder;
@property (nonatomic, strong) UIButton *previousButton;
@property (nonatomic, strong) UIButton *nextButton;
@end

@implementation GRPKeyboardAttachmentView

+ (instancetype)keyboardAttachmentViewForFrame:(CGRect)inFrame responder:(id <GRPKeyboardAttachmentResponder>)inResponder
{
	GRPKeyboardAttachmentView *rtnKeyboardAttachmentView = [[GRPKeyboardAttachmentView alloc] initWithFrame:inFrame];
	[rtnKeyboardAttachmentView addButtons];
	rtnKeyboardAttachmentView.responder = inResponder;
	rtnKeyboardAttachmentView.backgroundColor = [UIColor blackColor];
	return rtnKeyboardAttachmentView;
}

- (void)addButtons
{
	UIButton *tmpPreviousButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[tmpPreviousButton setTitle:@"Previous" forState:UIControlStateNormal];
	[tmpPreviousButton addTarget:self action:@selector(tappedPrevious) forControlEvents:UIControlEventTouchUpInside];
	tmpPreviousButton.translatesAutoresizingMaskIntoConstraints = NO;
	[self addSubview:tmpPreviousButton];
	
	[self addConstraint:[NSLayoutConstraint constraintWithItem:tmpPreviousButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0]];
	[self addConstraint:[NSLayoutConstraint constraintWithItem:tmpPreviousButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0]];
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[tmpPreviousButton]-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:NSDictionaryOfVariableBindings(tmpPreviousButton)]];
	
	UIButton *tmpNextButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[tmpNextButton setTitle:@"Next" forState:UIControlStateNormal];
	[tmpNextButton addTarget:self action:@selector(tappedNext) forControlEvents:UIControlEventTouchUpInside];
	tmpNextButton.translatesAutoresizingMaskIntoConstraints = NO;
	[self addSubview:tmpNextButton];
	
	[self addConstraint:[NSLayoutConstraint constraintWithItem:tmpNextButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:tmpPreviousButton attribute:NSLayoutAttributeRight multiplier:1.0f constant:0]];
	[self addConstraint:[NSLayoutConstraint constraintWithItem:tmpNextButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0f constant:0]];
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[tmpNextButton]-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:NSDictionaryOfVariableBindings(tmpNextButton)]];
}


- (void)tappedPrevious
{
	if ([self.responder respondsToSelector:@selector(previousWasTapped)])
	{
		[self.responder previousWasTapped];
	}
}

- (void)tappedNext
{
	if ([self.responder respondsToSelector:@selector(nextWasTapped)])
	{
		[self.responder nextWasTapped];
	}
}

@end
