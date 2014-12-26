//
//  GRPKeyboardMediator.m
//  Grapes
//
//  Created by Noah Blake on 12/26/14.
//  Copyright (c) 2014 Woodcutting. All rights reserved.
//

#import "GRPKeyboardMediator.h"

#import "FZKeyboardAppearanceEventResponder.h"

@interface GRPKeyboardMediator()
@property (nonatomic, strong) FZKeyboardAppearanceEventResponder *keyboardAppearanceEventResponder;
@property (nonatomic, weak) UIViewController <GRPKeyboardMediatable> *mediatedViewController;
@end

@implementation GRPKeyboardMediator

+ (instancetype)keyboardMediatorForViewController:(UIViewController <GRPKeyboardMediatable>*)inViewController
{
	GRPKeyboardMediator *rtnMediator = [[self alloc] init];
	
	// Keyboard appearance
	rtnMediator.keyboardAppearanceEventResponder = [FZKeyboardAppearanceEventResponder keyboardAppearanceEventResponder];
	rtnMediator.mediatedViewController = inViewController;
	__weak GRPKeyboardMediator *tmpMediator	= rtnMediator;
	[rtnMediator.keyboardAppearanceEventResponder registerAppearanceBlock:
	^(CGRect inKeyboardFrame)
	{
		[tmpMediator.mediatedViewController.tableView setContentInset:UIEdgeInsetsMake(0, 0, CGRectGetHeight(inKeyboardFrame), 0)];
	}
													   disappearanceBlock:
	^(CGRect inKeyboardFrame)
	{
		[tmpMediator.mediatedViewController.tableView setContentInset:UIEdgeInsetsZero];
	}];
	[rtnMediator.keyboardAppearanceEventResponder beginObserving];
	
	// Control toolbar
	
	return rtnMediator;
}

- (void)pauseKeyboardObservation
{
	[self.keyboardAppearanceEventResponder pauseObserving];
}

- (void)resumeKeyboardObservation
{
	[self.keyboardAppearanceEventResponder beginObserving];
}

@end
