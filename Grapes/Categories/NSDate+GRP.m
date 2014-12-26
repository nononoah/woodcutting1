//
//  NSDate+GRP.m
//  Grapes
//
//  Created by Noah Blake on 12/26/14.
//  Copyright (c) 2014 Woodcutting. All rights reserved.
//

#import "NSDate+GRP.h"

#import <NSDate+Fuzz.h>

@implementation NSDate (GRP)

- (NSString *)reviewListDisplayString
{
	return [NSString stringWithFormat:@"%@ %i, %i", self.monthString, (int)self.day, (int)self.year];
}

@end
