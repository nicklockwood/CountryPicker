//
//  CountryPicker.h
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

//
//  ARC Helper
//
//  Version 1.2
//
//  Created by Nick Lockwood on 05/01/2012.
//  Charcoal Design Charcoal Design
//
//  Distributed under the permissive zlib License
//  Get the latest version from here:
//
//  https://gist.github.com/1563325
//

#ifndef AH_RETAIN
#if __has_feature(objc_arc)
#define AH_RETAIN(x) x
#define AH_RELEASE(x)
#define AH_AUTORELEASE(x) x
#define AH_SUPER_DEALLOC
#else
#define __AH_WEAK
#define AH_WEAK assign
#define AH_RETAIN(x) [x retain]
#define AH_RELEASE(x) [x release]
#define AH_AUTORELEASE(x) [x autorelease]
#define AH_SUPER_DEALLOC [super dealloc]
#endif
#endif

//  Weak reference support

#ifndef AH_WEAK
#if defined __IPHONE_OS_VERSION_MIN_REQUIRED
#if __IPHONE_OS_VERSION_MIN_REQUIRED > __IPHONE_4_3
#define __AH_WEAK __weak
#define AH_WEAK weak
#else
#define __AH_WEAK __unsafe_unretained
#define AH_WEAK unsafe_unretained
#endif
#elif defined __MAC_OS_X_VERSION_MIN_REQUIRED
#if __MAC_OS_X_VERSION_MIN_REQUIRED > __MAC_10_6
#define __AH_WEAK __weak
#define AH_WEAK weak
#else
#define __AH_WEAK __unsafe_unretained
#define AH_WEAK unsafe_unretained
#endif
#endif
#endif

//  ARC Helper ends


#import <Foundation/Foundation.h>


@class CountryPicker;


@protocol CountryPickerDelegate <UIPickerViewDelegate>

- (void)countryPicker:(CountryPicker *)picker didSelectCountryWithName:(NSString *)name code:(NSString *)code;

@end


@interface CountryPicker : UIPickerView

+ (NSArray *)countryNames;
+ (NSArray *)countryCodes;
+ (NSDictionary *)countryNamesByCode;
+ (NSDictionary *)countryCodesByName;

@property (nonatomic, AH_WEAK) id<CountryPickerDelegate> delegate;
@property (nonatomic, copy) NSString *selectedCountryName;
@property (nonatomic, copy) NSString *selectedCountryCode;

- (void)setWithLocale:(NSLocale *)locale;

@end
