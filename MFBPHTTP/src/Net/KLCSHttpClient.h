//
//  KLCSHttpClient.h
//  AFNetworking
//
//  Created by DengJinHui on 2019/11/14.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "KLCSJSONObject.h"
#import "KLCSJSONArray.h"


typedef void(^KLCSHttpSessionTaskFailure)(NSString *_Nonnull resultCode, NSString *_Nonnull resultMessage, NSError *_Nonnull error);
typedef void(^KLCSHttpSessionTaskSuccess)(id _Nonnull resultData);
typedef void(^KLCSHttpSessionTaskProgress)(NSProgress * _Nullable progress);
typedef void(^KLCSHttpCompletionHandler)(void);


typedef enum : NSUInteger {
    KLCSHttpMethodGET,
    KLCSHttpMethodPOST,
} KLCSHttpMethod;



@interface KLCSHttpClient : NSObject
@property(nonatomic, assign)BOOL isShowLoading;
@property(nonatomic, assign)BOOL isShowErroToast;
@property(nonatomic, copy) NSString * _Nullable loadingMaskText;
+(KLCSHttpClient * _Nonnull)instance;


-(void)POSTWithURLString:(NSString * _Nullable)URLString
              parameters:(NSDictionary *_Nullable)parameters
                 success:(KLCSHttpSessionTaskSuccess _Nullable)success
                 failure:(KLCSHttpSessionTaskFailure _Nullable)failure;

-(void)POSTWithURLString:(NSString * _Nullable)URLString
              parameters:(NSDictionary * _Nullable)parameters
           isShowLoading:(BOOL)isShowLoading
                 success:(KLCSHttpSessionTaskSuccess _Nullable)success
                 failure:(KLCSHttpSessionTaskFailure _Nullable)failure;

-(void)POSTWithURLString:(NSString * _Nullable)URLString
              parameters:(NSDictionary * _Nullable)parameters
           isShowLoading:(BOOL)isShowLoading
      isShowErrorMessage:(BOOL)isShowErrorMessage
                 success:(KLCSHttpSessionTaskSuccess _Nullable)success
                 failure:(KLCSHttpSessionTaskFailure _Nullable)failure;


-(void)GETWithURLString:(NSString * _Nullable)URLString
             parameters:(NSDictionary * _Nullable)parameters
                success:(KLCSHttpSessionTaskSuccess _Nullable)success
                failure:(KLCSHttpSessionTaskFailure _Nullable)failure;

-(void)GETWithURLString:(NSString *_Nullable)URLString
             parameters:(nullable NSDictionary *)parameters
          isShowLoading:(BOOL)isShowLoading
                success:(KLCSHttpSessionTaskSuccess _Nullable )success
                failure:(KLCSHttpSessionTaskFailure _Nullable )failure;

-(void)GETWithURLString:(NSString *_Nullable)URLString
             parameters:(nullable NSDictionary *)parameters
          isShowLoading:(BOOL)isShowLoading
     isShowErrorMessage:(BOOL)isShowErrorMessage
                success:(KLCSHttpSessionTaskSuccess _Nullable )success
                failure:(KLCSHttpSessionTaskFailure _Nullable )failure;



-(void)requestWithMethod:(NSString * _Nullable)method
               URLString:(NSString * _Nullable)URLString
              parameters:(NSDictionary * _Nullable)parameters
                 success:(KLCSHttpSessionTaskSuccess _Nullable)success
                 failure:(KLCSHttpSessionTaskFailure _Nullable)failure;

-(void)requestWithMethod:(NSString * _Nullable)method
               URLString:(NSString * _Nullable)URLString
              parameters:(NSDictionary * _Nullable)parameters
           isShowLoading:(BOOL)isShowLoading
                 success:(KLCSHttpSessionTaskSuccess _Nullable)success
                 failure:(KLCSHttpSessionTaskFailure _Nullable)failure;

-(void)requestWithMethod:(NSString * _Nullable)method
               URLString:(NSString * _Nullable)URLString
              parameters:(NSDictionary * _Nullable)parameters
           isShowLoading:(BOOL)isShowLoading
      isShowErrorMessage:(BOOL)isShowErrorMessage
                 success:(KLCSHttpSessionTaskSuccess _Nullable)success
                 failure:(KLCSHttpSessionTaskFailure _Nullable)failure;


-(void)requestWithMethod:(NSString * _Nullable)method
               URLString:(NSString * _Nullable)URLString
              parameters:(NSDictionary * _Nullable)parameters
          uploadProgress:(KLCSHttpSessionTaskProgress _Nullable)uploadProgress
        downloadProgress:(KLCSHttpSessionTaskProgress _Nullable)downloadProgress
                 success:(KLCSHttpSessionTaskSuccess _Nullable)success
                 failure:(KLCSHttpSessionTaskFailure _Nullable)failure;


-(void)requestWithMethod:(NSString *_Nullable)method
               URLString:(NSString *_Nullable)URLString
              parameters:(NSDictionary *_Nullable)parameters
           isShowLoading:(BOOL)isShowLoading
      isShowErrorMessage:(BOOL)isShowErrorMessage
         loadingMaskText:(NSString *_Nullable)loadingMaskText
         timeoutInternal:(NSTimeInterval)timeoutInternal
          uploadProgress:(KLCSHttpSessionTaskProgress _Nullable)uploadProgress
        downloadProgress:(KLCSHttpSessionTaskProgress _Nullable)downloadProgress
                 success:(KLCSHttpSessionTaskSuccess _Nullable)success
                 failure:(KLCSHttpSessionTaskFailure _Nullable)failure;


@end

