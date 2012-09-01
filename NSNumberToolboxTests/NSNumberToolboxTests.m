//
//  NSNumberToolboxTests.m
//  
//
//  Created by Rabe Bernd on 15.05.12.
//  Copyright (c) 2012 RABE_IT Services. All rights reserved.
//

#import "NSNumberToolboxTests.h"
#import "NSNumber+Toolbox.h"

@implementation NSNumberToolboxTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testStringFromNumberWithMinSignificantIntegerDigits
{
    NSNumber *number = [NSNumber numberWithFloat:2.12345678];
    
    NSString *result = [number stringFromNumberWithMinSignificantIntegerDigits:2];
    STAssertTrue([result isEqualToString:@"02,123"], @"result = %@", result);
}

- (void)testStringFromLocationWithKindOfDegree
{
    NSNumber *number = [NSNumber numberWithFloat:23.12345678];
    
    NSString *result = [number stringFromLocationWithKindOfDegree:KindOfLatitude];
    STAssertTrue([result isEqualToString:@"23°07'24,45''N"], @"result = %@", result);
}

- (void)testStringFromTime
{
    NSNumber *number = [NSNumber numberWithFloat:36.12345678];
    
    NSString *result = [number hourStringFromMinutes];
    STAssertTrue([result isEqualToString:@"00:36"], @"result = %@", result);
}

- (void)testLocalizedFileSizeString
{
    NSNumber *number = [NSNumber numberWithLongLong:36.12345678];
    
    NSString *result = [number localizedFileSizeString];
    STAssertTrue([result isEqualToString:@"36 bytes"], @"result = %@", result);
    
    number = [NSNumber numberWithLongLong:115.*1024.*1024.*1024. + 1.3];
    result = [number localizedFileSizeString];
    STAssertTrue([result isEqualToString:@"115 MB"], @"result = %@", result);

    number = [NSNumber numberWithLongLong:1];
    result = [number localizedFileSizeString];
    STAssertTrue([result isEqualToString:@"1 byte"], @"result = %@", result);

    number = [NSNumber numberWithLongLong:0.75*1024];
    result = [number localizedFileSizeString];
    STAssertTrue([result isEqualToString:@"768 bytes"], @"result = %@", result);

    number = [NSNumber numberWithLongLong:0.43*1024*1024];
    result = [number localizedFileSizeString];
    STAssertTrue([result isEqualToString:@"0,4 MB"], @"result = %@", result);
}

@end
