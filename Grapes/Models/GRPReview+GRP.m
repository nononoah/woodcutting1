//
//  GRPReview+GRP.m
//  Grapes
//
//  Created by Noah Blake on 12/26/14.
//  Copyright (c) 2014 Woodcutting. All rights reserved.
//

#import "GRPReview+GRP.h"

#import "NSDate+GRP.h"

@implementation GRPReview (GRP)

- (NSString *)dateString
{
	return [self.lastModified reviewListDisplayString];
}

@end
