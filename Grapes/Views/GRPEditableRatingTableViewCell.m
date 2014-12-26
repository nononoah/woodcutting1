//
//  GRPEditableRatingTableViewCell.m
//  Grapes
//
//  Created by Noah Blake on 12/26/14.
//  Copyright (c) 2014 Woodcutting. All rights reserved.
//

#import "GRPEditableRatingTableViewCell.h"


@interface GRPEditableRatingTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *ratingDescriptionLabel;
@end

@implementation GRPEditableRatingTableViewCell

- (void)awakeFromNib
{
	[super awakeFromNib];
	self.ratingView.editable = YES;
	__weak GRPEditableRatingTableViewCell *tmpSelf = self;
	self.ratingView.ratingDidChangeBlock =
	^(NSInteger inRating)
	{
		[tmpSelf ratingViewDidChange:inRating];
	};
	
}

- (void)updateRatingLabelForRating:(NSInteger)inRating
{
	static NSDictionary *_ratingMap = nil;
	if (!_ratingMap)
	{
		_ratingMap = @{
					   @(-1) : @"unrated",
					   @1 : @"1",
					   @2 : @"2",
					   @3 : @"3",
					   @4 : @"4",
					   @5 : @"5",
					   @6 : @"6",
					   @7 : @"7",
					   @8 : @"8",
					   @9 : @"9",
					   @10 : @"10",
					 };
	}
	self.ratingDescriptionLabel.text = _ratingMap[@(inRating)];
}

- (void)ratingViewDidChange:(NSInteger)inRating
{
	[self updateRatingLabelForRating:inRating];
	if (self.ratingDidChangeBlock)
	{
		self.ratingDidChangeBlock(inRating);
	}
}

@end
