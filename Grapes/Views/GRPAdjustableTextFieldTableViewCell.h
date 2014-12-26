//
//  GRPAdjustableTextFieldTableViewCell.h
//  Grapes
//
//  Created by Noah Blake on 12/26/14.
//  Copyright (c) 2014 Woodcutting. All rights reserved.
//

#import "GRPTableViewCell.h"

#import "GRPEditableTableViewCell.h"

@interface GRPAdjustableTextFieldTableViewCell : GRPTableViewCell <GRPEditableTableViewCell, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *adjustableTextField;
@property (nonatomic, copy) void (^textFieldDidBeginEditingBlock)();
@property (nonatomic, copy) void (^textFieldDidChangeBlock)(NSString *inTextFieldText);
@end
