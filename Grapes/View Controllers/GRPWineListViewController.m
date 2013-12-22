//
//  GRPWintListViewController.m
//  Grapes
//
//  Created by Noah Blake on 12/22/13.
//  Copyright (c) 2013 Woodcutting. All rights reserved.
//

#import "GRPWineListViewController.h"

#import "GRPWineListTableViewCell.h"

static NSString *const GRPWineListTableViewCellIdentifier = @"GRPWineListTableViewCell";

@implementation GRPWineListViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	self.title = @"Wine List";
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
@end
