//
//  GRPViewControllerFactory.h
//  Grapes
//
//  Created by Noah Blake on 9/7/14.
//  Copyright (c) 2014 Woodcutting. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GRPWine;

@interface GRPViewControllerFactory : NSObject
+ (UIViewController *)wineDetailsViewControllerForWine:(GRPWine *)inWine;
@end
