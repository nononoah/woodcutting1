//
//  GRPWintListViewController.m
//  Grapes
//
//  Created by Noah Blake on 12/22/13.
//  Copyright (c) 2013 Woodcutting. All rights reserved.
//

#import "GRPWineListViewController.h"
#import "GRPViewControllerFactory.h"

#import "GRPWineListTableViewCell.h"

static NSString *const GRPWineListTableViewCellIdentifier = @"GRPWineListTableViewCell";

@interface GRPWineListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *wines;
@end

@implementation GRPWineListViewController
- (void)viewDidLoad
{
	[super viewDidLoad];
	self.title = @"Your Grapes";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	GRPWineListTableViewCell *rtnCell = [tableView dequeueReusableCellWithIdentifier:GRPWineListTableViewCellIdentifier];
	rtnCell.imageView.image = [UIImage imageNamed:@"images/wineImage.png"];
	return rtnCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	// TODO: Set wine, perform dynamic animation.
	UIViewController *tmpViewController = [GRPViewControllerFactory wineDetailsViewControllerForWine:nil];
	[self.navigationController pushViewController:tmpViewController animated:YES];
}
@end
