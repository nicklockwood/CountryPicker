//
//  CountryPicker.m
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

#import "CountryPicker.h"

#pragma clang diagnostic ignored "-Wselector"
#pragma clang diagnostic ignored "-Wgnu"


#import <Availability.h>
#if !__has_feature(objc_arc)
#error This class requires automatic reference counting
#endif


@interface CountryPicker () <UIPickerViewDelegate, UIPickerViewDataSource>

@end


@implementation CountryPicker

// delegate doesn't use _ prefix to avoid name clash with superclass
@synthesize delegate, labelFont = _labelFont;

+ (NSArray *)countryNames
{
    static NSArray *_countryNames = nil;
    if (!_countryNames)
    {
        _countryNames = [[[self countryNamesByCode].allValues sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] copy];
    }
    return _countryNames;
}

+ (NSArray *)countryCodes
{
    static NSArray *_countryCodes = nil;
    if (!_countryCodes)
    {
        _countryCodes = [[[self countryCodesByName] objectsForKeys:[self countryNames] notFoundMarker:@""] copy];
    }
    return _countryCodes;
}

+ (NSDictionary *)countryNamesByCode
{
    static NSDictionary *_countryNamesByCode = nil;
    if (!_countryNamesByCode)
    {
        NSMutableDictionary *namesByCode = [NSMutableDictionary dictionary];
        for (NSString *code in [NSLocale ISOCountryCodes])
        {
            NSString *countryName = [[NSLocale currentLocale] displayNameForKey:NSLocaleCountryCode value:code];

            //workaround for simulator bug
            if (!countryName)
            {
                countryName = [[NSLocale localeWithLocaleIdentifier:@"en_US"] displayNameForKey:NSLocaleCountryCode value:code];
            }
 
            namesByCode[code] = countryName ?: code;
        }
        _countryNamesByCode = [namesByCode copy];
    }
    return _countryNamesByCode;
}

+ (NSDictionary *)countryCodesByName
{
    static NSDictionary *_countryCodesByName = nil;
    if (!_countryCodesByName)
    {
        NSDictionary *countryNamesByCode = [self countryNamesByCode];
        NSMutableDictionary *codesByName = [NSMutableDictionary dictionary];
        for (NSString *code in countryNamesByCode)
        {
            codesByName[countryNamesByCode[code]] = code;
        }
        _countryCodesByName = [codesByName copy];
    }
    return _countryCodesByName;
}

- (void)setUp
{
    super.dataSource = self;
    super.delegate = self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
    {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder]))
    {
        [self setUp];
    }
    return self;
}

- (void)setDataSource:(__unused id<UIPickerViewDataSource>)dataSource
{
    //does nothing
}

- (void)setSelectedCountryCode:(NSString *)countryCode animated:(BOOL)animated
{
    NSUInteger index = [[[self class] countryCodes] indexOfObject:countryCode];
    if (index != NSNotFound)
    {
        [self selectRow:(NSInteger)index inComponent:0 animated:animated];
    }
}

- (void)setSelectedCountryCode:(NSString *)countryCode
{
    [self setSelectedCountryCode:countryCode animated:NO];
}

- (NSString *)selectedCountryCode
{
    NSUInteger index = (NSUInteger)[self selectedRowInComponent:0];
    return [[self class] countryCodes][index];
}

- (void)setSelectedCountryName:(NSString *)countryName animated:(BOOL)animated
{
    NSUInteger index = [[[self class] countryNames] indexOfObject:countryName];
    if (index != NSNotFound)
    {
        [self selectRow:(NSInteger)index inComponent:0 animated:animated];
    }
}

- (void)setSelectedCountryName:(NSString *)countryName
{
    [self setSelectedCountryName:countryName animated:NO];
}

- (NSString *)selectedCountryName
{
    NSUInteger index = (NSUInteger)[self selectedRowInComponent:0];
    return [[self class] countryNames][index];
}

- (void)setSelectedLocale:(NSLocale *)locale animated:(BOOL)animated
{
    [self setSelectedCountryCode:[locale objectForKey:NSLocaleCountryCode] animated:animated];
}

- (void)setSelectedLocale:(NSLocale *)locale
{
    [self setSelectedLocale:locale animated:NO];
}

- (NSLocale *)selectedLocale
{
    NSString *countryCode = self.selectedCountryCode;
    if (countryCode)
    {
        NSString *identifier = [NSLocale localeIdentifierFromComponents:@{NSLocaleCountryCode: countryCode}];
        return [NSLocale localeWithLocaleIdentifier:identifier];
    }
    return nil;
}

- (void)setLabelFont:(UIFont *)labelFont
{
    _labelFont = labelFont;
    [self reloadComponent:0];
}

#pragma mark -
#pragma mark UIPicker

- (NSInteger)numberOfComponentsInPickerView:(__unused UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(__unused UIPickerView *)pickerView numberOfRowsInComponent:(__unused NSInteger)component
{
    return (NSInteger)[[self class] countryCodes].count;
}

- (UIView *)pickerView:(__unused UIPickerView *)pickerView viewForRow:(NSInteger)row
          forComponent:(__unused NSInteger)component reusingView:(UIView *)view
{
    if (!view)
    {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 30)];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(35, 3, 245, 24)];
        label.backgroundColor = [UIColor clearColor];
        label.tag = 1;
        if (self.labelFont)
        {
            label.font = self.labelFont;
        }
        [view addSubview:label];
        
        UIImageView *flagView = [[UIImageView alloc] initWithFrame:CGRectMake(3, 3, 24, 24)];
        flagView.contentMode = UIViewContentModeScaleAspectFit;
        flagView.tag = 2;
        [view addSubview:flagView];
    }

    ((UILabel *)[view viewWithTag:1]).text = [[self class] countryNames][(NSUInteger)row];
    NSString *imagePath = [NSString stringWithFormat:@"CountryPicker.bundle/%@", [[self class] countryCodes][(NSUInteger) row]];
    UIImage *image;
    if ([[UIImage class] respondsToSelector:@selector(imageNamed:inBundle:compatibleWithTraitCollection:)])
    {
        image = [UIImage imageNamed:imagePath inBundle:[NSBundle bundleForClass:[CountryPicker class]] compatibleWithTraitCollection:nil];
    }
    else
    {
        image = [UIImage imageNamed:imagePath];
    }
    ((UIImageView *)[view viewWithTag:2]).image = image;
    return view;
}

- (void)pickerView:(__unused UIPickerView *)pickerView
      didSelectRow:(__unused NSInteger)row
       inComponent:(__unused NSInteger)component
{
    __strong id<CountryPickerDelegate> strongDelegate = delegate;
    [strongDelegate countryPicker:self didSelectCountryWithName:self.selectedCountryName code:self.selectedCountryCode];
}

@end
