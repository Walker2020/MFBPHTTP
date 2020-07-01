// AFNetworkActivityConsoleLogger.h
//
// Copyright (c) 2018 AFNetworking (http://afnetworking.com/)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "AFNetworkActivityConsoleLogger.h"

@implementation AFNetworkActivityConsoleLogger

- (id)init {
    self = [super init];
    if (!self) {
        return nil;
    }

    self.level = AFLoggerLevelInfo;

    return self;
}


- (void)URLSessionTaskDidStart:(NSURLSessionTask *)task {
    NSURLRequest *request = task.originalRequest;
    switch (self.level) {
        case AFLoggerLevelDebug:
            NSLog(@"\n=> Request Begin <= \n=> scheme: %@ \n=> host: %@ \n=> path: %@ \n=> method: %@ \n=> timeout: %0.f \n=> header: \%@ \n=> body: %@ \n=> Request End<=\n",request.URL.scheme,request.URL.host,request.URL.path,[request HTTPMethod],request.timeoutInterval,[request allHTTPHeaderFields],[self getHttpBodyWithRequest:request]);
            break;
        case AFLoggerLevelInfo:
            NSLog(@"\n=> Request Begin <= \n=> scheme: %@ \n=> host: %@ \n=> path: %@ \n=> method: %@ \n=> timeout: %0.f \n=> header: \%@ \n=> body: %@ \n=> Request End<=\n",request.URL.scheme,request.URL.host,request.URL.path,[request HTTPMethod],request.timeoutInterval,[request allHTTPHeaderFields],[self getHttpBodyWithRequest:request]);
            break;
        default:
            break;
    }
}

- (void)URLSessionTaskDidFinish:(NSURLSessionTask *)task withResponseObject:(id)responseObject inElapsedTime:(NSTimeInterval )elapsedTime withError:(NSError *)error {
    NSString * retCode = @"";
    NSString * retMessage = @"";
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        NSDictionary * dict = [NSDictionary dictionaryWithDictionary:responseObject];
        retCode = [dict objectForKey:@"retCode"];
        retMessage = [dict objectForKey:@"retMsg"];
    }
    NSURLRequest *request = task.originalRequest;
    NSUInteger responseStatusCode = 0;
    NSDictionary *responseHeaderFields = nil;
    if ([task.response isKindOfClass:[NSHTTPURLResponse class]]) {
        responseStatusCode = (NSUInteger)[(NSHTTPURLResponse *)task.response statusCode];
        responseHeaderFields = [(NSHTTPURLResponse *)task.response allHeaderFields];
    }

    if (error) {
        switch (self.level) {
            case AFLoggerLevelDebug:
            case AFLoggerLevelInfo:
            case AFLoggerLevelError:
                NSLog(@"\n=> Response Begin <= \n=> scheme: %@ \n=> host: %@ \n=> path: %@ \n=> method: %@ \n=> timeout: %0.f \n=> elapsedTime: %0.f \n=> header: \%@ \n=> code: \%@ \n=> message: \%@ \n=> body: %@ \n=> Response End <=\n",request.URL.scheme,request.URL.host,request.URL.path,[request HTTPMethod],[request timeoutInterval],elapsedTime,[request allHTTPHeaderFields],retCode,retMessage,responseObject);
                //                NSLog(@"[Error] %@ '%@' (%ld) [%.04f s]: %@", [task.originalRequest HTTPMethod], [[task.response URL] absoluteString], (long)responseStatusCode, elapsedTime, error);
            default:
                break;
        }
    } else {
        switch (self.level) {
            case AFLoggerLevelDebug:
                NSLog(@"\n=> Response Begin <=  \n=> scheme: %@ \n=> host: %@ \n=> path: %@ \n=> method: %@ \n=> timeout: %0.f \n=> elapsedTime: %0.f \n=> header: \%@ \n=> code: \%@ \n=> message: \%@ \n=> body: %@ \n=> Response End <=\n",request.URL.scheme,request.URL.host,request.URL.path,[request HTTPMethod],[request timeoutInterval],elapsedTime,[request allHTTPHeaderFields],retCode,retMessage,responseObject);
                //                NSLog(@"%ld '%@' [%.04f s]: %@ %@", (long)responseStatusCode, [[task.response URL] absoluteString], elapsedTime, responseHeaderFields, responseObject);
                break;
            case AFLoggerLevelInfo:
                NSLog(@"\n=> Response Begin <=  \n=> scheme: %@ \n=> host: %@ \n=> path: %@ \n=> method: %@ \n=> timeout: %0.f \n=> elapsedTime: %0.f \n=> header: \%@ \n=> code: \%@ \n=> message: \%@ \n=> body: %@ \n=> Response End <=\n",request.URL.scheme,request.URL.host,request.URL.path,[request HTTPMethod],[request timeoutInterval],elapsedTime,[request allHTTPHeaderFields],retCode,retMessage,responseObject);

                break;
            default:
                break;
        }
    }
}

-(NSDictionary *)getHttpBodyWithRequest:(NSURLRequest *)request {
    NSDictionary * bodyDict = [NSDictionary dictionary];
    if ([request.HTTPMethod isEqualToString:@"GET"]) {
        bodyDict = [self getUrlParameterWithUrl:request.URL];
    }
    if ([request HTTPBody]) {
        NSError *err;
        bodyDict = [NSJSONSerialization JSONObjectWithData:[request HTTPBody]
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
    }
    return bodyDict;
}

- (NSDictionary *)getUrlParameterWithUrl:(NSURL *)url {
    NSMutableDictionary *parm = [[NSMutableDictionary alloc]init];
    //传入url创建url组件类
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithString:url.absoluteString];
    //回调遍历所有参数，添加入字典
    if (@available(iOS 8.0, *)) {
        [urlComponents.queryItems enumerateObjectsUsingBlock:^(NSURLQueryItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [parm setObject:obj.value forKey:obj.name];
        }];
    } else {
        return nil;
    }
    return parm;
}

@end
