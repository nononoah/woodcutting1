//
//  GRPEditableTableViewCell.h
//  Grapes
//
//  Created by Noah Blake on 12/26/14.
//  Copyright (c) 2014 Woodcutting. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GRPEditableTableViewCell <NSObject>
- (void)editingEnabled:(BOOL)inEditingEnabled;
- (void)beginEditing;
@end
