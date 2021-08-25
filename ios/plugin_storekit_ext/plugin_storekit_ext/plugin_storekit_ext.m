//
//  plugin_storekit_ext.m
//  plugin_storekit_ext
//
//  Created by Sergey Lerg on 10/17/20.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

@interface PluginStorekitExt : NSObject
@end

@implementation PluginStorekitExt

+(void)registerAppForAdNetworkAttribution {
    [SKAdNetwork registerAppForAdNetworkAttribution];
}

+(void)updateConversionValue:(int)convertion_value {
    [SKAdNetwork updateConversionValue:convertion_value];
}

@end
