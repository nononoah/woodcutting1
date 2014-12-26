//
//  GRPWineListTableViewCell.h
//  Grapes
//
//  Created by Noah Blake on 12/22/13.
//  Copyright (c) 2013 Woodcutting. All rights reserved.
//

#import "GRPTableViewCell.h"
#import "GRPWineImageView.h"
#import "GRPRatingView.h"

@interface GRPReviewTableViewCell : GRPTableViewCell	
@property (weak, nonatomic) IBOutlet GRPWineImageView *wineImageView;
@property (weak, nonatomic) IBOutlet GRPRatingView *ratingView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end
