//
//  GRPAdjustableTextFieldTableViewCell.h
//  Grapes
//
//  Created by Noah Blake on 12/26/14.
//  Copyright (c) 2014 Woodcutting. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GRPEditableTableViewCell.h"

@interface GRPAdjustableTextFieldTableViewCell : UITableViewCell <GRPEditableTableViewCell>
@property (weak, nonatomic) IBOutlet UITextField *adjustableTextField;
@property (nonatomic, copy) void (^textFieldDidChangeBlock)(NSString *inTextFieldText);
@end
