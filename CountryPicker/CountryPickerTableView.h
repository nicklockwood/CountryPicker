//
//  CountryPickerTableView.h
//  CountryPickerDemo
//
//  Created by Palaniraja on 28/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CountryPicker.h"


@protocol CountryPickerTableViewDelegate

- (void)countryPickerTableView:(UITableView *)pickerTableView didSelectCountryWithName:(NSString *)name code:(NSString *)code;

@end

@interface CountryPickerTableView : UITableView <UITableViewDelegate, UITableViewDataSource>{
    NSIndexPath *selectedIndexPath;
}



+ (NSArray *)countryNames;
+ (NSArray *)countryCodes;
+ (NSDictionary *)countryNamesByCode;
+ (NSDictionary *)countryCodesByName;

@property (nonatomic, AH_WEAK) id<CountryPickerTableViewDelegate> countrySelectionDelegate;
@property (nonatomic, copy) NSString *selectedCountryName;
@property (nonatomic, copy) NSString *selectedCountryCode;

- (void)setWithLocale:(NSLocale *)locale;

@end






