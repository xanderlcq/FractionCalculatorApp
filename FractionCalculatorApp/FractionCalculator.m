//
//  FractionCalculator.m
//  FractionCalculator
//
//  Created by Xander on 9/14/16.
//  Copyright © 2016 Xander. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FractionCalculator.h"

@implementation FractionCalculator

-(void) setup
{
    operants = [[NSMutableArray alloc] init];
    operators = [[NSMutableArray alloc] init];
}

-(Boolean) addFraction:(Fraction *)f
{
    if([operants count] == [operators count]){
        if([[operators lastObject] isEqualToString:@"÷"]){
            if(![f isZero]){
                [operants addObject:f];
                return YES;
            }
        }else{
            [operants addObject:f];
            return YES;
        }
    }
    return NO;
}

-(Boolean) addOperator:(NSString*) i
{
    NSString *ops = @"+−÷×";
    if([operants count] == [operators count]+1){
        if([ops containsString:i]){
            [operators addObject:i];
            return YES;
        }
    }
    return NO;
}

-(void) clear
{
    [operators removeAllObjects];
    [operants removeAllObjects];
}


-(Boolean) isValid
{
    if([operants count] == [operators count]+1 && [operators count] != 0){
        return YES;
    }
    return NO;
}

-(Fraction*) getResult
{
    if(![self isValid]){
        return NULL;
    }
    NSLog(@"check");
    for(int i = 0; i < [operators count];i++){
        if([[operators objectAtIndex:i]  isEqual: @"×"] || [[operators objectAtIndex:i]  isEqual: @"÷"]){
            if([[operators objectAtIndex:i]  isEqual: @"×"]){
                [self multiply:[operants objectAtIndex:i] secondFraction:[operants objectAtIndex:i+1]];
                [operants removeObjectAtIndex:i+1];
                [operators removeObjectAtIndex:i];
                i--;
                continue;
            }
            if([[operators objectAtIndex:i]  isEqual: @"÷"]){
                [self divide:[operants objectAtIndex:i] secondFraction:[operants objectAtIndex:i+1]];
                [operants removeObjectAtIndex:i+1];
                [operators removeObjectAtIndex:i];
                i--;
                continue;
            }
        }
    }
    for(int i = 0; i < [operators count];i++){
        if([[operators objectAtIndex:i]  isEqual: @"+"] || [[operators objectAtIndex:i]  isEqual: @"−"]){
            if([[operators objectAtIndex:i]  isEqual: @"+"]){
                [self add:[operants objectAtIndex:i] secondFraction:[operants objectAtIndex:i+1]];
                [operants removeObjectAtIndex:i+1];
                [operators removeObjectAtIndex:i];
                i--;
                continue;
            }
            if([[operators objectAtIndex:i]  isEqual: @"−"]){
                [self minus:[operants objectAtIndex:i] secondFraction:[operants objectAtIndex:i+1]];
                [operants removeObjectAtIndex:i+1];
                [operators removeObjectAtIndex:i];
                i--;
                continue;
            }
        }
    }
    
    [[operants objectAtIndex:0] simplify];
    NSLog(@"%lu",(unsigned long)[operators count]);
    return [operants objectAtIndex:0];
}


-(void) add:(Fraction*)first secondFraction:(Fraction*)second
{
    int firstDenominator = [first denominator];
    int secondDenominator = [second denominator];
    [first setDenominator:[first denominator]*secondDenominator];
    [first setNumerator:[first numerator]*secondDenominator];
    [second setDenominator:[second denominator]*firstDenominator];
    [second setNumerator:[second numerator]*firstDenominator];
    [first setNumerator:[first numerator]+[second numerator]];
    [first simplify];
    
    
}

-(void) minus:(Fraction*)first secondFraction:(Fraction*)second
{
    int firstDenominator = [first denominator];
    int secondDenominator = [second denominator];
    [first setDenominator:[first denominator]*secondDenominator];
    [first setNumerator:[first numerator]*secondDenominator];
    [second setDenominator:[second denominator]*firstDenominator];
    [second setNumerator:[second numerator]*firstDenominator];
    [first setNumerator:[first numerator]-[second numerator]];
    [first simplify];
    
    
}

-(void) divide:(Fraction*)first secondFraction:(Fraction*)second
{
    
    
    [second reciprocal];
    [self multiply:first secondFraction:second];
    
    
}

-(void) multiply:(Fraction*)first secondFraction:(Fraction*)second
{
    [first setNumerator:[first numerator]*[second numerator]];
    [first setDenominator:[first denominator]*[second denominator]];
    [first simplify];
}
-(Boolean) pop
{
    if([operants count] ==0 )
        return NO;
    if([operants count] == [operators count]){
        [operators removeObjectAtIndex:[operants count]-1];
    }else{
        [operants removeObjectAtIndex:[operants count]-1];
    }
    return YES;
}

-(NSString *) prettyPrint
{
    NSString *output = @"";
    for(int i = 0; i < [operators count];i++){
        output = [output stringByAppendingFormat:@"%@  %@  ",[[operants objectAtIndex:i] prettyPrint],[operators objectAtIndex:i]];
    }
    if([operators count] != [operants count]){
        output = [output stringByAppendingFormat:@"%@  ",[[operants objectAtIndex:[operants count]-1] prettyPrint]];
    }
    return output;
}
@end
