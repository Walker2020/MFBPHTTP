//
//  KLCSBaseError.m
//  KLCSSDKClient
//
//  Created by DengJinHui on 2020/3/12.
//

#import "KLCSBaseError.h"
#import "KLCSErrorCode.h"
@interface KLCSBaseError(/*Private*/)
-(void) setOriginError:(NSError*) error;
@end


@implementation KLCSBaseError

- (id)initWithCode:(NSInteger)code userInfo:(NSDictionary *)dict
{
    return [self initWithCode:code userInfo:dict originError:nil];
}

-(id)initWithCode :(NSInteger)code errorMsg:(NSString *)msg originError:(NSError *)error
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setValue:msg forKey:NSLocalizedDescriptionKey];
    [dict setValue:msg forKey:@"resultMessage"];
    
    return [self initWithCode:code userInfo:dict originError:error];
}

- (id)initWithCode:(NSInteger)code userInfo:(NSDictionary *)dict originError:(NSError *)error
{
    self = [super initWithDomain:KLCSErrorDomain code:code userInfo:dict];
    [self setOriginError:error];
    return self;
}

-(void) setOriginError:(NSError*) error
{
    _originError = error;
}

+(KLCSBaseError*)errorWithCode:(NSInteger)code userInfo:(NSDictionary *)dict
{
    return [KLCSBaseError errorWithCode:code userInfo:dict originError:nil];
}

+(KLCSBaseError*)errorWithCode:(NSInteger)code errorMsg:(NSString *)msg originError:(NSError *)error
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setValue:msg forKey:NSLocalizedDescriptionKey];
    [dict setValue:msg forKey:@"resultMessage"];
    
    return [KLCSBaseError errorWithCode:code userInfo:dict originError:error];
}

+ (KLCSBaseError*)errorWithCode:(NSInteger)code userInfo:(NSDictionary *)dict originError:(NSError *)error
{
    KLCSBaseError *_error = [super errorWithDomain:KLCSErrorDomain code:code userInfo:dict];
    [_error setOriginError:error];
    return _error;
}

+(BOOL)isKLCSBaseError:(NSError *)error
{
    NSString *domain = [error domain];
    if (!domain)
        return false;
    
    return [KLCSErrorDomain isEqualToString:domain];

}

-(NSString*)getMessage
{
    if (self.userInfo){
        NSString *msg = [self.userInfo valueForKey:NSLocalizedDescriptionKey];
        if (msg) return msg;
    }
    
    return nil;
}

//-(NSString *)getResultMessage {
//    NSString *retMessage = @"";
//
//    if (self.userInfo && [self.userInfo]){
//       retMessage = [self.userInfo valueForKey:@"resultMessage"];
//    }
//    return retMessage;
//}

@end



/**
 *  服务器返回非 "000000"，时会发送此错误。
 */
@implementation KLCSServerErrorCode
-(id)initWitchResultCode:(NSString*)resultCode resultMessage:(NSString*)message
{
    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc]init];
    
    if (!resultCode) resultCode = @"";
    if (!message)    message = @"";
    NSString * errorCode = [NSString stringWithFormat:@"error_%ld",KLCSCodeServerResultErrorCode];
    [userInfo setObject:errorCode forKey:NSLocalizedDescriptionKey];
    [userInfo setObject:resultCode forKey:@"resultCode"];
    [userInfo setObject:message    forKey:@"resultMessage"];
    
    if ((self = [super initWithCode:KLCSCodeServerResultErrorCode userInfo:userInfo])){
        _resultMessage = message;
        _resultCode = resultCode;
    }
    
    return self;
}
@end
