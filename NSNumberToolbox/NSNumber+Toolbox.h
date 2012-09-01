//
//  NSNumber+Toolbox.h
//  NSNumberToolbox
//
//  Created by Rabe Bernd on 15.05.12.
//  Copyright (c) 2012 RABE_IT Services. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

typedef enum {
	KindOfLatitude = 0,
	KindOfLongitude
} KindOfDegree;


@interface NSNumber (Toolbox)

// Input double Output: 25°25'33'' W, 45°13'20'' N
- (NSString *)stringFromLocationWithKindOfDegree:(KindOfDegree)kind;

// Input: integer Output: hhh:mm
- (NSString *)localizedHourStringFromMinutes;

// Input: long long Output: x byte, bytes, KB, MB
- (NSString *)localizedFileSizeString;

// helper for localizedHourStringFromMinutes
// included here for testing purposes
- (NSString *)stringFromNumberWithMinSignificantIntegerDigits:(NSInteger)digits;

@end
