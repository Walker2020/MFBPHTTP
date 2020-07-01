//
//  KLCSNetConfig.h
//  AFNetworking
//
//  Created by DengJinHui on 2019/12/11.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    KLCSNetDebugInternalSIT = 0,//内网SIT环境
    KLCSNetDebugInternalUAT,//内网UAT环境
    KLCSNetDebugExternalSIT,//外网SIT
    KLCSNetDebugExternalUAT,//外网UAT
    KLCSNetRelease,//生产环境
    KLCSNetStandby,//备机环境
} KLCSNet;

NS_ASSUME_NONNULL_BEGIN

@interface KLCSNetConfig : NSObject
+(KLCSNetConfig*)instance;
@property(nonatomic, copy, readonly)NSString *internalSitBaseUrl;
@property(nonatomic, copy, readonly)NSString *internalUatBaseUrl;
@property(nonatomic, copy, readonly)NSString *externalSitBaseUrl;
@property(nonatomic, copy, readonly)NSString *externalUatBaseUrl;
@property(nonatomic, copy, readonly)NSString *standbyBaseUrl;//备机环境
@property(nonatomic, copy, readonly)NSString *releaseBaseUrl;//w生产环境
@property(nonatomic, copy, readonly)NSString *baseUrl;
@property(nonatomic, assign)KLCSNet netEnv;
@end

NS_ASSUME_NONNULL_END
