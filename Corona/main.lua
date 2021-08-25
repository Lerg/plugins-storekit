display.setStatusBar(display.HiddenStatusBar)

local widget = require('widget')
local storekit = require('plugin.storekit')

display.setDefault('background', 1)

local xl, xr, y = display.contentWidth * .25, display.contentWidth * .75, display.contentCenterY
local w, h = display.contentWidth * 0.4, 50

widget.newButton{
	x = xl, y = y - 200,
	width = w, height = h,
	label = 'Register',
	onRelease = function()
		print('registerAppForAdNetworkAttribution')
		print(storekit.registerAppForAdNetworkAttribution())
	end}

widget.newButton{
	x = xr, y = y - 200,
	width = w, height = h,
	label = 'Update Conversion',
	onRelease = function()
		print('updateConversionValue')
		print(storekit.updateConversionValue(5))
	end}
