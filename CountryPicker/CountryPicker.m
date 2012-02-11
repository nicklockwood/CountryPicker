//
//  CountryPicker.m
//
//  Version 1.0.1
//
//  Created by Nick Lockwood on 25/04/2011.
//  Copyright 2011 Charcoal Design
//
//  Distributed under the permissive zlib License
//  Get the latest version from either of these locations:
//
//  http://charcoaldesign.co.uk/source/cocoa#countrypicker
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

#import "CountryPicker.h"


@interface CountryPicker () <UIPickerViewDelegate, UIPickerViewDataSource>

@end


@implementation CountryPicker

static NSArray *countryNames = nil;
static NSArray *countryCodes = nil;
static NSDictionary *countryNamesByCode = nil;
static NSDictionary *countryCodesByName = nil;

@synthesize delegate;

+ (void)initialize
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Countries" ofType:@"plist"];
    countryNamesByCode = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    NSMutableDictionary *codesByName = [NSMutableDictionary dictionary];
    for (NSString *code in [countryNamesByCode allKeys])
    {
        [codesByName setObject:code forKey:[countryNamesByCode objectForKey:code]];
    }
    countryCodesByName = [codesByName copy];
    
    NSArray *names = [countryNamesByCode allValues];
    countryNames = AH_RETAIN([names sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)]);
    
    NSMutableArray *codes = [NSMutableArray arrayWithCapacity:[names count]];
    for (NSString *name in countryNames)
    {
        [codes addObject:[countryCodesByName objectForKey:name]];
    }
    countryCodes = [codes copy];
}

+ (NSArray *)countryNames
{
    return countryNames;
}

+ (NSArray *)countryCodes
{
    return countryCodes;
}

+ (NSDictionary *)countryNamesByCode
{
    return countryNamesByCode;
}

+ (NSDictionary *)countryCodesByName
{
    return countryCodesByName;
}

- (void)setup
{
    [super setDataSource:self];
    [super setDelegate:self];
}

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
    {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder]))
    {
        [self setup];
    }
    return self;
}

- (void)setWithLocale:(NSLocale *)locale
{
    self.selectedCountryCode = [locale objectForKey:NSLocaleCountryCode];
}

- (void)setDataSource:(id<UIPickerViewDataSource>)dataSource
{
    //does nothing
}

- (void)setSelectedCountryCode:(NSString *)countryCode
{
    NSInteger index = [countryCodes indexOfObject:countryCode];
    if (index != NSNotFound)
    {
        [self selectRow:index inComponent:0 animated:NO];
    }
}

- (NSString *)selectedCountryCode
{
    NSInteger index = [self selectedRowInComponent:0];
    return [countryCodes objectAtIndex:index];
}

- (void)setSelectedCountryName:(NSString *)countryName
{
    NSInteger index = [countryNames indexOfObject:countryName];
    if (index != NSNotFound)
    {
        [self selectRow:index inComponent:0 animated:NO];
    }
}

- (NSString *)selectedCountryName
{
    NSInteger index = [self selectedRowInComponent:0];
    return [countryNames objectAtIndex:index];
}

#pragma mark -
#pragma UIPicker

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [countryCodes count];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    if (!view)
    {
        view = AH_AUTORELEASE([[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 30)]);
        
        UILabel *label = AH_AUTORELEASE([[UILabel alloc] initWithFrame:CGRectMake(35, 3, 245, 24)]);
        label.backgroundColor = [UIColor clearColor];
        [view addSubview:label];
        
        UIImageView *flagView = AH_AUTORELEASE([[UIImageView alloc] initWithFrame:CGRectMake(3, 3, 24, 24)]);
        flagView.contentMode = UIViewContentModeScaleToFill;
        [view addSubview:flagView];
    }
    
    [(UILabel *)[view.subviews objectAtIndex:0] setText:[countryNames objectAtIndex:row]];
    UIImage *flag = [UIImage imageNamed:[[countryCodes objectAtIndex:row] stringByAppendingPathExtension:@"png"]];
    [(UIImageView *)[view.subviews objectAtIndex:1] setImage:flag];
    
    return view;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [delegate countryPicker:self didSelectCountryWithName:self.selectedCountryName code:self.selectedCountryCode];
}

@end
