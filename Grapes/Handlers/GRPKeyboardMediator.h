//
//  GRPKeyboardMediator.h
//  Grapes
//
//  Created by Noah Blake on 12/26/14.
//  Copyright (c) 2014 Woodcutting. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GRPEditableTableViewCell.h"
#import "GRPKeyboardAttachementView.h"

@protocol GRPKeyboardMediatable <NSObject>
- (UITableView *)tableView;
- (NSArray *)editableIndexPathArray;
@end

@interface GRPKeyboardMediator : NSObject <GRPKeyboardAttachmentResponder>

+ (instancetype)keyboardMediatorForViewController:(UIViewController <GRPKeyboardMediatable>*)inViewController;
- (void)setCurrentlyEditingTableViewCell:(UITableViewCell <GRPEditableTableViewCell>*)inTableViewCell;
- (void)pauseKeyboardObservation;
- (void)resumeKeyboardObservation;

@end
