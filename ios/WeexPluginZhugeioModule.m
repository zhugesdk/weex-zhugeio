//
//  WeexPluginZhugeioModule.h
//
//  Created by Jiaokang on 18/5/28.
//  Copyright © 2018年 Zhugeio. All rights reserved.
//

#import "WeexPluginZhugeioModule.h"
#import <Zhugeio/Zhuge.h>
#import <WeexPluginLoader/WeexPluginLoader.h>

@implementation WeexPluginZhugeioModule

WX_PlUGIN_EXPORT_MODULE(WeexPluginZhugeio, WeexPluginZhugeioModule)
WX_EXPORT_METHOD(@selector(openDebug))
WX_EXPORT_METHOD(@selector(openLog))
WX_EXPORT_METHOD(@selector(identify:properties:))
WX_EXPORT_METHOD(@selector(track:properties:))
WX_EXPORT_METHOD(@selector(startTrack:))
WX_EXPORT_METHOD(@selector(endTrack:properties:))

-(void)openDebug{
    [[Zhuge sharedInstance].config setDebug:YES];
}
-(void)openLog{
    
}
-(void)identify:(NSString *)userId properties:(NSDictionary *)propertyDict{
    @try {
        [[Zhuge sharedInstance] identify:userId properties:propertyDict];
    } @catch (NSException *exception) {
        NSLog(@"[ZhugeWeexSDK] error:%@",exception);
    }
}
-(void)track:(NSString *)event properties:(NSDictionary *)propertyDict{
    @try {
        [[Zhuge sharedInstance] track:event properties:propertyDict];
    } @catch (NSException *exception) {
        NSLog(@"[ZhugeWeexSDK] error:%@",exception);
    }
}
-(void)startTrack:(NSString *)event{
    @try {
        [[Zhuge sharedInstance]startTrack:event];
    } @catch (NSException *exception) {
        NSLog(@"[ZhugeWeexSDK] error:%@",exception);
    }
}
-(void)endTrack:(NSString *)event properties:(NSDictionary *)propertyDict{
    @try {
        [[Zhuge sharedInstance] endTrack:event properties:propertyDict];
    } @catch (NSException *exception) {
        NSLog(@"[ZhugeWeexSDK] error:%@",exception);
    }
}
@end
