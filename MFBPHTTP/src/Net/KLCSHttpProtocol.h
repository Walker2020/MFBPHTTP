//
//  KLCSHttpProtocol.h
//  Pods
//
//  Created by DengJinHui on 2020/3/12.
//

#ifndef KLCSHttpProtocol_h
#define KLCSHttpProtocol_h
@protocol KLCSHttpResponseProtocol <NSObject>
@property(nonatomic, assign, readonly)BOOL isRequestSuccess;
@property(nonatomic, copy, readonly) NSString * resultMessage;
@property(nonatomic, copy, readonly) NSString * resultCode;
@property(nonatomic, strong, readonly)id resultData;
@property(nonatomic, strong, readonly)NSError * error;
-(void) onParseWithSessionTask:(NSURLSessionTask*)task responseObject:(id)responseObject error:(NSError *)error;
@end

#endif /* KLCSHttpProtocol_h */
