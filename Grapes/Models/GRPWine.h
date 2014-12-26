//
//  GRPWine.h
//  Grapes
//
//  Created by Noah Blake on 12/26/14.
//  Copyright (c) 2014 Woodcutting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GRPReview;

@interface GRPWine : NSManagedObject

@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * wineID;
@property (nonatomic, retain) NSNumber * rating;
@property (nonatomic, retain) NSString * countryOfOrigin;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *reviews;
@end

@interface GRPWine (CoreDataGeneratedAccessors)

- (void)addReviewsObject:(GRPReview *)value;
- (void)removeReviewsObject:(GRPReview *)value;
- (void)addReviews:(NSSet *)values;
- (void)removeReviews:(NSSet *)values;

@end
