//
//  GRPKeyboardMediator.h
//  Grapes
//
//  Created by Noah Blake on 12/26/14.
//  Copyright (c) 2014 Woodcutting. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GRPKeyboardMediatable <NSObject>
- (UITableView *)tableView;
- (NSArray *)editableIndexPathArray;
@end

@interface GRPKeyboardMediator : NSObject

+ (instancetype)keyboardMediatorForViewController:(UIViewController <GRPKeyboardMediatable>*)inViewController;
- (void)pauseKeyboardObservation;
- (void)resumeKeyboardObservation;

@end
