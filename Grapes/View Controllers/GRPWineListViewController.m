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
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addGrape)];
}

#pragma mark - UITableView dataSoource and delegate
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
	[self.navigationController pushViewController: [GRPViewControllerFactory wineDetailsViewControllerForWine:nil] animated:YES];
}

#pragma mark - Navigation actions
- (void)addGrape
{
	// TODO: Set wine, perform dynamic animation.
	UIViewController *tmpViewController = [GRPViewControllerFactory wineDetailsViewControllerForWine:nil];
	UINavigationController *tmpNavigationController = [[UINavigationController alloc] initWithRootViewController:tmpViewController];
	[self presentViewController:tmpNavigationController animated:YES completion:nil];
}
@end
