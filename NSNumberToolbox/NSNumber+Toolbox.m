//
//  NSNumber+Toolbox.m
//  NSNumberToolbox
//
//  Created by Rabe Bernd on 15.05.12.
//  Copyright (c) 2012 RABE_IT Services. All rights reserved.
//

#import "NSNumber+Toolbox.h"

@implementation NSNumber (Toolbox)

#pragma mark - Formatter

- (NSNumberFormatter *)formatterInteger
{
	NSNumberFormatter *formatterInteger = nil;
    formatterInteger = [[NSNumberFormatter alloc] init];
    [formatterInteger setLocale:[NSLocale currentLocale]];
    [formatterInteger setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatterInteger setUsesGroupingSeparator:NO];
    [formatterInteger setMinimumIntegerDigits:2];
    return formatterInteger;
}

- (NSNumberFormatter *)formatterFloat
{
	NSNumberFormatter *formatterFloat = nil;
    formatterFloat = [[NSNumberFormatter alloc] init];
    [formatterFloat setLocale:[NSLocale currentLocale]];
    [formatterFloat setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatterFloat setUsesGroupingSeparator:NO];
    [formatterFloat setMinimumFractionDigits:2];
    [formatterFloat setMaximumFractionDigits:2];
    [formatterFloat setMinimumIntegerDigits:2];
    
    return formatterFloat;
}

- (NSNumberFormatter *)nFormatterDecimal
{
    NSNumberFormatter *nFormatterLBDecimal = nil;
    
    nFormatterLBDecimal = [[NSNumberFormatter alloc] init];
    [nFormatterLBDecimal setLocale:[NSLocale currentLocale]];
    [nFormatterLBDecimal setNumberStyle:NSNumberFormatterDecimalStyle];
    [nFormatterLBDecimal setUsesGroupingSeparator:NO];
    
	return nFormatterLBDecimal;
}

#pragma mark - Conversion

- (NSString *)stringFromLocationWithKindOfDegree:(KindOfDegree)kind
{
	NSString *postfix;
	double degree = [self doubleValue];
    
    
	if(degree < 0.0) {
		degree = degree * -1;
		postfix = kind ? @"W" : @"S";
	} else
		postfix = kind ? @"E" : @"N";
	
	int value  = (int)degree;
	float minutes = (degree - value) * 60;
	float seconds = (minutes - (int)minutes) * 60;
	NSString *locValue   = [[self formatterInteger] stringFromNumber:[NSNumber numberWithInt:value]];
    NSString *locMinutes = [[self formatterInteger] stringFromNumber:[NSNumber numberWithInt:minutes]];
    NSString *locSeconds = [[self formatterFloat]   stringFromNumber:[NSNumber numberWithFloat:seconds]];
    
	NSString *degreeString = [NSString stringWithFormat:@"%@°%@'%@''%@", locValue, locMinutes, locSeconds, postfix];
	return degreeString;
}


- (NSString *)stringFromNumberWithMinSignificantIntegerDigits:(NSInteger)digits
{
    NSNumberFormatter *formatter = [self nFormatterDecimal];
    [formatter setMinimumIntegerDigits:digits];
    
    return [formatter stringFromNumber:self];
}

- (NSString *)localizedHourStringFromMinutes
{
    NSInteger time = [self integerValue];
    
    NSString *locHours   = [[NSNumber numberWithInt:time / 60] stringFromNumberWithMinSignificantIntegerDigits:2];
    NSString *locMinutes = [[NSNumber numberWithInt:time % 60] stringFromNumberWithMinSignificantIntegerDigits:2];
    
    return [NSString stringWithFormat:@"%@:%@", locHours, locMinutes];
}


#pragma mark - Localized File Size String

- (NSNumberFormatter *)decimalNumberFormatterWithFractionDigits:(NSUInteger)digits
{
    NSNumberFormatter *amountFormatter = [[NSNumberFormatter alloc] init];
    [amountFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [amountFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [amountFormatter setLocale:[NSLocale currentLocale]];
    [amountFormatter setMaximumFractionDigits:digits];
    [amountFormatter setMinimumFractionDigits:digits];
    
    return amountFormatter;
}

- (NSString *)_stringForNumber:(double)num asUnits:(NSString *)units
{
    NSString *  result;
    double      fractional;
    double      integral;
    
    fractional = modf(num, &integral);
    if ( (fractional < 0.1) || (fractional > 0.9) ) {
        result = [NSString stringWithFormat:@"%@ %@", [[self decimalNumberFormatterWithFractionDigits:0] stringFromNumber:[NSNumber numberWithDouble:round(num)]], units];
    } else {
        result = [NSString stringWithFormat:@"%@ %@", [[self decimalNumberFormatterWithFractionDigits:1] stringFromNumber:[NSNumber numberWithDouble:num]], units];
    }
    return result;
}

- (NSString *)localizedFileSizeString
{
    NSString *  result = nil;
    double  fileSize;
    unsigned long long fileSizeExact;
    
    fileSizeExact = [self longLongValue];
    
    if (fileSizeExact) {
        fileSize = (double)fileSizeExact;
        if (fileSizeExact == 1) {
            result = @"1 byte";
        } else if (fileSizeExact < 1024) {
            result = [NSString stringWithFormat:@"%@ bytes", [NSNumberFormatter localizedStringFromNumber:[NSNumber numberWithLongLong:fileSizeExact] numberStyle:NSNumberFormatterDecimalStyle]];
        } else if (fileSize < (1024.0 * 1024.0 * 0.1)) {
            result = [self _stringForNumber:fileSize / 1024.0 asUnits:@"KB"];
        } else if (fileSize < (1024.0 * 1024.0 * 1024.0 * 0.1)) {
            result = [self _stringForNumber:fileSize / (1024.0 * 1024.0) asUnits:@"MB"];
        } else {
            result = [self _stringForNumber:fileSize / (1024.0 * 1024.0 * 1024.0) asUnits:@"MB"];
        }
    }
    return result;
}

@end
