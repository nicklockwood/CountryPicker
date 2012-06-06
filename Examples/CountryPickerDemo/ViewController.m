//
//  ViewController.m
//  CountryPickerDemo
//
//  Created by Nick Lockwood on 11/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize nameLabel;
@synthesize codeLabel;

- (void)countryPicker:(CountryPicker *)picker didSelectCountryWithName:(NSString *)name code:(NSString *)code
{
    nameLabel.text = name;
    codeLabel.text = code;
}


- (void)countryPickerTableView:(UITableView *)pickerTableView didSelectCountryWithName:(NSString *)name code:(NSString *)code{
    
    nameLabel.text = name;
    codeLabel.text = code;
}
@end
