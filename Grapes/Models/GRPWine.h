//
//  GRPWine.h
//  Grapes
//
//  Created by Noah Blake on 12/22/13.
//  Copyright (c) 2013 Woodcutting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GRPWine : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *imagePath;
@property (nonatomic, strong) NSNumber *rating;
@property (nonatomic, strong) NSString *descriptionString;
@property (nonatomic, strong) NSDate *dateAdded;

@end
