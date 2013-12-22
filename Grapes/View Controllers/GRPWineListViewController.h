//
//  GRPWintListViewController.h
//  Grapes
//
//  Created by Noah Blake on 12/22/13.
//  Copyright (c) 2013 Woodcutting. All rights reserved.
//

#import "GRPBaseViewController.h"

@interface GRPWineListViewController : GRPBaseViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
