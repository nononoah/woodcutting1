//
//  GRPTableView.m
//  Grapes
//
//  Created by Noah Blake on 12/26/14.
//  Copyright (c) 2014 Woodcutting. All rights reserved.
//

#import "GRPTableView.h"

@implementation GRPTableView

- (void)awakeFromNib
{
	[super awakeFromNib];
	
	self.tableFooterView = [UIView new];
	self.separatorInset = UIEdgeInsetsZero;
}
@end
