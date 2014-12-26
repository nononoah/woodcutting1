//
//  GRPRatingView.m
//  Grapes
//
//  Created by Noah Blake on 9/7/14.
//  Copyright (c) 2014 Woodcutting. All rights reserved.
//

#import "GRPRatingView.h"

static CGFloat const GRPGrapeViewHeight = 15.0f;

@interface GRPRatingView ()
@property (nonatomic, strong) NSArray *grapeViewArray;
@end

@implementation GRPRatingView

- (void)awakeFromNib
{
	[super awakeFromNib];
	[self drawRatings];
	[self setEditable:self.editable];
}

- (void)drawRatings
{
	NSMutableArray *tmpGrapeViewArray = [NSMutableArray new];
	for (int i = 0; i < 10; i++)
	{
		UIView *tmpGrapeView = [UIView new];
		tmpGrapeView.layer.cornerRadius = GRPGrapeViewHeight / 2.0f;
		tmpGrapeView.translatesAutoresizingMaskIntoConstraints = NO;
		[self addSubview:tmpGrapeView];
		
		[self addConstraint:[NSLayoutConstraint constraintWithItem:tmpGrapeView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:GRPGrapeViewHeight]];
		[self addConstraint:[NSLayoutConstraint constraintWithItem:tmpGrapeView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:GRPGrapeViewHeight]];
		[self addConstraint:[NSLayoutConstraint constraintWithItem:tmpGrapeView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0]];
		if (i == 0)
		{
			[self addConstraint:[NSLayoutConstraint constraintWithItem:tmpGrapeView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0]];
		}
		else
		{
			UIView *tmpPreviousGrapeView = tmpGrapeViewArray[i - 1];
			[self addConstraint:[NSLayoutConstraint constraintWithItem:tmpGrapeView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:tmpPreviousGrapeView attribute:NSLayoutAttributeRight multiplier:1.0f constant:3.0f]];
		}
		[tmpGrapeViewArray addObject:tmpGrapeView];
	}
	self.grapeViewArray = [NSArray arrayWithArray:tmpGrapeViewArray];
}

#pragma mark - External setter -
- (void)setRating:(NSInteger)inRating
{
	for (int i = 0; i < 10; i++)
	{
		UIView *tmpGrapeView = self.grapeViewArray[i];
		if (i < inRating)
		{
			tmpGrapeView.backgroundColor = [UIColor purpleColor];
		}
		else
		{
			tmpGrapeView.backgroundColor = [UIColor whiteColor];
		}
		tmpGrapeView.layer.borderWidth = 1.0f;
		tmpGrapeView.layer.borderColor = [UIColor cyanColor].CGColor;
	}
}

#pragma mark - Editing response -
- (void)setEditable:(BOOL)editable
{
	_editable = editable;
	if (editable)
	{
		int i = 1;
		for (UIView *tmpView in self.grapeViewArray)
		{
			for (UITapGestureRecognizer *tmpGestureRecognizer in tmpView.gestureRecognizers)
			{
				[tmpView removeGestureRecognizer:tmpGestureRecognizer];
			}
			UITapGestureRecognizer *tmpTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(grapeViewTapped:)];
			tmpView.tag	= i;
			[tmpView addGestureRecognizer:tmpTapGestureRecognizer];
			
			i++;
		}
	}
}

- (void)grapeViewTapped:(UITapGestureRecognizer *)inTapGestureRecognizer
{
	if (self.editable)
	{
		NSInteger tmpRating = inTapGestureRecognizer.view.tag;
		[self setRating:tmpRating];
		if (self.ratingDidChangeBlock)
		{
			self.ratingDidChangeBlock(tmpRating);
		}
	}
}


@end
