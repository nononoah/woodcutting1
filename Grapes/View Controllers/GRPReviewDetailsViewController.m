//
//  GRPWineDetailsViewController.m
//  Grapes
//
//  Created by Noah Blake on 9/7/14.
//  Copyright (c) 2014 Woodcutting. All rights reserved.
//

#import "GRPReviewDetailsViewController.h"

#import "GRPAdjustableTextFieldTableViewCell.h"
#import "GRPReviewTextViewTableViewCell.h"
#import "GRPEditableRatingTableViewCell.h"
#import "GRPTableView.h"

#import "FZTableViewDelegate.h"
#import "FZCDSManager.h"
#import "GRPUserHandler.h"
#import "GRPDataSifter.h"

#import "GRPReview+GRP.h"
#import "GRPWine+GRP.h"

static NSString *const GRPAdjustableTextFieldTableViewCellIdentifier = @"GRPAdjustableTextFieldTableViewCell";
static NSString *const GRPReviewTextViewTableViewCellIdentifier = @"GRPReviewTextViewTableViewCell";
static NSString *const GRPEditableRatingTableViewCellIdentifier = @"GRPEditableRatingTableViewCell";

@interface GRPReviewDetailsViewController ()
@property (nonatomic, assign) BOOL isCreatingReview;
@property (nonatomic, assign) BOOL isEditingReview;
@property (weak, nonatomic) IBOutlet GRPTableView *tableView;
@property (strong, nonatomic) IBOutlet FZTableViewDelegate *tableViewDelegate;
@property (nonatomic, strong) GRPKeyboardMediator *keyboardMediator;
@property (nonatomic, strong) NSArray *editableIndexPathArray;
@end

@implementation GRPReviewDetailsViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	// User is viewing a previously created wine record. Add edit button.
	if (self.review)
	{
		self.isCreatingReview = NO;
		self.isEditingReview = NO;
		self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(beginEditing)];
	}
	// User is addding a new wine in a modal context. Add save and cancel button.
	else
	{
		self.isCreatingReview = YES;
		self.isEditingReview = YES;
		self.review = [self stagingReview];
		self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(close)];
		self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save)];
	}
	[self prepareKeyboard];
	[self configureTableViewDelegate];
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	[self.keyboardMediator resumeKeyboardObservation];
	
}
- (void)viewDidDisappear:(BOOL)animated
{
	if (self.isCreatingReview)
	{
		[self scrubStagingReview];
	}
	[self.keyboardMediator pauseKeyboardObservation];
}

#pragma mark - Keyboard preparation -
- (void)prepareKeyboard
{
	self.keyboardMediator = [GRPKeyboardMediator keyboardMediatorForViewController:self];
}

#pragma mark - TableView configuration -
- (void)configureTableViewDelegate
{
	self.tableViewDelegate.autoResize = YES;
	
	__weak GRPReviewDetailsViewController *tmpSelf = self;
	NSMutableArray *tmpCellModelArray = [NSMutableArray new];
	NSMutableArray *tmpEditableIndexPathArray = [NSMutableArray new];
	
	// Wine name
	FZTableViewCellViewModel *tmpCellModel = [self adjustableTextFieldModelWithText:tmpSelf.review.wine.name placeholder:@"Enter the wine's name" textFieldDidChangeBlock:^(NSString *inTextFieldText){[tmpSelf setReviewValue:inTextFieldText forKeyPath:@"wine.name"];}];
	[tmpCellModelArray addObject:tmpCellModel];
	[tmpEditableIndexPathArray addObject:[NSIndexPath indexPathForRow:(tmpCellModelArray.count - 1) inSection:0]];
	
	// Rating
	[tmpCellModelArray addObject:[self ratingViewCellModel]];
	
	// Wine origin
	tmpCellModel = [self adjustableTextFieldModelWithText:tmpSelf.review.wine.countryOfOrigin placeholder:@"Enter the wine's origin" textFieldDidChangeBlock: ^(NSString *inTextFieldText){[tmpSelf setReviewValue:inTextFieldText forKeyPath:@"wine.countryOfOrigin"];}];
	[tmpCellModelArray addObject:tmpCellModel];
	[tmpEditableIndexPathArray addObject:[NSIndexPath indexPathForRow:(tmpCellModelArray.count - 1) inSection:0]];
	
	// Wine type
	tmpCellModel = [self adjustableTextFieldModelWithText:tmpSelf.review.wine.type placeholder:@"Enter the wine's type" textFieldDidChangeBlock:^(NSString *inTextFieldText){[tmpSelf setReviewValue:inTextFieldText forKeyPath:@"wine.type"];}];
	[tmpCellModelArray addObject:tmpCellModel];
	[tmpEditableIndexPathArray addObject:[NSIndexPath indexPathForRow:(tmpCellModelArray.count - 1) inSection:0]];
	
	// Review
	[tmpCellModelArray addObject:[self reviewTextViewCellModel]];
	[tmpEditableIndexPathArray addObject:[NSIndexPath indexPathForRow:(tmpCellModelArray.count - 1) inSection:0]];
	
	[self.tableViewDelegate setSectionModelArray:@[[FZTableViewSectionModel sectionModelWithRowModels:tmpCellModelArray]]];
	self.editableIndexPathArray = [NSArray arrayWithArray:tmpEditableIndexPathArray];
}

#pragma mark - Cell model building -
- (FZTableViewCellViewModel *)adjustableTextFieldModelWithText:(NSString *)inText placeholder:(NSString *)inPlaceholder textFieldDidChangeBlock:(void (^)(NSString *))inTextFieldDidChangeBlock
{
	__weak GRPReviewDetailsViewController *tmpSelf = self;
	FZTableViewCellViewModel *rtnCellModel = [FZTableViewCellViewModel tableViewCellViewModelWithReuseIdentifier:GRPAdjustableTextFieldTableViewCellIdentifier
																										  height:55.0f
																								  configureBlock:
											  ^(id inAssemblyView, id inCell, NSIndexPath *inIndexPath, id inUserData)
											  {
												  GRPAdjustableTextFieldTableViewCell *tmpCell = (GRPAdjustableTextFieldTableViewCell *)inCell;
												  tmpCell.adjustableTextField.text = inText.length ? inText : nil;
												  tmpCell.adjustableTextField.placeholder = inPlaceholder;
												  tmpCell.textFieldDidChangeBlock = inTextFieldDidChangeBlock;
												  __weak GRPAdjustableTextFieldTableViewCell *blkCell = tmpCell;
												  tmpCell.textFieldDidBeginEditingBlock = ^{[tmpSelf.keyboardMediator setCurrentlyEditingTableViewCell:blkCell];};
												  [tmpCell editingEnabled:tmpSelf.isEditingReview];
											  }
																								  didSelectBlock:[self didSelectBlockForEditableCell]];
	return rtnCellModel;
}

- (FZTableViewCellViewModel *)reviewTextViewCellModel
{
	__weak GRPReviewDetailsViewController *tmpSelf = self;
	FZTableViewCellViewModel *rtnCellModel = [FZTableViewCellViewModel tableViewCellViewModelWithReuseIdentifier:GRPReviewTextViewTableViewCellIdentifier
																								  configureBlock:
											  ^(id inAssemblyView, id inCell, NSIndexPath *inIndexPath, id inUserData)
											  {
												  GRPReviewTextViewTableViewCell *tmpCell = (GRPReviewTextViewTableViewCell *)inCell;
												  [tmpCell.messagesViewMediator updateForInitialTextViewText:tmpSelf.review.text];
												  __weak GRPReviewTextViewTableViewCell *blkCell = tmpCell;
												  tmpCell.messagesViewMediator.shouldBeginEditingBlock =
												  ^BOOL (UITextView *inTextView)
												  {
													  [tmpSelf.keyboardMediator setCurrentlyEditingTableViewCell:blkCell];
													  return YES;
												  };
												  tmpCell.messagesViewMediator.shouldReturnBlock =
												  ^BOOL (UITextView *inTextView)
												  {
													  [inTextView resignFirstResponder];
													  return NO;
												  };
												  
												  tmpCell.messagesViewMediator.textViewDidChangeBlock =
												  ^(NSString *inTextViewText)
												  {
													  [tmpSelf setReviewValue:inTextViewText forKeyPath:@"text"];
												  };
												  
												  tmpCell.messagesViewMediator.textViewHeightDidChangeBlock =
												  ^(UITextView *inTextView, CGFloat inHeight)
												  {
													  [tmpSelf.tableView scrollToRowAtIndexPath:inIndexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
													  [tmpSelf.tableViewDelegate resizeTableViewCellAtIndexPath:inIndexPath];
												  };
												  [tmpCell editingEnabled:tmpSelf.isEditingReview];
											  }
																								  didSelectBlock:[self didSelectBlockForEditableCell]];
	return rtnCellModel;
}

- (FZCellViewModelDidSelectBlock)didSelectBlockForEditableCell
{
	__weak GRPReviewDetailsViewController *tmpSelf = self;
	return ^(id inAssemblyView, NSIndexPath *inIndexPath, id inUserData)
		   {
			   [inAssemblyView deselectRowAtIndexPath:inIndexPath animated:NO];
			   if (tmpSelf.isEditingReview)
			   {
				   id <GRPEditableTableViewCell> tmpCell = (id <GRPEditableTableViewCell>)[inAssemblyView cellForRowAtIndexPath:inIndexPath];
				   [tmpCell beginEditing];
			   }
		   };
}

- (FZTableViewCellViewModel *)ratingViewCellModel
{
	__weak GRPReviewDetailsViewController *tmpSelf = self;
	FZTableViewCellViewModel *rtnCellModel = [FZTableViewCellViewModel tableViewCellViewModelWithReuseIdentifier:GRPEditableRatingTableViewCellIdentifier
																								  configureBlock:
											  ^(id inAssemblyView, id inCell, NSIndexPath *inIndexPath, id inUserData)
											  {
												  GRPEditableRatingTableViewCell *tmpCell = (GRPEditableRatingTableViewCell *)inCell;
												  if (tmpSelf.review.rating.integerValue == -1)
												  {
													  [tmpCell.ratingView setRating:0];
												  }
												  else
												  {
													  [tmpCell.ratingView setRating:tmpSelf.review.rating.integerValue];
												  }
												  [tmpCell updateRatingLabelForRating:tmpSelf.review.rating.integerValue];
												  tmpCell.ratingDidChangeBlock =
												  ^(NSInteger inRating)
												  {
													  [tmpSelf setReviewValue:@(inRating) forKeyPath:@"rating"];
												  };
												  [tmpCell.ratingView setEditable:tmpSelf.isEditingReview];
											  }
																								  didSelectBlock:nil];
	return rtnCellModel;
}

#pragma mark - Staging data creation and conversion -
- (GRPReview *)stagingReview
{
	GRPReview *rtnReview = (GRPReview *)[[FZCDSManager sharedManager] uniqueObjectForEntity:@"Review" identifier:@"staging"];
	rtnReview.rating = @(-1);
	rtnReview.wine = (GRPWine *)[[FZCDSManager sharedManager] uniqueObjectForEntity:@"Wine" identifier:@"staging"];
	
	[[FZCDSManager sharedManager] save];
	
	return rtnReview;
}

- (void)scrubStagingReview
{
	self.review.wine.name = nil;
	self.review.wine.countryOfOrigin = nil;
	self.review.wine.type = nil;
	self.review.text = nil;
	self.review.rating = @(-1);
}

- (void)convertReview
{
	GRPReview *tmpReview = [self copyObject:self.review ignoringKeyPath:@"reviewID" withUniqueIdentifier:[NSString stringWithFormat:@"%i", (int)[GRPDataSifter allReviews].count + 1]];
	tmpReview.wine = [self copyObject:self.review.wine ignoringKeyPath:@"wineID" withUniqueIdentifier:[NSString stringWithFormat:@"%i", (int)[GRPDataSifter allWines].count + 1]];
	tmpReview.user = [GRPUserHandler currentUser];
	tmpReview.created = [NSDate date];
	tmpReview.lastModified = [NSDate date];
	[[FZCDSManager sharedManager] save];
}

- (id)copyObject:(NSManagedObject *)inOriginalObject ignoringKeyPath:(NSString *)inKeyPathToIgnore withUniqueIdentifier:(NSString *)inUniqueIdentifier
{
	NSManagedObject *rtnObject = [[FZCDSManager sharedManager] uniqueObjectForEntity:[inOriginalObject entity].name identifier:inUniqueIdentifier];
	NSArray *tmpProperties = [[inOriginalObject entity] properties];
	for(NSAttributeDescription *tmpAttribute in tmpProperties)
	{
		if([tmpAttribute isKindOfClass:[NSAttributeDescription class]] && (![tmpAttribute.name isEqualToString:inKeyPathToIgnore]))
		{
			[rtnObject setValue:[inOriginalObject valueForKey:tmpAttribute.name] forKey:tmpAttribute.name];
		}
	}
	return rtnObject;
}

#pragma mark - Data updates -
- (void)setReviewValue:(id)inValue forKeyPath:(NSString *)inKeyPath
{
	[self.review setValue:inValue forKeyPath:inKeyPath];
	[[FZCDSManager sharedManager] save];
	[self validateForm];
}

#pragma mark - Form validation -
- (void)validateForm
{
	BOOL tmpFormIsValid = YES;
	if (!self.review.wine.name.length)
	{
		tmpFormIsValid = NO;
	}
	if (self.review.rating.integerValue == -1)
	{
		tmpFormIsValid = NO;
	}
	
	[self enableFormSubmission:tmpFormIsValid];
}

- (void)enableFormSubmission:(BOOL)inEnableFormSubmission
{
	self.navigationItem.rightBarButtonItem.enabled = inEnableFormSubmission;
}

#pragma mark - Navigation actions -
- (void)beginEditing
{
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"End Editing" style:UIBarButtonItemStylePlain target:self action:@selector(endEditing)];
	self.isEditingReview = YES;
	[self.tableView reloadData];
}

- (void)endEditing
{
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(beginEditing)];
	self.isEditingReview = NO;
	self.review.lastModified = [NSDate date];
	[self configureTableViewDelegate];
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

- (void)save
{
	if (self.isCreatingReview)
	{
		[self convertReview];
		[self close];
	}
}

@end
