//
//  GRPCarouselCollectionViewDelegate.h
//  Grapes
//
//  Created by Noah Blake on 2/8/15.
//  Copyright (c) 2015 Woodcutting. All rights reserved.
//

#import "FZCarouselCollectionViewDelegate.h"

@interface GRPCarouselViewModel : NSObject
@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) NSString *text;
+ (instancetype)carouselViewModelWithImageURL:(NSString *)inImageURL text:(NSString *)inText;
@end
@interface GRPCarouselCollectionViewDelegate : FZCarouselCollectionViewDelegate

@end
