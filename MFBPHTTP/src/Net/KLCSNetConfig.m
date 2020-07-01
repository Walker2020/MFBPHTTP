//
//  KLCSNetConfig.m
//  AFNetworking
//
//  Created by DengJinHui on 2019/12/11.
//

#import "KLCSNetConfig.h"
static KLCSNetConfig * manager = nil;
static NSString * const KLCSSITBASEURL = @"http://10.177.93.120";

@implementation KLCSNetConfig
@synthesize netEnv =_netEnv;

+(KLCSNetConfig *)instance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[KLCSNetConfig alloc]init];
    });
    return manager;
}

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    return manager;
}

- (nonnull id)mutableCopyWithZone:(nullable NSZone *)zone {
    return manager;
}

+ (id)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [super allocWithZone:zone];
    });
    return manager;
}


-(void)setNetEnv:(KLCSNet)netEnv {
#ifdef DEBUG
    _netEnv = netEnv;
#else
     _netEnv = KLCSNetRelease;
#endif

}

-(KLCSNet)netEnv {
    
#ifdef DEBUG
    return _netEnv;
#endif
    return KLCSNetRelease;
}


#pragma mark -- getter

-(NSString *)internalSitBaseUrl {
    return @"http://klcs-test.lakala.sh.in/mpos_klcs/api";
}

-(NSString *)internalUatBaseUrl {
    return  @"http://klcs-uat.lakala.sh.in/mpos_klcs/api";
}

-(NSString *)externalSitBaseUrl {
    return @"";
}

-(NSString *)externalUatBaseUrl {
    return @"";
}

-(NSString *)standbyBaseUrl {
    return @"";
}

-(NSString *)releaseBaseUrl {
    return @"";
}

-(NSString *)externalBaseUrl {
    return @"http://klcs-uat.lakala.sh.in/mpos_klcs/api";
}

-(NSString *)baseUrl {
    switch (self.netEnv) {
        case KLCSNetDebugInternalSIT:
            return self.internalSitBaseUrl;
            break;
            
        case KLCSNetDebugInternalUAT:
            return self.internalUatBaseUrl;
            break;
            
            
        case KLCSNetDebugExternalSIT:
            return self.externalSitBaseUrl;
            break;
            
            
        case KLCSNetDebugExternalUAT:
            return self.externalUatBaseUrl;
            break;
            
            
        case KLCSNetStandby:
            return self.standbyBaseUrl;
            break;
            
            
        case KLCSNetRelease:
            return self.releaseBaseUrl;
            break;
    
        default:
            break;
    }
    //return self.externalBaseUrl;
}

@end
