//
//  Fraction.h
//  FractionCalculator
//
//  Created by Xander on 9/14/16.
//  Copyright © 2016 Xander. All rights reserved.
//

#ifndef Fraction_h
#define Fraction_h
@interface Fraction:NSObject
{
    int numerator;
    int denominator;
}
-(void) setNumerator: (int) n;
-(void) setDenominator: (int) n;
-(int) numerator;
-(int) denominator;
-(void) simplify;
-(void) reciprocal;
-(void) print;
-(Boolean) isZero;
-(void) setup;
-(NSString *) prettyPrint;
@end


#endif /* Fraction_h */
