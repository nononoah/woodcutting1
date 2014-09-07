//
//  GRPWineImageView.m
//  Grapes
//
//  Created by Noah Blake on 9/7/14.
//  Copyright (c) 2014 Woodcutting. All rights reserved.
//

#import "GRPWineImageView.h"
@interface GRPWineImageView ()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation GRPWineImageView
- (void)awakeFromNib
{
	[super awakeFromNib];
	
	self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
	[self addSubview:self.imageView];
}

- (void)setImage:(UIImage *)inImage
{
	self.imageView.image = inImage;
}

@end
