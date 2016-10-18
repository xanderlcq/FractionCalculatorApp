//
//  ViewController.h
//  FractionCalculatorApp
//
//  Created by Xander on 9/23/16.
//  Copyright © 2016 Xander. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fraction.h"
#import "FractionCalculator.h"

@interface ViewController : UIViewController{
    Boolean editNumerator;
    Fraction *editorFraction;
    FractionCalculator *calculator;
}
@property (weak, nonatomic) IBOutlet UILabel *editorNumerator;
@property (weak, nonatomic) IBOutlet UILabel *editorDenominator;
@property (weak, nonatomic) IBOutlet UIScrollView *resultScroll;
@property (weak, nonatomic) IBOutlet UILabel *calculatorDisplay;
@property (weak, nonatomic) IBOutlet UILabel *scrollHelperLabel;

@property (weak, nonatomic) IBOutlet UIImageView *numeratorArrow;
@property (weak, nonatomic) IBOutlet UIImageView *denominatorArrow;

- (IBAction)numTwo:(id)sender;
- (IBAction)numOne:(id)sender;
- (IBAction)numThree:(id)sender;
- (IBAction)numFour:(id)sender;
- (IBAction)numFive:(id)sender;
- (IBAction)numSix:(id)sender;
- (IBAction)numSeven:(id)sender;
- (IBAction)numEight:(id)sender;
- (IBAction)numNine:(id)sender;
- (IBAction)numZero:(id)sender;
- (IBAction)numDelete:(id)sender;
- (IBAction)editorNumeratorAction:(id)sender;
- (IBAction)editorDenominatorAction:(id)sender;
- (IBAction)editorClear:(id)sender;
- (IBAction)editorNegative:(id)sender;

- (IBAction)plusButton:(id)sender;
- (IBAction)multiplyButton:(id)sender;
- (IBAction)minusButton:(id)sender;
- (IBAction)divideButton:(id)sender;
- (IBAction)deleteButton:(id)sender;

- (IBAction)calculatorClear:(id)sender;
- (IBAction)calculateButton:(id)sender;



@end

