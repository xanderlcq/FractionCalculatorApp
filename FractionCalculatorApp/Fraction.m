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
    int greatestCommonFactor = numerator > denominator? denominator:numerator;
    while(greatestCommonFactor > 0){
        if(numerator%greatestCommonFactor == 0 && denominator % greatestCommonFactor == 0){
            break;
        }else{
            greatestCommonFactor--;
        }
    }
    numerator /=greatestCommonFactor * neg;
    denominator /= greatestCommonFactor;
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

@end
