//
//  GRPWalkthroughViewController.m
//  Grapes
//
//  Created by Noah Blake on 2/8/15.
//  Copyright (c) 2015 Woodcutting. All rights reserved.
//

#import "GRPWalkthroughViewController.h"

#import "GRPCarouselCollectionViewDelegate.h"

@interface GRPWalkthroughViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) GRPCarouselCollectionViewDelegate *carouselCollectionViewDelegate;
@end

@implementation GRPWalkthroughViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	NSArray *tmpViewModelArray = @[[GRPCarouselViewModel carouselViewModelWithImageURL:@"placeholder.png" text:@"Welcome to Grapes, your social wine journal."],
								   [GRPCarouselViewModel carouselViewModelWithImageURL:@"placeholder.png" text:@"To add Grapes, tap the plus button in the top right corner of your screen."],
								   [GRPCarouselViewModel carouselViewModelWithImageURL:@"placeholder.png" text:@"Fill out basic information about the wine you just drank. We'll help you out where we can!"],
								   [GRPCarouselViewModel carouselViewModelWithImageURL:@"1.JPG" text:@"Actually, this isn't a walkthrough for Grapes."],
								   [GRPCarouselViewModel carouselViewModelWithImageURL:@"2.JPG" text:@"\"What is it then?\" you might ask."],
								   [GRPCarouselViewModel carouselViewModelWithImageURL:@"3.JPG" text:@"Well, Wen..."],
								   [GRPCarouselViewModel carouselViewModelWithImageURL:@"4.JPG" text:@"I love you and I'll love you until I'm dead."],
								   [GRPCarouselViewModel carouselViewModelWithImageURL:@"5.jpg" text:@"Will you marry me?"],
								   ];
	self.carouselCollectionViewDelegate = [GRPCarouselCollectionViewDelegate carouselCollectionViewDelegateForCollectionView:self.collectionView dataArray:tmpViewModelArray crankInterval:0.0f];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
