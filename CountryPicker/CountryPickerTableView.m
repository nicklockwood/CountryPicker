//
//  CountryPickerTableView.m
//  CountryPickerDemo
//
//  Created by Palaniraja on 28/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CountryPickerTableView.h"

//@interface CountryPickerTableView () <UITableViewDelegate, UITableViewDataSource>
//
//
//
//@end


@implementation CountryPickerTableView

static NSArray *countryNames = nil;
static NSArray *countryCodes = nil;
static NSDictionary *countryNamesByCode = nil;
static NSDictionary *countryCodesByName = nil;


@synthesize countrySelectionDelegate;

#pragma mark copied from CountryPicker
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

- (void)setDataSource:(id<UITableViewDataSource>)dataSource
{
    //does nothing
}
- (void)setDelegate:(id<UITableViewDelegate>)newdelegate
{
    //does nothing
    countrySelectionDelegate = newdelegate;
}


- (void)setSelectedCountryCode:(NSString *)countryCode
{
    NSInteger index = [countryCodes indexOfObject:countryCode];
    if (index != NSNotFound)
    {
//        [self selectRow:index inComponent:0 animated:NO];
        [self selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    }
}

- (NSString *)selectedCountryCode
{
    NSInteger index = selectedIndexPath.row;
    return [countryCodes objectAtIndex:index];
}

- (void)setSelectedCountryName:(NSString *)countryName
{
    NSInteger index = [countryNames indexOfObject:countryName];
    if (index != NSNotFound)
    {
        [self selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    }
}

- (NSString *)selectedCountryName
{
    NSInteger index = selectedIndexPath.row;
    return [countryNames objectAtIndex:index];
}


#pragma mark Datasource & Delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [countryCodes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"countrypickercell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = AH_AUTORELEASE([[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] );
        cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
    }
    
    cell.textLabel.text = [countryNames objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[[countryCodes objectAtIndex:indexPath.row] stringByAppendingPathExtension:@"png"]];
    
    return cell;

    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedIndexPath = indexPath;
//    NSLog(@"selected Indexpath: %@", indexPath);

//    NSLog(@"Selected country name: %@ code: %@", self.selectedCountryName, self.selectedCountryCode);
     [countrySelectionDelegate countryPickerTableView:self didSelectCountryWithName:self.selectedCountryName code:self.selectedCountryCode];
}

@end
