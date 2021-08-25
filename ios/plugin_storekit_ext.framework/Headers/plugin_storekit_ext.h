//
//  plugin_storekit_ext.h
//  plugin_storekit_ext
//
//  Created by Sergey Lerg on 10/17/20.
//

#import <Foundation/Foundation.h>

//! Project version number for plugin_storekit_ext.
FOUNDATION_EXPORT double plugin_storekit_extVersionNumber;

//! Project version string for plugin_storekit_ext.
FOUNDATION_EXPORT const unsigned char plugin_storekit_extVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <plugin_storekit_ext/PublicHeader.h>


@interface PluginStorekitExt : NSObject

+(void)registerAppForAdNetworkAttribution;
+(void)updateConversionValue:(int)convertion_value;

@end
