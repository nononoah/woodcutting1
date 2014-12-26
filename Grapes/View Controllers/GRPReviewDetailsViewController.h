//
//  GRPWineDetailsViewController.h
//  Grapes
//
//  Created by Noah Blake on 9/7/14.
//  Copyright (c) 2014 Woodcutting. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GRPKeyboardMediator.h"

@class GRPReview;
@interface GRPReviewDetailsViewController : UIViewController <GRPKeyboardMediatable>
@property (nonatomic, strong) GRPReview *review;

@end
