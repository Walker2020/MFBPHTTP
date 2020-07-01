//
//  KLCSLoadingDialog.h
//  KLCSSDKClient
//
//  Created by LKL on 2020/3/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KLCSLoadingDialog : NSObject
/**
 *  是否显示变淡效果，默认为YES，  PS：只为 showPermanentToast:(NSString *)toast 和 showLoading 方法添加
 */
+ (void)showGloomy:(BOOL)isShow;
/**
 *  显示“加载中”，带圈圈，若要修改直接修改kLoadingMessage的值即可
 */
+ (void)showLoading;

/**
 *  自定义等待提示语，效果同showLoading
 *
 *  @param text 提示语
 */
+ (void)showLoadingWithText:(NSString *)text;

/// 显示文本
/// @param message 文本信息
+ (void)toast:(NSString *)message;

/**
 *  显示简短的提示语，默认2秒钟，时间可直接修改kShowTime
 *
 *  @param toast 提示信息
 */
+ (void)showBriefToast:(NSString *)message;


/**
 自定义加载视图
 @param imageName 图片名字
 @param message 标题
 */
+(void)showToasttWithCustomImage:(NSString *)imageName toast:(NSString *)message;

/**
 自定义提示的显示时间，默认横屏
 @param message 提示语
 @param showTime 提示时间
 */
+ (void)showBriefToast:(NSString *)message time:(NSTimeInterval)showTime;

/**
 *  隐藏loading
 */
+(void)hideLoading;

@end

@interface GloomyView : UIView<UIGestureRecognizerDelegate>

@end

NS_ASSUME_NONNULL_END
