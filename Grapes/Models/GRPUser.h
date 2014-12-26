//
//  GRPUser.h
//  Grapes
//
//  Created by Noah Blake on 12/26/14.
//  Copyright (c) 2014 Woodcutting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GRPReview;

@interface GRPUser : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * userID;
@property (nonatomic, retain) NSSet *reviews;
@end

@interface GRPUser (CoreDataGeneratedAccessors)

- (void)addReviewsObject:(GRPReview *)value;
- (void)removeReviewsObject:(GRPReview *)value;
- (void)addReviews:(NSSet *)values;
- (void)removeReviews:(NSSet *)values;

@end
