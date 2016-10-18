//
//  ViewController.m
//  FractionCalculatorApp
//
//  Created by Xander on 9/23/16.
//  Copyright © 2016 Xander. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    editNumerator = YES;
    
    // Fraction stuff setup
    editorFraction = [[Fraction alloc] init];
    [editorFraction setup];
    calculator = [[FractionCalculator alloc] init];
    [calculator setup];
    
    // Display setup
    [self refreshCalculatorDisplay];
    self.scrollHelperLabel.hidden = YES;
    [self refreshEditorDisplay];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// ==========Start of the main program=============

// -----------Fraction Editor Section-------------
// Number Pad
- (IBAction)numOne:(id)sender {
    [self editFraction:1];
}
- (IBAction)numTwo:(id)sender {
    [self editFraction:2];
}
- (IBAction)numThree:(id)sender {
    [self editFraction:3];
}
- (IBAction)numFour:(id)sender {
    [self editFraction:4];
}
- (IBAction)numFive:(id)sender {
    [self editFraction:5];
}
- (IBAction)numSix:(id)sender {
    [self editFraction:6];
}
- (IBAction)numSeven:(id)sender {
    [self editFraction:7];
}
- (IBAction)numEight:(id)sender {
    [self editFraction:8];
}
- (IBAction)numNine:(id)sender {
    [self editFraction:9];
}
- (IBAction)numZero:(id)sender {
    [self editFraction:0];
}
- (IBAction)numDelete:(id)sender {
    NSLog(@"deleting");
    if(editNumerator){
        [editorFraction setNumerator:[editorFraction numerator]/10];
    }else{
        [editorFraction setDenominator:[editorFraction denominator]/10];
    }
    [self refreshEditorDisplay];
}
- (IBAction)editorNegative:(id)sender {
    if(editNumerator){
        NSLog(@"%d",[editorFraction numerator]);
        [editorFraction setNumerator:[editorFraction numerator]*-1];
    }else{
        [editorFraction setDenominator:[editorFraction denominator]*-1];
    }
    [self refreshEditorDisplay];
}

// Helper function for number pad
-(void) editFraction:(int) input {
    if(editNumerator){
        if([editorFraction numerator]>=0)
            [editorFraction setNumerator:[editorFraction numerator]*10+input];
        else
            [editorFraction setNumerator:[editorFraction numerator]*10-input];
    }else{
        if([editorFraction denominator] >=0)
            [editorFraction setDenominator:[editorFraction denominator]*10+input];
        else
            [editorFraction setDenominator:[editorFraction denominator]*10-input];
    }
    [self refreshEditorDisplay];
}

// When user clicks the numerator or denominator.
- (IBAction)editorNumeratorAction:(id)sender {
    editNumerator = YES;
    [self refreshEditorDisplay];
}
- (IBAction)editorDenominatorAction:(id)sender {
    editNumerator = NO;
    [self refreshEditorDisplay];
}
// When user click Clear or Enter Fraction
- (IBAction)editorClear:(id)sender {
    [editorFraction setup];
    [self refreshEditorDisplay];
    
}
// When user click enter fraction
- (IBAction)enterFractionButton:(id)sender {
    if([editorFraction denominator] == 0){
        [self promptAlert:@"Denominator cannot be zero!!"];
        return;
    }
    if(![calculator addFraction:editorFraction]){
        [self promptAlert:@"ERROR: maybe you forget to enter an operator, or you are dividing by zero!"];
    }else{
        [self refreshCalculatorDisplay];
        editorFraction = [[Fraction alloc] init];
        [editorFraction setup];
        [self refreshEditorDisplay];
    }

}

//-----------Fraction Calculator Section------------------
// Calculator Buttons
- (IBAction)plusButton:(id)sender {
    if([calculator addOperator:@"+"]){
        [self refreshCalculatorDisplay];
    }else{
        [self promptAlert:@"You can't put two operators in a row! Enter a fraction"];
    }
}

- (IBAction)multiplyButton:(id)sender {
    if([calculator addOperator:@"×"]){
        [self refreshCalculatorDisplay];
    }else{
        [self promptAlert:@"You can't put two operators in a row! Enter a fraction"];
    }
}

- (IBAction)minusButton:(id)sender {
    if([calculator addOperator:@"−"]){
        [self refreshCalculatorDisplay];
    }else{
        [self promptAlert:@"You can't put two operators in a row! Enter a fraction"];
    }
}

- (IBAction)divideButton:(id)sender {
    if([calculator addOperator:@"÷"]){
        [self refreshCalculatorDisplay];
    }else{
        [self promptAlert:@"You can't put two operators in a row! Enter a fraction"];
    }
}

- (IBAction)deleteButton:(id)sender {
    if([calculator pop]){
        [self refreshCalculatorDisplay];
    }else{
        [self promptAlert:@"You have nothing to delete!"];
    }
}

- (IBAction)calculatorClear:(id)sender {
    calculator = [[FractionCalculator alloc] init];
    [calculator setup];
    [self refreshCalculatorDisplay];
}

- (IBAction)calculateButton:(id)sender {
    if([calculator isValid]){
        self.calculatorDisplay.text = [[calculator getResult] prettyPrint];
        [self refreshCalculatorDisplay];
    }else{
        [self promptAlert:@"Can not do the calculation, not enough input"];
    }
    
}

// Display methods
-(void) refreshEditorDisplay {
    if(editNumerator){
        self.editorNumerator.textColor = [UIColor blackColor];
        self.editorDenominator.textColor = [UIColor grayColor];
        self.numeratorArrow.hidden = NO;
        self.denominatorArrow.hidden = YES;
    }else{
        self.editorNumerator.textColor = [UIColor grayColor];
        self.editorDenominator.textColor = [UIColor blackColor];
        self.numeratorArrow.hidden = YES;
        self.denominatorArrow.hidden = NO;
    }
    self.editorNumerator.text = [NSString stringWithFormat:@"%d", [editorFraction numerator]];
    self.editorDenominator.text =  [NSString stringWithFormat:@"%d", [editorFraction denominator]];
}

-(void) refreshCalculatorDisplay {
    self.calculatorDisplay.text = [calculator prettyPrint];
    [self.calculatorDisplay sizeToFit];
    //float oldWidth =self.resultScroll.contentSize.width;
    self.resultScroll.contentSize=CGSizeMake(self.calculatorDisplay.intrinsicContentSize.width, 99.0F);
    if(self.calculatorDisplay.intrinsicContentSize.width > [UIScreen mainScreen].bounds.size.width){
        self.scrollHelperLabel.hidden = NO;
    }else{
        self.scrollHelperLabel.hidden = YES;
    }
}

//-----------Other Helper Function-------------

// Returns the length of a number
-(int) numDigits:(int) num {
    if(num == 0)
        return 0;
    return 1+[self numDigits:num/10];
}
// Prompt Alert to user.
-(void) promptAlert:(NSString *) al {//Copied from Apple
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Warning"
                                                                   message:al
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
