//
//  GRPRatingView.h
//  Grapes
//
//  Created by Noah Blake on 9/7/14.
//  Copyright (c) 2014 Woodcutting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GRPRatingView : UIView

- (void)setRating:(NSInteger)inRating;
@property (nonatomic, assign) BOOL editable;
@property (nonatomic, copy) void (^ratingDidChangeBlock)(NSInteger inRating);

@end
