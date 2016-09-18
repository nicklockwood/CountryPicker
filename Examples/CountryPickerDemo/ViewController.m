//
//  ViewController.m
//  CountryPickerDemo
//
//  Created by Nick Lockwood on 11/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize nameLabel, codeLabel, dailCodeLabel;

- (void)countryPicker:(__unused CountryPicker *)picker didSelectCountryWithName:(NSString *)name code:(NSString *)code dailCode:(NSString *)dailCode
{
    self.nameLabel.text = name;
    self.codeLabel.text = code;
    self.dailCodeLabel.text = dailCode;
    
}

@end
