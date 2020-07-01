//
//  KLCSErrorCode.h
//  Pods
//
//  Created by DengJinHui on 2020/3/12.
//

#ifndef KLCSErrorCode_h
#define KLCSErrorCode_h
#define KLCS_COMMONLIBRARY_MIN_ERROR 1000
#define KLCS_COMMONLIBRARY_MAX_ERROR 2999

typedef enum : NSInteger {
    KLCSCodeSuccess = 0,
    /*错误码范围 1000～2999*/
    KLCSCodeTimeout = KLCS_COMMONLIBRARY_MIN_ERROR,    /* Http 请求超时*/
    KLCSCodeServerError,                                 /* Web 服务器错误，如 500，404 等*/
    KLCSCodeCannotConnectToHost,                         /* 无法连接到主机*/
    KLCSCodeOtherError,                                  /* Htpp 请求错误*/
    KLCSCodeNetworkUnrechableError,                               /* 无网络或不可用 */
    KLCSCodeCreateNetworkOperationFail,                           /* 创建网络请求失败*/
    KLCSCodeServerCertificateInvaild,                             /* 证书无效*/
    KLCSCodeServerCertificateHasBadDate,                          /* 证书过期*/
    KLCSCodeErrorNotConnectedToInternet,                          /* 当在发出请求后，断开网络会报此错误*/
    KLCSCodeInvalidParameter = 1020,
    /*无效参数*/
    /*错误码范围 4000～5999*/
    KLCSCodeServerResultErrorCode = 4000,                       /* 服务器返回了一个错误消息*/
    KLCSCodeServerResultDataInvalid,
    KLCSCodeUnkown,
} KLCSCode;


#endif /* KLCSErrorCode_h */
