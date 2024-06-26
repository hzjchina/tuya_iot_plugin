#import "TuyaIotPlugin.h"
#import "TuyaSmartActivator.h"

@implementation TuyaIotPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"tuya_iot_plugin"
            binaryMessenger:[registrar messenger]];
  TuyaIotPlugin* instance = [[TuyaIotPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  }else if([@"startConfig" isEqualToString:call.method]){
    [self startConfig:call result:result];

  }else if([@"stopConfig" isEqualToString:call.method]){
 [self stopConfig:call result:result];

  } else {
    result(FlutterMethodNotImplemented);
  }
}

- (void)startConfig:(FlutterMethodCall*)call result:(FlutterResult)result {

    NSDictionary *arguments = call.arguments;
    
    NSString *ssid = arguments[@"ssid"];
    //NSLog(@"TuyaIotPlugin ssid: %@",ssid);
    
    NSString *password = arguments[@"password"];
   // NSLog(@"TuyaIotPlugin password: %@",password);
    
    NSString *authToken = arguments[@"authToken"];
   // NSLog(@"TuyaIotPlugin authToken: %@",authToken);
    
    NSString *pairType = arguments[@"pairType"];
    
    if(ssid == nil || password == nil || authToken == nil || pairType == nil){
        result(@NO);
    }else{
        if ([pairType isEqualToString:@"wired"]) {
            [[TuyaSmartActivator sharedInstance] startConfigWiredDeviceWithToken:authToken];
        } else {//wireless
            [[TuyaSmartActivator sharedInstance] startConfigWiFiWithMode:TYActivatorModeEZ ssid:ssid password:password token:authToken];
        }
        result(@YES);
    }
}


- (void)stopConfig:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary *arguments = call.arguments;
    NSString *pairType = arguments[@"pairType"];
    
    if(pairType == nil){
        result(@NO);
    }else{
//        if ([pairType isEqualToString:@"wired"]) {
//            [[TuyaSmartActivator sharedInstance] stopConfigWiFi];
//        }else{
//            [[TuyaSmartActivator sharedInstance] stopConfigWiFi];
//        }
        [[TuyaSmartActivator sharedInstance] stopConfigWiFi];
        result(@YES);
    }
}

//    // EZ
//    [[TuyaSmartActivator sharedInstance] startConfigWiFiWithMode:TYActivatorModeEZ ssid:ssid password:password token:token];
//
//    // AP
//    [[TuyaSmartActivator sharedInstance] startConfigWiFiWithMode:TYActivatorModeAP ssid:ssid password:password token:token];
//
//    // Zigbee Gateway
//    [[TuyaSmartActivator sharedInstance] startConfigWiredDeviceWithToken:token];
//
//    // stop
//    [[TuyaSmartActivator sharedInstance] stopConfigWiFi];
@end
