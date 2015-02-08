//
//  GRPCarouselCollectionViewDelegate.m
//  Grapes
//
//  Created by Noah Blake on 2/8/15.
//  Copyright (c) 2015 Woodcutting. All rights reserved.
//

#import "GRPCarouselCollectionViewDelegate.h"

#import "GRPWalkthroughCollectionViewCell.h"

static NSString *const GRPWalkthroughCollectionViewCellIdentifier = @"GRPWalkthroughCollectionViewCell";

@implementation GRPCarouselViewModel
+ (instancetype)carouselViewModelWithImageURL:(NSString *)inImageURL text:(NSString *)inText
{
	GRPCarouselViewModel *rtnModel = [GRPCarouselViewModel new];
	rtnModel.imageURL = inImageURL;
	rtnModel.text = inText;
	
	return rtnModel;
}
@end

@implementation GRPCarouselCollectionViewDelegate

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	GRPWalkthroughCollectionViewCell *rtnCell = [collectionView dequeueReusableCellWithReuseIdentifier:GRPWalkthroughCollectionViewCellIdentifier forIndexPath:indexPath];
	if (indexPath.item < _dataArray.count)
	{
		GRPCarouselViewModel *tmpModel = _dataArray[indexPath.item];
		rtnCell.imageView.image = [UIImage imageNamed:tmpModel.imageURL];
		rtnCell.label.text = tmpModel.text;
	}
	
	return rtnCell;
}

@end
