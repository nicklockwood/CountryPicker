//
//  CountryPicker.h
//
//  Version 1.2
//
//  Created by Nick Lockwood on 25/04/2011.
//  Copyright 2011 Charcoal Design
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
//  icons are the creation of FAMFAMFAM (http://www.famfamfam.com/lab/icons/flags/)
//  and are available for free use for any purpose with no requirement for attribution.
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


#import <Availability.h>
#undef weak_delegate
#if __has_feature(objc_arc_weak)
#define weak_delegate weak
#else
#define weak_delegate unsafe_unretained
#endif


#import <UIKit/UIKit.h>


@class CountryPicker;


@protocol CountryPickerDelegate <UIPickerViewDelegate>

- (void)countryPicker:(CountryPicker *)picker didSelectCountryWithName:(NSString *)name code:(NSString *)code;

@end


@interface CountryPicker : UIPickerView

+ (NSArray *)countryNames;
+ (NSArray *)countryCodes;
+ (NSDictionary *)countryNamesByCode;
+ (NSDictionary *)countryCodesByName;

@property (nonatomic, weak_delegate) id<CountryPickerDelegate> delegate;

@property (nonatomic, copy) NSString *selectedCountryName;
@property (nonatomic, copy) NSString *selectedCountryCode;
@property (nonatomic, copy) NSLocale *selectedLocale;

- (void)setSelectedCountryCode:(NSString *)countryCode animated:(BOOL)animated;
- (void)setSelectedCountryName:(NSString *)countryName animated:(BOOL)animated;
- (void)setSelectedLocale:(NSLocale *)locale animated:(BOOL)animated;

@end
