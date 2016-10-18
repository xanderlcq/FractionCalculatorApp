//
//  Fraction.m
//  FractionCalculator
//
//  Created by Xander on 9/14/16.
//  Copyright © 2016 Xander. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Fraction.h"

@implementation Fraction

-(void) setNumerator: (int) n
{
    numerator = n;
    
}
-(void) setDenominator: (int) n
{
    denominator = n;
}
-(int) numerator
{
    return numerator;
}

-(int) denominator
{
    return denominator;
}

-(void) simplify
{
    if(numerator == 0){
        return;
    }
    
    if(numerator < 0 && denominator < 0){
        numerator *= -1;
        denominator *= -1;
    }
    int neg = 1;
    if(numerator < 0 || denominator < 0){
        neg = -1;
        numerator = numerator < 0 ? numerator*neg : numerator;
        denominator = denominator < 0 ? denominator*neg : denominator;
    }
    int greatestCommonFactor = [self gcd:numerator second:denominator];
    numerator /=greatestCommonFactor * neg;
    denominator /= greatestCommonFactor;
    
}
// Dijkstra's Algorithm
-(int) gcd:(int) m second:(int)n
{
    if(m == n)
        return m;
    else if(m>n)
        return [self gcd:m-n second:n];
    else
        return [self gcd:m second:n-m];
    
}

-(void) reciprocal
{
    int temp = numerator;
    numerator = denominator;
    denominator = temp;
}

-(void) print
{
    if(numerator == 0){
        NSLog(@"0");
        return;
    }
    if(numerator == denominator){
        NSLog(@"1");
        return;
    }
    if(numerator == -1*denominator){
        NSLog(@"-1");
        return;
    }
    NSLog(@"%i/%i",numerator,denominator);
}

-(Boolean) isZero
{
    return numerator == 0;
}
-(void) setup
{
    numerator = 0;
    denominator = 0;
}

// Following fraction formatting code is copied from StackOverflow, http://stackoverflow.com/questions/30859359/display-fraction-number-in-uilabel


-(NSString *)superscript:(int)num {
    
    NSDictionary *superscripts = @{@0: @"\u2070", @1: @"\u00B9", @2: @"\u00B2", @3: @"\u00B3", @4: @"\u2074", @5: @"\u2075", @6: @"\u2076", @7: @"\u2077", @8: @"\u2078", @9: @"\u2079"};
    return superscripts[@(num)];
}

-(NSString *)subscript:(int)num {
    
    NSDictionary *subscripts = @{@0: @"\u2080", @1: @"\u2081", @2: @"\u2082", @3: @"\u2083", @4: @"\u2084", @5: @"\u2085", @6: @"\u2086", @7: @"\u2087", @8: @"\u2088", @9: @"\u2089"};
    return subscripts[@(num)];
}

-(NSString *)prettyPrint {
    
    NSMutableString *result = [NSMutableString string];
    if(numerator == 0){
        
        return @"0";
    }
    if(numerator == denominator){
        return @"1";
    }
    if(numerator == -1*denominator){
        return @"-1";
    }
    if(denominator == 1){
        return [NSString stringWithFormat:@"%i",numerator];
    }
    NSString *one = [NSString stringWithFormat:@"%i", numerator];
    for (int i = 0; i < one.length; i++) {
        if([[one substringWithRange:NSMakeRange(i,1)] isEqualToString:@"-"]){
            [result appendString:@"\u207B"];
            continue;
        }
        [result appendString:[self superscript:[[one substringWithRange:NSMakeRange(i, 1)] intValue]]];
    }
    [result appendString:@"/"];
    
    NSString *two = [NSString stringWithFormat:@"%i", denominator];
    for (int i = 0; i < two.length; i++) {
        if([[two substringWithRange:NSMakeRange(i,1)] isEqualToString:@"-"]){
            [result appendString:@"\u208B"];
            continue;
        }
        [result appendString:[self subscript:[[two substringWithRange:NSMakeRange(i, 1)] intValue]]];
    }
    return result;
}
@end
