//
//  FractionCalculator.h
//  FractionCalculator
//
//  Created by Xander on 9/14/16.
//  Copyright © 2016 Xander. All rights reserved.
//
#import "Fraction.h"
#ifndef FractionCalculator_h
#define FractionCalculator_h

@interface FractionCalculator:NSObject
{
    NSMutableArray* operants;
    NSMutableArray* operators;
}
-(void) setup;
-(void) clear;
-(Boolean) addFraction:(Fraction*) f;
-(Boolean) addOperator:(NSString*) i;
-(Fraction*) getResult;
-(Boolean) isValid;

@end

#endif /* FractionCalculator_h */
