//
//  CountryPicker.h
//
//  Version 1.3
//
//  Created by Nick Lockwood on 25/04/2011.
//  Copyright © 2011 Nick Lockwood. All rights reserved.
//
//  Distributed under the permissive zlib License
//  Get the latest version from here:
//
//  https://github.com/nicklockwood/CountryPicker
//
//  This software is provided 'as-is', without any express or implied
//  warranty. In no event will the authors be held liable for any damages
//  arising from the use of this software.
//
//  The source code and data files in this project are the sole creation of
//  Charcoal Design and are free for use subject to the terms below. The flag
//  icons were sourced from https://github.com/koppi/iso-country-flags-svg-collection
//  and are available under a Public Domain license
//
//  Permission is granted to anyone to use this software for any purpose,
//  including commercial applications, and to alter it and redistribute it
//  freely, subject to the following restrictions:
//
//  1. The origin of this software must not be misrepresented; you must not
//     claim that you wrote the original software. If you use this software
//     in a product, an acknowledgment in the product documentation would be
//     appreciated but is not required.
//
//  2. Altered source versions must be plainly marked as such, and must not be
//     misrepresented as being the original software.
//
//  3. This notice may not be removed or altered from any source distribution.
//

#import <UIKit/UIKit.h>


@class CountryPicker;


@protocol CountryPickerDelegate <UIPickerViewDelegate>

/// This method is called whenever a country is selected in the picker.
- (void)countryPicker:(CountryPicker *)picker didSelectCountryWithName:(NSString *)name code:(NSString *)code;

@end


@interface CountryPicker : UIPickerView

/// Returns an array of all country names in alphabetical order.
+ (NSArray<NSString *> *)countryNames;

/// Returns an array of all country codes. The codes are sorted by country
/// name, and their indices match the indices of their respective country name
/// in the `countryNames`list, but note that this means that the codes
/// themselves are not sorted alphabetically.
+ (NSArray<NSString *> *)countryCodes;

/// Returns a dictionary of country names, keyed by country code.
+ (NSDictionary<NSString *, NSString *> *)countryNamesByCode;

/// Returns a dictionary of country codes, keyed by country name.
+ (NSDictionary<NSString *, NSString *> *)countryCodesByName;

/// The delegate. This implements the CountryPickerDelegate protocol,
/// and is notified when a country is selected.
@property (nonatomic, weak) id<CountryPickerDelegate> delegate;

/// The currently selected country name. This is a read-write property,
/// so it can be used to set the picker value. Setting the picker to a country
/// name that does not appear in the `countryNames` array has no effect.
@property (nonatomic, copy) NSString *selectedCountryName;

/// The currently selected country code. This is a read-write property, so it
/// can be used to set the picker value. Setting the picker to a country code
/// that does not appear in the `countryCodes` array has no effect.
@property (nonatomic, copy) NSString *selectedCountryCode;

/// This is a convenience property to set/get the selected country using a
/// locale. The picker will automatically select the correct country based on
/// the local. To default the picker to the current device locale, you can say
/// `picker.selectedLocale = [NSLocale currentLocale];`
@property (nonatomic, copy) NSLocale *selectedLocale;

/// The font used by the labels in the picker. Set this to change the font.
@property (nonatomic, copy) UIFont *labelFont;

/// These method allows you to set the current country code.
/// It works exactly like the equivalent property setter, but has an optional
/// animated parameter to make the picker scroll smoothly to the selected country.
- (void)setSelectedCountryCode:(NSString *)countryCode animated:(BOOL)animated;

/// As above, but for the selected country name.
- (void)setSelectedCountryName:(NSString *)countryName animated:(BOOL)animated;

/// As above but for the selected locale.
- (void)setSelectedLocale:(NSLocale *)locale animated:(BOOL)animated;

@end
