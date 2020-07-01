//
//  KLCSBaseError.h
//  KLCSSDKClient
//
//  Created by DengJinHui on 2020/3/12.
//

#import <UIKit/UIKit.h>

#define KLCSErrorDomain @"com.klcs.error.http"


@interface KLCSBaseError : NSError
@property (assign,nonatomic,readonly) NSError* originError;

-(id)initWithCode :(NSInteger)code userInfo:(NSDictionary *)dict;
-(id)initWithCode :(NSInteger)code errorMsg:(NSString *)msg originError:(NSError * _Nullable) error;
-(id)initWithCode :(NSInteger)code userInfo:(NSDictionary *)dict originError:(NSError * _Nullable) error;
+(KLCSBaseError*)errorWithCode:(NSInteger)code userInfo:(NSDictionary *)dict;
+(KLCSBaseError*)errorWithCode:(NSInteger)code errorMsg:(NSString *)msg originError:(NSError * _Nullable) error;
+(KLCSBaseError*)errorWithCode:(NSInteger)code userInfo:(NSDictionary *)dict originError:(NSError *)error;
+(BOOL)isKLCSBaseError:(NSError *) error;

-(NSString*) getMessage;

@end

@interface KLCSServerErrorCode : KLCSBaseError

@property (assign,nonatomic,readonly) NSString *resultCode;
@property (copy,nonatomic,readonly)   NSString *resultMessage;
-(id)initWitchResultCode:(NSString*)resultCode resultMessage:(NSString*)message;

@end
