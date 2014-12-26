//
//  GRPReviewTextViewTableViewCell.h
//  Grapes
//
//  Created by Noah Blake on 12/26/14.
//  Copyright (c) 2014 Woodcutting. All rights reserved.
//

#import "GRPTableViewCell.h"

#import "GRPEditableTableViewCell.h"

#import "FZMessagesViewMediator.h"
#import "GRPMessagesView.h"

@interface GRPReviewTextViewTableViewCell : GRPTableViewCell <GRPEditableTableViewCell>
@property (weak, nonatomic) IBOutlet GRPMessagesView *messagesView;
@property (nonatomic, strong) FZMessagesViewMediator *messagesViewMediator;
@end
