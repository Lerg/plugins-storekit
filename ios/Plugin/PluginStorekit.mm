#include <CoronaRuntime.h>
#include <plugin_storekit_ext/plugin_storekit_ext.h>
#include <dlfcn.h>
#import "Utils.h"

@interface PluginStorekit : NSObject
@end

@implementation PluginStorekit {
    bool is_available;
}

static PluginStorekit *plugin;

static int registerAppForAdNetworkAttribution(lua_State *L) {return [plugin registerAppForAdNetworkAttribution:L];}
static int updateConversionValue(lua_State *L) {return [plugin updateConversionValue:L];}

-(int)open:(lua_State*)L {
	const luaL_Reg lua_functions[] = {
		{"registerAppForAdNetworkAttribution", registerAppForAdNetworkAttribution},
		{"updateConversionValue", updateConversionValue},
		{NULL, NULL}
	};

	const char *plugin_name = lua_tostring(L, 1);
	luaL_openlib(L, plugin_name, lua_functions, 1);

	[Utils setTag:@"plugin.storekit"];
    
    is_available = false;
    if (@available(iOS 14.0, *)) {
        NSString *lib_name = @"plugin_storekit_ext";
        NSString *path = [[NSBundle mainBundle] pathForResource:lib_name ofType:@"framework"];
        path = [path stringByAppendingString:[NSString stringWithFormat:@"/%@", lib_name]];

        void *lib = dlopen([path cStringUsingEncoding:NSUTF8StringEncoding], RTLD_NOW);

        if (lib != NULL) {
            is_available = true;
        } else {
            NSLog(@"Error opening plugin_storekit_ext: %s", dlerror());
        }
    }

	return 1;
}

-(int)registerAppForAdNetworkAttribution:(lua_State*)L {
	[Utils checkArgCount:L count:0];
    
    if (is_available) {
        [PluginStorekitExt registerAppForAdNetworkAttribution];
        lua_pushboolean(L, true);
        return 1;
    }
	return 0;
}

-(int)updateConversionValue:(lua_State*)L {
	[Utils checkArgCount:L count:1];

    int convertion_value = (int)luaL_checkinteger(L, 1);
    if (is_available) {
        [PluginStorekitExt updateConversionValue:convertion_value];
        lua_pushboolean(L, true);
        return 1;
    }
	return 0;
}

@end

CORONA_EXPORT int luaopen_plugin_storekit(lua_State *L);
CORONA_EXPORT int luaopen_plugin_storekit(lua_State *L) {
	plugin = [[PluginStorekit alloc] init];
	return [plugin open:L];
}
