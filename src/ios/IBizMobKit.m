
#import "IBizMobKit.h"

@implementation IBizMobKit

- (void)getDeviceId:(CDVInvokedUrlCommand*)command
{
	[self.commandDelegate runInBackground:^{
	 
		CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"thisisdeviceid"];
		[self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
	}];
}

@end

