//
//  GRPKeyboardMediator.m
//  Grapes
//
//  Created by Noah Blake on 12/26/14.
//  Copyright (c) 2014 Woodcutting. All rights reserved.
//

#import "GRPKeyboardMediator.h"

#import "FZKeyboardAppearanceEventResponder.h"

static const CGFloat GRPKeyboardAttachmentViewHeight = 44.0f;

@interface GRPKeyboardMediator()
@property (nonatomic, strong) FZKeyboardAppearanceEventResponder *keyboardAppearanceEventResponder;
@property (nonatomic, strong) GRPKeyboardAttachmentView *keyboardAttachmentView;
@property (nonatomic, weak) UIViewController <GRPKeyboardMediatable> *mediatedViewController;
@property (nonatomic, strong) UITableViewCell<GRPEditableTableViewCell> *currentlyEditingTableViewCell;
@end

@implementation GRPKeyboardMediator

+ (instancetype)keyboardMediatorForViewController:(UIViewController <GRPKeyboardMediatable>*)inViewController
{
	GRPKeyboardMediator *rtnMediator = [[self alloc] init];
	rtnMediator.mediatedViewController = inViewController;
	
	// Control toolbar
	rtnMediator.keyboardAttachmentView = [GRPKeyboardAttachmentView keyboardAttachmentViewForFrame:CGRectMake(0, 0, CGRectGetWidth(inViewController.tableView.frame), GRPKeyboardAttachmentViewHeight) responder:rtnMediator];
	rtnMediator.keyboardAttachmentView.frame = CGRectMake(0, CGRectGetMaxY(rtnMediator.mediatedViewController.view.bounds), CGRectGetWidth(rtnMediator.mediatedViewController.view.frame), GRPKeyboardAttachmentViewHeight);
	[rtnMediator.mediatedViewController.view addSubview:rtnMediator.keyboardAttachmentView];
	
	// Keyboard appearance
	rtnMediator.keyboardAppearanceEventResponder = [FZKeyboardAppearanceEventResponder keyboardAppearanceEventResponder];
	__weak GRPKeyboardMediator *tmpMediator	= rtnMediator;
	[rtnMediator.keyboardAppearanceEventResponder registerAppearanceBlock:
	^(CGRect inKeyboardFrame)
	{
		tmpMediator.keyboardAttachmentView.frame = CGRectMake(0, CGRectGetMaxY(tmpMediator.mediatedViewController.view.bounds) - CGRectGetHeight(inKeyboardFrame) - GRPKeyboardAttachmentViewHeight, CGRectGetWidth(tmpMediator.mediatedViewController.view.frame), GRPKeyboardAttachmentViewHeight);
		[tmpMediator.keyboardAttachmentView.superview bringSubviewToFront:tmpMediator.keyboardAttachmentView];
		[tmpMediator.mediatedViewController.tableView setContentInset:UIEdgeInsetsMake(0, 0, CGRectGetHeight(inKeyboardFrame) + GRPKeyboardAttachmentViewHeight, 0)];
	}
													   disappearanceBlock:
	^(CGRect inKeyboardFrame)
	{
		tmpMediator.keyboardAttachmentView.frame = CGRectMake(0, CGRectGetMaxY(tmpMediator.mediatedViewController.view.bounds), CGRectGetWidth(tmpMediator.mediatedViewController.view.frame), GRPKeyboardAttachmentViewHeight);
		[tmpMediator.mediatedViewController.tableView setContentInset:UIEdgeInsetsZero];
	}];
	[rtnMediator.keyboardAppearanceEventResponder beginObserving];
	
	return rtnMediator;
}

#pragma mark - Cell editing tracking -
- (void)setCurrentlyEditingTableViewCell:(UITableViewCell<GRPEditableTableViewCell> *)inTableViewCell
{
	_currentlyEditingTableViewCell = inTableViewCell;
	
	NSIndexPath *tmpIndexPath = [self.mediatedViewController.tableView indexPathForCell:_currentlyEditingTableViewCell];
	// Hide previous button if this is the first cell
	self.keyboardAttachmentView.previousButton.enabled = !(tmpIndexPath.row == 0);
	// Hide close button if this is the last cell
	self.keyboardAttachmentView.nextButton.enabled = ([self nextEditableIndexPathFromRow:tmpIndexPath.row] != nil);
}

- (void)previousWasTapped
{
	NSIndexPath *tmpIndexPath = [self previousEditableIndexPathFromRow:[self.mediatedViewController.tableView indexPathForCell:self.currentlyEditingTableViewCell].row];
	[self scrollToActivateCellAtIndexPath:tmpIndexPath];
}

- (void)nextWasTapped
{
	NSIndexPath *tmpIndexPath = [self nextEditableIndexPathFromRow:[self.mediatedViewController.tableView indexPathForCell:self.currentlyEditingTableViewCell].row];
	[self scrollToActivateCellAtIndexPath:tmpIndexPath];
}
- (void)scrollToActivateCellAtIndexPath:(NSIndexPath *)inIndexPath
{
	[self.mediatedViewController.tableView scrollToRowAtIndexPath:inIndexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
	UITableViewCell <GRPEditableTableViewCell> *tmpCell = (UITableViewCell <GRPEditableTableViewCell> *)[self.mediatedViewController.tableView cellForRowAtIndexPath:inIndexPath];
	[tmpCell beginEditing];
}

- (NSIndexPath *)previousEditableIndexPathFromRow:(NSInteger)inRow
{
	for (int i = 0; i < self.mediatedViewController.editableIndexPathArray.count; i++)
	{
		if (inRow == [self.mediatedViewController.editableIndexPathArray[i] row])
		{
			// Last cell. Return no index path.
			if (i == 0 || self.mediatedViewController.editableIndexPathArray.count == 1)
			{
				return nil;
			}
			else
			{
				return [NSIndexPath indexPathForItem:[self.mediatedViewController.editableIndexPathArray[i - 1] row] inSection:0];
			}
		}
	}
	return nil;
}

- (NSIndexPath *)nextEditableIndexPathFromRow:(NSInteger)inRow
{
	for (int i = 0; i < self.mediatedViewController.editableIndexPathArray.count; i++)
	{
		if (inRow == [self.mediatedViewController.editableIndexPathArray[i] row])
		{
			// Last cell. Return no index path.
			if (i == (self.mediatedViewController.editableIndexPathArray.count - 1) || self.mediatedViewController.editableIndexPathArray.count == 1)
			{
				return nil;
			}
			else
			{
				return [NSIndexPath indexPathForItem:[self.mediatedViewController.editableIndexPathArray[i + 1] row] inSection:0];
			}
		}
	}
	return nil;
}

- (void)updateKeyboardAttachment
{
	
}


#pragma mark - Keyboard observation management -
- (void)pauseKeyboardObservation
{
	[self.keyboardAppearanceEventResponder pauseObserving];
}

- (void)resumeKeyboardObservation
{
	[self.keyboardAppearanceEventResponder beginObserving];
}

- (void)dealloc
{
	[self.keyboardAppearanceEventResponder endObserving];
}

@end
