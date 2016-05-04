    
#import <Foundation/Foundation.h>
#import <Cordova/CDVPlugin.h>

@interface IBizMobKit : CDVPlugin

- (void)getDeviceId:(CDVInvokedUrlCommand*)command;

@end

