
#import "IBizMobKit.h"
#import "SSKeychain.h"

@interface IBizMobKit()
{
    NSString *_identifier;
    NSString *_deviceId;
}
@end

@implementation IBizMobKit

- (void)pluginInitialize
{
    [super pluginInitialize];
    
    _identifier = [NSString stringWithFormat:@"%@.security",[[NSBundle mainBundle] bundleIdentifier]];
    _deviceId = [SSKeychain passwordForService:_identifier account:@"ibimobkit_device_id"];
    
    if(!_deviceId || _deviceId.length < 1)
    {
        _deviceId = [[self class] uuid];
        [SSKeychain setPassword: _deviceId forService:_identifier account:@"ibimobkit_device_id"];
    }
}

-(void)start:(CDVInvokedUrlCommand*)command
{
    [self.commandDelegate runInBackground:^{
        
        NSDictionary *info = [self deviceProperties];
        
        NSString *strUserId = [self getUserValue:@"userid"];
        NSString *strToken = [self getUserValue:@"token"];
        NSString *strUserInfo = [self getUserValue:@"userinfo"];
        
        NSDictionary *dict = @{@"deviceinfo":info,@"userid":strUserId,@"token":strToken,@"userinfo":strUserInfo};
        
        CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:dict];
        
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    }];
}

- (void)getDeviceId:(CDVInvokedUrlCommand*)command
{
    [self.commandDelegate runInBackground:^{
        
        CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:[self deviceId]];
        
        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
    }];
}

- (void)getDeviceInfo:(CDVInvokedUrlCommand*)command
{
    [self.commandDelegate runInBackground:^{
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:[self deviceProperties]];
        
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}


-(void)appValue :(CDVInvokedUrlCommand*)command
{
    [self.commandDelegate runInBackground:^{
        NSString *strKey = [command argumentAtIndex:0];
        
        NSString *strVal = [self getAppValue:strKey];
        
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:strVal];
        
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

-(void)setAppValue : (CDVInvokedUrlCommand*)command
{
    [self.commandDelegate runInBackground:^{
        NSString *strKey = [command argumentAtIndex:0];
        NSString *strVal = [command argumentAtIndex:1 withDefault:@""];
        
        if(strKey)
        {
            [SSKeychain setPassword:strVal forService:_identifier account:strKey];
        }
        
        [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
    }];
}

-(void)userValue :(CDVInvokedUrlCommand*)command
{
    [self.commandDelegate runInBackground:^{
        NSString *strKey = [command argumentAtIndex:0];
        
        NSString *strVal = [self getUserValue:strKey];
    
        
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:strVal];
    
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

-(void)setUserValue : (CDVInvokedUrlCommand*)command
{
    [self.commandDelegate runInBackground:^{
        NSString *strKey = [command argumentAtIndex:0];
        NSString *strVal = [command argumentAtIndex:1 withDefault:@""];
    
        if(strKey)
        {
            NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
            [ud setValue:strVal forKey:strKey];
            [ud synchronize];
        }
    
        [self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
    }];
}

/**======================*/




-(NSString *)getAppValue:(NSString *)key
{
    NSString *strVal = @"";
    if(key)
    {
       strVal = [SSKeychain passwordForService:_identifier account:key];
    }
    if(strVal)
        return strVal;
    return @"";
}


-(NSString *)getUserValue:(NSString *)key
{
    NSString *strVal = @"";
    if(key)
    {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        strVal = [ud stringForKey:key];
    }
    if(strVal)
        return strVal;
    return @"";
}

-(NSString *)deviceId
{
    return _deviceId;
}



- (NSDictionary*)deviceProperties
{
    UIDevice* device = [UIDevice currentDevice];
    
    return @{
             @"manufacturer": @"Apple",
             @"platform": @"iOS",
             @"version": [device systemVersion],
             @"deviceid": [self deviceId],
             @"cordova": [[self class] cordovaVersion],
             @"isvirtual": @([self isVirtual])
             };
}

+(NSString *)uuid
{
    UIDevice *device = [UIDevice currentDevice];
    
    return [[device identifierForVendor] UUIDString];
}

+ (NSString*)cordovaVersion
{
    return CDV_VERSION;
}

- (BOOL)isVirtual
{
#if TARGET_OS_SIMULATOR
    return true;
#elif TARGET_IPHONE_SIMULATOR
    return true;
#else
    return false;
#endif
}


@end

