Purpose
--------------

CountryPicker is a custom UIPickerView subclass that provides an iOS control allowing a user to select a country from a list. It can optionally display a flag next to each country name, and the library includes a set of 249 high-quality, public domain flag images from FAMFAMFAM (http://www.famfamfam.com/lab/icons/flags/) that have been painstakingly re-named by country code to work with the library.

Note that the list of countries is based on the ISO 3166 country code standard (http://en.wikipedia.org/wiki/ISO_3166-1). This list excludes certain smaller countries, regarding them as part of a larger state. For example, England, Scotland, Wales and Northern Ireland are lumped together as Great Britain. For most purposes this is fine as it matches the convention used for locales, but if you need to specify additional countries, you can add them to the Countries.plist file (making sure to invent a unique country code for each).


Installation
--------------

To use the CountryPicker in an app, just drag the CountryPicker class files, and the Countries.plist file into your project. If you want to use the FAMFAMFAM flag icons, drag the Flags folder in also.


CountryPicker class methods
-----------------------------

The CountryPicker class includes several handy methods for retrieving country names and codes, and converting between the two:

	+ (NSArray *)countryNames;
	
Returns an array of all country names in alphabetical order.
	
	+ (NSArray *)countryCodes;
	
Returns an array of all country codes. The codes are sorted by country name, and their indices match the indices of their respective country name in the `countryNames` list, but note that this means that the codes themselves are not sorted alphabetically.
	
	+ (NSDictionary *)countryNamesByCode;
	
Returns a dictionary of country names, keyed by country code.
	
	+ (NSDictionary *)countryCodesByName;

Returns a dictionary of country codes, keyed by country name.


CountryPicker properties
---------------------------

Each CountryPicker view has the following properties:

	@property (nonatomic, assign) id<CountryPickerDelegate> delegate;
	
The delegate. This implements the CountryPickerDelegate protocol, and is notified when a country is selected.
	
	@property (nonatomic, copy) NSString *selectedCountryName;
	
The currently selected country name. This is a read-write property, so it can be used to set the picker value. Setting the picker to a country name that does not appear in the `countryNames` array has no effect.
	
	@property (nonatomic, copy) NSString *selectedCountryCode;
	
The currently selected country code. This is a read-write property, so it can be used to set the picker value. Setting the picker to a country code that does not appear in the `countryCodes` array has no effect.
	

CountryPicker instance methods
-------------------------------

CountryPicker has the following utility method:

	- (void)setWithLocale:(NSLocale *)locale;

This is a convenience method to set the picker using a locale. The picker will automatically select the correct country based on the local. To default the picker to the current device locale, you can say:

	[picker setWithLocale:[NSLocale currentLocale]];


CountryPickerDelegate protocol
--------------------------------

The CountryPickerDelegate protocol has a single obligatory method:

- (void)countryPicker:(CountryPicker *)picker didSelectCountryWithName:(NSString *)name code:(NSString *)code;

This method is called whenever a country is selected in the picker.