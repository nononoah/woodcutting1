//
//  GRPReview.h
//  Grapes
//
//  Created by Noah Blake on 12/26/14.
//  Copyright (c) 2014 Woodcutting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class GRPUser, GRPWine;

@interface GRPReview : NSManagedObject

@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSDate * lastModified;
@property (nonatomic, retain) NSDate * created;
@property (nonatomic, retain) NSString * reviewID;
@property (nonatomic, retain) NSNumber * rating;
@property (nonatomic, retain) GRPUser *user;
@property (nonatomic, retain) GRPWine *wine;

@end
