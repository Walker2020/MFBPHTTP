//
//  KLCSHttpResponsHandler.m
//  KLCSSDKClient
//
//  Created by DengJinHui on 2020/3/12.
//

#define KLCSErrorMessage(code) \
[[NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:@"KLCSSDKClient" withExtension:@"bundle"]] localizedStringForKey:[NSString stringWithFormat:@"Error%ld",(code)] value:nil table:@"Localization"]


#import "KLCSHttpResponsHandler.h"
#import "KLCSJSONObject.h"
#import "KLCSBaseError.h"
#import "KLCSErrorCode.h"
#import "AFNetworking.h"

@interface KLCSHttpResponsHandler()<KLCSHttpResponseProtocol>
@end

@implementation KLCSHttpResponsHandler

@synthesize error = _error;

@synthesize isRequestSuccess = _isRequestSuccess;

@synthesize resultCode = _resultCode;

@synthesize resultMessage = _resultMessage;

@synthesize resultData = _resultData;

-(NSError *)error {
    if (_error == nil) {
        _error = [KLCSBaseError errorWithCode:KLCSCodeUnkown errorMsg:KLCSErrorMessage(KLCSCodeUnkown) originError:nil];
    }
    return _error;
}

- (NSString *)resultMessage {
    if (_resultMessage == nil) {
        _resultMessage = KLCSErrorMessage(KLCSCodeUnkown);
        if (self.error) {
            if ([self.error.userInfo objectForKey:@"resultMessage"]) {
                _resultMessage =[self.error.userInfo objectForKey:@"resultMessage"];
            }
        }
    }
    return _resultMessage;
}

-(NSString *)resultCode {
    if (_resultCode == nil) {
        if (self.error) {
            _resultCode= [NSString stringWithFormat:@"%ld",self.error.code];
        }
    }
    return _resultCode;
}

-(void)onParseWithSessionTask:(NSURLSessionTask*)task responseObject:(id)responseObject error:(NSError *)error {
    if (responseObject == nil && error) {
        _resultCode =  nil;
        _resultMessage = nil;
        _resultData = nil;
        
        if ([error.domain isEqualToString:AFURLRequestSerializationErrorDomain]) {
            _error = [[KLCSBaseError alloc] initWithCode:KLCSCodeCreateNetworkOperationFail
                                                errorMsg:KLCSErrorMessage(KLCSCodeServerResultDataInvalid)
                                             originError:nil];
            [self checkAuthInvalidate];
            return;
        }
        if ([error.domain isEqualToString:AFURLResponseSerializationErrorDomain]) {
            NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
            _error = [[KLCSBaseError alloc] initWithCode:response.statusCode
                                                errorMsg:KLCSErrorMessage(KLCSCodeServerResultDataInvalid)
                                             originError:nil];
            [self checkAuthInvalidate];
            return;
        }
        if ([error.domain isEqualToString:NSURLErrorDomain]) {
            _error = [[KLCSBaseError alloc] initWithCode:error.code
            errorMsg:@"网络连接失败"
            originError:nil];
            [self checkAuthInvalidate];
            return;
        }
        _error = [[KLCSBaseError alloc] initWithCode:KLCSCodeServerResultDataInvalid
                                            errorMsg:KLCSErrorMessage(KLCSCodeServerResultDataInvalid)
                                         originError:nil];
        [self checkAuthInvalidate];
        return;
        
    }
    
    if (responseObject && !error) {
        KLCSJSONObject * responseData = [[KLCSJSONObject alloc]initWithDictionary:responseObject];
        _resultCode    = [responseData getString:@"retCode"];
        _resultMessage = [responseData getString:@"retMsg"];
        _resultData    = [responseData getJSONObject:@"retData"];
        //如果 _resultData 为空，可能是因为 data 是一个 JSONArray，所以再以JSONArray获取一次。
        if (!_resultData) {
            _resultData = [responseData getJSONArray:@"retData"];
        }
        
        //code 不能为空
        if (!_resultCode){
            _error = [[KLCSBaseError alloc] initWithCode:KLCSCodeServerResultDataInvalid
                                                              errorMsg:KLCSErrorMessage(KLCSCodeServerResultDataInvalid)
                                                           originError:nil];
        }
        
        //返回码不是 "TS0000"，则认为请求是失败的（业务上失败）。
        if (!self.isRequestSuccess){
            _error = [[KLCSServerErrorCode alloc]initWitchResultCode:_resultCode
                                                       resultMessage:_resultMessage];
            [self checkAuthInvalidate];
        }
        
    }

}


-(BOOL)isRequestSuccess {
    if(!self.resultCode){
        return NO;
    }
    if (![@"000000" isEqualToString:self.resultCode]){
        return NO;
    }
    return YES;
}

- (void)checkAuthInvalidate {
    if (!self.isRequestSuccess) {
        NSError *error = _error;
        if ([@"000104" isEqualToString:self.resultCode]) {
            //去登录
            [self gotoLogin];
        }else if ([@"000103" isEqualToString:self.resultCode] || [@"000107" isEqualToString:self.resultCode]) {
            
        }else if (error.code == 401) {
            [self gotoLogin];
        }else if (error.code == 403) {
            
        }else if (error.code >= 500 && error.code < 600) {
            [self gotoLogin];
        }
    }
}

- (void)gotoLogin {
   
}

@end
