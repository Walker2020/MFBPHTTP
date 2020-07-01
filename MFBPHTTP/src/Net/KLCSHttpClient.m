//
//  KLCSHttpClient.m
//  AFNetworking
//
//  Created by DengJinHui on 2019/11/14.
//

#import "KLCSHttpClient.h"
#import "KLCSNetConfig.h"
#import "KLCSHttpResponsHandler.h"
#import "KLCSHttpProtocol.h"
#import "KLCSErrorCode.h"
#import "KLCSLoadingDialog.h"
static KLCSHttpClient *manager = nil;

@interface KLCSHttpClient()
@property(nonatomic, strong)AFHTTPSessionManager * sessionManager;
@property(nonatomic, strong)id<KLCSHttpResponseProtocol> responseHanler;
@end

@implementation KLCSHttpClient


+(KLCSHttpClient *)instance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[KLCSHttpClient alloc]init];
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

-(instancetype)init {
    self = [super init];
    if (self) {
        [self setupSessionManager];
    }
    return self;
}


-(void)setupSessionManager {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURL * baseURL = [NSURL URLWithString:[KLCSNetConfig instance].baseUrl];
    _sessionManager = [[AFHTTPSessionManager alloc]initWithBaseURL:baseURL sessionConfiguration:configuration];
//    _KLCSRequestSerializer = [[KLCSHTTPRequestSerializer alloc]init];
//    _sessionManager.requestSerializer = _KLCSRequestSerializer.requestSerializer;
////    AFJSONResponseSerializer * responseSerializer = [[AFJSONResponseSerializer alloc]init];
//    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];
//    _sessionManager.responseSerializer = responseSerializer;
    _sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];
    self.responseHanler = [[KLCSHttpResponsHandler alloc]init];
}

-(void)setResponseHanler:(id<KLCSHttpResponseProtocol>)responseHanler {
    _responseHanler = responseHanler;
}


-(void)POSTWithURLString:(NSString *)URLString
              parameters:(NSDictionary *)parameters
                 success:(KLCSHttpSessionTaskSuccess)success
                 failure:(KLCSHttpSessionTaskFailure)failure {
    [self requestWithMethod:@"POST" URLString:URLString parameters:parameters success:success failure:failure];
    
}

-(void)POSTWithURLString:(NSString *)URLString
              parameters:(nullable NSDictionary *)parameters
           isShowLoading:(BOOL)isShowLoading
                 success:(KLCSHttpSessionTaskSuccess)success
                 failure:(KLCSHttpSessionTaskFailure)failure {
    [self requestWithMethod:@"POST" URLString:URLString parameters:parameters isShowLoading:isShowLoading  isShowErrorMessage:NO success:success failure:failure];
    
}

-(void)POSTWithURLString:(NSString *)URLString
              parameters:(nullable NSDictionary *)parameters
           isShowLoading:(BOOL)isShowLoading
      isShowErrorMessage:(BOOL)isShowErrorMessage
                 success:(KLCSHttpSessionTaskSuccess)success
                 failure:(KLCSHttpSessionTaskFailure)failure {
    [self requestWithMethod:@"POST" URLString:URLString parameters:parameters isShowLoading:isShowLoading isShowErrorMessage:isShowErrorMessage success:success failure:failure];
    
}

-(void)GETWithURLString:(NSString *)URLString
             parameters:(NSDictionary *)parameters
                success:(KLCSHttpSessionTaskSuccess)success
                failure:(KLCSHttpSessionTaskFailure)failure {
    [self requestWithMethod:@"GET" URLString:URLString parameters:parameters success:success failure:failure];
    
}

-(void)GETWithURLString:(NSString *)URLString
             parameters:(nullable NSDictionary *)parameters
          isShowLoading:(BOOL)isShowLoading
                success:(KLCSHttpSessionTaskSuccess)success
                failure:(KLCSHttpSessionTaskFailure)failure {
    [self requestWithMethod:@"GET" URLString:URLString parameters:parameters
              isShowLoading:isShowLoading isShowErrorMessage:NO success:success failure:failure];
}

-(void)GETWithURLString:(NSString *)URLString
             parameters:(nullable NSDictionary *)parameters
          isShowLoading:(BOOL)isShowLoading
     isShowErrorMessage:(BOOL)isShowErrorMessage
                success:(KLCSHttpSessionTaskSuccess)success
                failure:(KLCSHttpSessionTaskFailure)failure {
    [self requestWithMethod:@"GET" URLString:URLString parameters:parameters isShowLoading:isShowLoading isShowErrorMessage:isShowErrorMessage success:success failure:failure];
    
}


-(void)requestWithMethod:(NSString *)method
               URLString:(NSString *)URLString
              parameters:(nullable NSDictionary *)parameters
                 success:(KLCSHttpSessionTaskSuccess)success
                 failure:(KLCSHttpSessionTaskFailure)failure {
    [self requestWithMethod:method URLString:URLString parameters:parameters uploadProgress:nil downloadProgress:nil success:success failure:failure];
    
}


-(void)requestWithMethod:(NSString *)method
               URLString:(NSString *)URLString
              parameters:(NSDictionary *)parameters
           isShowLoading:(BOOL)isShowLoading
      isShowErrorMessage:(BOOL)isShowErrorMessage
                 success:(KLCSHttpSessionTaskSuccess)success
                 failure:(KLCSHttpSessionTaskFailure)failure {
    [self requestWithMethod:method URLString:URLString parameters:parameters
              isShowLoading:isShowLoading isShowErrorMessage:isShowErrorMessage uploadProgress:nil downloadProgress:nil success:success failure:failure];
}


-(void)requestWithMethod:(NSString *)method
               URLString:(NSString *)URLString
              parameters:(NSDictionary *)parameters
          uploadProgress:(KLCSHttpSessionTaskProgress)uploadProgress
        downloadProgress:(KLCSHttpSessionTaskProgress)downloadProgress
                 success:(KLCSHttpSessionTaskSuccess)success
                 failure:(KLCSHttpSessionTaskFailure)failure
{
    [self requestWithMethod:method URLString:URLString parameters:parameters isShowLoading:NO isShowErrorMessage:NO loadingMaskText:nil timeoutInternal:0 uploadProgress:uploadProgress downloadProgress:downloadProgress success:success failure:failure];
}

-(void)requestWithMethod:(NSString * _Nullable)method
               URLString:(NSString * _Nullable)URLString
              parameters:(NSDictionary * _Nullable)parameters
           isShowLoading:(BOOL)isShowLoading
                 success:(KLCSHttpSessionTaskSuccess _Nullable)success
                 failure:(KLCSHttpSessionTaskFailure _Nullable)failure {
    
     [self requestWithMethod:method URLString:URLString parameters:parameters isShowLoading:isShowLoading isShowErrorMessage:NO loadingMaskText:nil timeoutInternal:0 uploadProgress:nil downloadProgress:nil success:success failure:failure];
}



-(void)requestWithMethod:(NSString *)method
               URLString:(NSString *)URLString
              parameters:(NSDictionary *)parameters
           isShowLoading:(BOOL)isShowLoading
      isShowErrorMessage:(BOOL)isShowErrorMessage
          uploadProgress:(KLCSHttpSessionTaskProgress)uploadProgress
        downloadProgress:(KLCSHttpSessionTaskProgress)downloadProgress
                 success:(KLCSHttpSessionTaskSuccess)success
                 failure:(KLCSHttpSessionTaskFailure)failure {
    [self requestWithMethod:method URLString:URLString parameters:parameters isShowLoading:isShowLoading isShowErrorMessage:isShowErrorMessage loadingMaskText:nil timeoutInternal:0 uploadProgress:uploadProgress downloadProgress:downloadProgress success:success failure:failure];
    
}


-(void)requestWithMethod:(NSString *)method
               URLString:(NSString *)URLString
              parameters:(NSDictionary *)parameters
           isShowLoading:(BOOL)isShowLoading
      isShowErrorMessage:(BOOL)isShowErrorMessage
         loadingMaskText:(NSString *)loadingMaskText
         timeoutInternal:(NSTimeInterval)timeoutInternal
          uploadProgress:(KLCSHttpSessionTaskProgress)uploadProgress
        downloadProgress:(KLCSHttpSessionTaskProgress)downloadProgress
                 success:(KLCSHttpSessionTaskSuccess)success
                 failure:(KLCSHttpSessionTaskFailure)failure
{
    if (isShowLoading) {
        [KLCSLoadingDialog showLoadingWithText:loadingMaskText];
    }
    __weak typeof(self) weakSelf = self;
    NSError *serializationError = nil;
    if (parameters == nil) {
        parameters = [NSDictionary dictionary];
    }
    NSString *baseUrlStr = [[KLCSNetConfig instance].baseUrl stringByAppendingFormat:@"/"];
    NSMutableURLRequest *request = [_sessionManager.requestSerializer requestWithMethod:method URLString:[[NSURL URLWithString:URLString relativeToURL:[NSURL URLWithString:baseUrlStr]] absoluteString]parameters:parameters error:&serializationError];
    if (timeoutInternal>0) {
        request.timeoutInterval = timeoutInternal;
    }
    if (serializationError) {
        if (weakSelf.responseHanler) {
            [weakSelf.responseHanler onParseWithSessionTask:nil responseObject:nil error:serializationError];
            if (failure) {
                if (isShowLoading) {
                    [KLCSLoadingDialog hideLoading];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    failure(weakSelf.responseHanler.resultCode, weakSelf.responseHanler.resultMessage, weakSelf.responseHanler.error);
                });
            }
        }
        return;
    }
    __block NSURLSessionDataTask *dataTask = nil;
    dataTask = [_sessionManager dataTaskWithRequest:request uploadProgress:uploadProgress downloadProgress:downloadProgress completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (weakSelf.responseHanler) {
            [weakSelf.responseHanler onParseWithSessionTask:dataTask responseObject:responseObject error:error];
            if (weakSelf.responseHanler.isRequestSuccess) {
                if (isShowLoading) {
                    [KLCSLoadingDialog hideLoading];
                }
                if (success) {
                    success(weakSelf.responseHanler.resultData);
                }
            }else {
                if (isShowLoading) {
                    [KLCSLoadingDialog hideLoading];
                }
                if (isShowErrorMessage) {
                    [KLCSLoadingDialog toast:weakSelf.responseHanler.resultMessage];
                }
                if (failure) {
                    failure(weakSelf.responseHanler.resultCode,weakSelf.responseHanler.resultMessage,weakSelf.responseHanler.error);
                }

            }
        }
    }];
    [dataTask resume];
    return;
    
}

@end
