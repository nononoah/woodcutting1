//
//  GRPWineDetailsViewController.m
//  Grapes
//
//  Created by Noah Blake on 9/7/14.
//  Copyright (c) 2014 Woodcutting. All rights reserved.
//

#import "GRPReviewDetailsViewController.h"

#import "GRPAdjustableTextFieldTableViewCell.h"
#import "GRPTableView.h"

#import "FZTableViewDelegate.h"
#import "FZCDSManager.h"
#import "GRPUserHandler.h"
#import "GRPDataSifter.h"

#import "GRPReview+GRP.h"
#import "GRPWine+GRP.h"

static NSString *const GRPAdjustableTextFieldTableViewCellIdentifier = @"GRPAdjustableTextFieldTableViewCell";


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
		self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(beginEditing)];
	}
	// User is addding a new wine in a modal context. Add save and cancel button.
	else
	{
		self.isCreatingReview = YES;
		self.review = [self stagingReview];
		self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(close)];
		self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(close)];
	}
	[self prepareKeyboard];
	[self configureTableViewDelgate];
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
- (void)configureTableViewDelgate
{
	__weak GRPReviewDetailsViewController *tmpSelf = self;
	NSMutableArray *tmpCellModelArray = [NSMutableArray new];
	NSMutableArray *tmpEditableIndexPathArray = [NSMutableArray new];
	
	// Wine name
	FZTableViewCellViewModel *tmpCellModel = [self adjustableTextFieldModelWithText:tmpSelf.review.wine.name placeholder:@"Enter the wine's name" textFieldDidChangeBlock:^(NSString *inTextFieldText){[tmpSelf setReviewValue:inTextFieldText forKeyPath:@"wine.name"];}];
	[tmpCellModelArray addObject:tmpCellModel];
	[tmpEditableIndexPathArray addObject:[NSIndexPath indexPathForRow:(tmpCellModelArray.count - 1) inSection:0]];
	
	// Wine origin
	tmpCellModel = [self adjustableTextFieldModelWithText:tmpSelf.review.wine.countryOfOrigin placeholder:@"Enter the wine's origin" textFieldDidChangeBlock: ^(NSString *inTextFieldText){[tmpSelf setReviewValue:inTextFieldText forKeyPath:@"wine.countryOfOrigin"];}];
	[tmpCellModelArray addObject:tmpCellModel];
	[tmpEditableIndexPathArray addObject:[NSIndexPath indexPathForRow:(tmpCellModelArray.count - 1) inSection:0]];
	
	// Wine type
	tmpCellModel = [self adjustableTextFieldModelWithText:tmpSelf.review.wine.type placeholder:@"Enter the wine's type" textFieldDidChangeBlock: ^(NSString *inTextFieldText){[tmpSelf setReviewValue:inTextFieldText forKeyPath:@"wine.type"];}];
	[tmpCellModelArray addObject:tmpCellModel];
	[tmpEditableIndexPathArray addObject:[NSIndexPath indexPathForRow:(tmpCellModelArray.count - 1) inSection:0]];
	
	[self.tableViewDelegate setSectionModelArray:@[[FZTableViewSectionModel sectionModelWithRowModels:tmpCellModelArray]]];
	self.editableIndexPathArray = [NSArray arrayWithArray:tmpEditableIndexPathArray];
}

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
											  }
																								  didSelectBlock:
											  ^(id inAssemblyView, NSIndexPath *inIndexPath, id inUserData)
											  {
												  [inAssemblyView deselectRowAtIndexPath:inIndexPath animated:NO];
												  GRPAdjustableTextFieldTableViewCell *tmpCell = (GRPAdjustableTextFieldTableViewCell *)[inAssemblyView cellForRowAtIndexPath:inIndexPath];
												  [tmpCell.adjustableTextField becomeFirstResponder];
											  }];
	return rtnCellModel;
}

#pragma mark - Staging data creation and conversion -
- (GRPReview *)stagingReview
{
	GRPReview *rtnReview = (GRPReview *)[[FZCDSManager sharedManager] uniqueObjectForEntity:@"Review" identifier:@"staging"];
	rtnReview.wine = (GRPWine *)[[FZCDSManager sharedManager] uniqueObjectForEntity:@"Wine" identifier:@"staging"];
	
	[[FZCDSManager sharedManager] save];
	
	return rtnReview;
}

- (void)scrubStagingReview
{
	self.review.wine.name = nil;
	
}

- (void)convertReview
{
	GRPReview *tmpReview = [self copyObject:self.review ignoringKeyPath:@"reviewID" withUniqueIdentifier:[NSString stringWithFormat:@"%i", (int)[GRPDataSifter allReviews].count + 1]];
	tmpReview.wine = [self copyObject:self.review.wine ignoringKeyPath:@"wineID" withUniqueIdentifier:[NSString stringWithFormat:@"%i", (int)[GRPDataSifter allWines].count + 1]];
	tmpReview.user = [GRPUserHandler currentUser];
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
- (void)beginEditing
{
	self.isEditingReview = YES;
}

- (void)setReviewValue:(NSString *)inValue forKeyPath:(NSString *)inKeyPath
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
	
	[self enableFormSubmission:tmpFormIsValid];
}

- (void)enableFormSubmission:(BOOL)inEnableFormSubmission
{
	
}

#pragma mark - Navigation actions -
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
