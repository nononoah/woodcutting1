//
//  GRPEditableRatingTableViewCell.h
//  Grapes
//
//  Created by Noah Blake on 12/26/14.
//  Copyright (c) 2014 Woodcutting. All rights reserved.
//

#import "GRPTableViewCell.h"

#import "GRPRatingView.h"

@interface GRPEditableRatingTableViewCell : GRPTableViewCell
@property (weak, nonatomic) IBOutlet GRPRatingView *ratingView;
@property (nonatomic, copy) void (^ratingDidChangeBlock)(NSInteger inRating);
@end
