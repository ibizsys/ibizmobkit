
#import <Foundation/Foundation.h>
#import <Cordova/CDVPlugin.h>

@interface IBizMobKit : CDVPlugin


-(void)start:(CDVInvokedUrlCommand*)command;

-(void)getDeviceId:(CDVInvokedUrlCommand*)command;

-(void)getDeviceInfo:(CDVInvokedUrlCommand*)command;

-(void)appValue :(CDVInvokedUrlCommand*)command;

-(void)setAppValue : (CDVInvokedUrlCommand*)command;

-(void)userValue :(CDVInvokedUrlCommand*)command;

-(void)setUserValue : (CDVInvokedUrlCommand*)command;

@end

