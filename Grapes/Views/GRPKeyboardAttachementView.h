//
//  GRPKeyboardAttachementView.h
//  Grapes
//
//  Created by Noah Blake on 12/26/14.
//  Copyright (c) 2014 Woodcutting. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GRPKeyboardAttachmentResponder <NSObject>
- (void)previousWasTapped;
- (void)nextWasTapped;
@end

@interface GRPKeyboardAttachmentView : UIView

+ (instancetype)keyboardAttachmentViewForFrame:(CGRect)inFrame responder:(id <GRPKeyboardAttachmentResponder>)inResponder;

@end
