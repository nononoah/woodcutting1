//
//  GRPWintListViewController.m
//  Grapes
//
//  Created by Noah Blake on 12/22/13.
//  Copyright (c) 2013 Woodcutting. All rights reserved.
//

#import "GRPReviewListViewController.h"

#import "GRPViewControllerFactory.h"
#import "GRPUserHandler.h"
#import "FZCDSTableViewController.h"

#import "GRPReviewTableViewCell.h"

#import "GRPUser+GRP.h"
#import "GRPReview+GRP.h"
#import "GRPWine+GRP.h"

static NSString *const GRPReviewTableViewCellIdentifier = @"GRPReviewTableViewCell";

@interface GRPReviewListViewController ()
@property (strong, nonatomic) IBOutlet FZCDSTableViewController *tableViewController;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation GRPReviewListViewController
- (void)viewDidLoad
{
	[super viewDidLoad];
	self.title = @"Your Grapes";
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addReview)];
	
	self.tableView.tableFooterView = [UIView new];
	self.tableView.layoutMargins = UIEdgeInsetsZero;
	
	[self configureTableViewController];
}

- (void)configureTableViewController
{
	[self.tableViewController setObject:[GRPUserHandler currentUser] withKeyPath:@"reviews"];
	self.tableViewController.autoResize = YES;
	self.tableViewController.viewModelBuilder = [self reviewListViewModelBuilder];
	[self.tableViewController setNeedsUpdateFetchRequest];
}

- (FZViewModelBuilder *)reviewListViewModelBuilder
{
	__weak GRPReviewListViewController *tmpSelf = self;
	
	FZViewModelBuilder *rtnAdapter = [[FZViewModelBuilder alloc] init];
	rtnAdapter.cellIdentifier = GRPReviewTableViewCellIdentifier;
	rtnAdapter.cellConfigureBlock =
	^(UITableView *inTableView, UITableViewCell *inTableViewCell, NSIndexPath *inIndexPath, id inUserData)
	{
		GRPReviewTableViewCell *tmpCell = (GRPReviewTableViewCell *)inTableViewCell;
		GRPReview *tmpReview = inUserData;
		if ([tmpReview isKindOfClass:[GRPReview class]])
		{
			[tmpCell.ratingView setRating:tmpReview.rating.integerValue];
			tmpCell.titleLabel.text = tmpReview.wine.name;
			[tmpCell.wineImageView setImage:nil];
		}
	};
	rtnAdapter.cellDidSelectBlock =
	^(UITableView *inTableView, NSIndexPath *inIndexPath, id inUserData)
	{
		[inTableView deselectRowAtIndexPath:inIndexPath animated:YES];
		[tmpSelf pushToReviewDetailsForReview:inUserData];
	};
	
	return rtnAdapter;
}

#pragma mark - Navigation actions
- (void)pushToReviewDetailsForReview:(GRPReview *)inReview
{
	[self.navigationController pushViewController:[GRPViewControllerFactory reviewDetailsViewControllerForReview:inReview] animated:YES];
}

- (void)addReview
{
	// TODO: Set wine, perform dynamic animation.
	UIViewController *tmpViewController = [GRPViewControllerFactory reviewDetailsViewControllerForReview:nil];
	UINavigationController *tmpNavigationController = [[UINavigationController alloc] initWithRootViewController:tmpViewController];
	[self presentViewController:tmpNavigationController animated:YES completion:nil];
}
@end
