//
//  KLCSLoadingDialog.m
//  KLCSSDKClient
//
//  Created by LKL on 2020/3/20.
//

#import "KLCSLoadingDialog.h"
#import <MBProgressHUD/MBProgressHUD.h>

#define kScreen_height  [[UIScreen mainScreen] bounds].size.height
#define kScreen_width   [[UIScreen mainScreen] bounds].size.width
#define kDefaultRect     CGRectMake(0, 0, kScreen_width, kScreen_height)

#define kDefaultView [[UIApplication sharedApplication] keyWindow]

#define kGloomyBlackColor  [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]
#define kGloomyClearCloler  [UIColor colorWithRed:1 green:1 blue:1 alpha:0]

/* 默认网络提示，可在这统一修改 */
static NSString *const kLoadingMessage = @"加载中";

/* 默认简短提示语显示的时间，在这统一修改 */
static NSTimeInterval const   kShowTime  = 2.5;

/* 手势是否可用，默认yes，轻触屏幕提示框隐藏 */
static BOOL isAvalibleTouch = NO;

@implementation KLCSLoadingDialog

UIView *gloomyView;//深色背景
UIView *prestrainView;//预加载view
BOOL isShowGloomy;//是否显示深色背景

#pragma mark -- 类初始化
+ (void)initialize {
    if (self == [KLCSLoadingDialog self]) {
        [self customView];
    }
}

#pragma mark -- 初始化gloomyView
+ (void)customView {
    gloomyView = [[GloomyView alloc] initWithFrame:kDefaultRect];
    gloomyView.backgroundColor = kGloomyBlackColor;
    gloomyView.hidden = YES;
    isShowGloomy = NO;
}

+ (void)showGloomy:(BOOL)isShow {
    isShowGloomy = isShow;
}

#pragma mark - 加载在window上的提示框
+ (void)showLoading {
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:gloomyView];
        hud.removeFromSuperViewOnHide = YES;
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.bezelView.color = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        hud.contentColor = UIColor.whiteColor;
        if (isShowGloomy) {
            [self showBlackGloomyView];
        }else {
            [self showClearGloomyView];
        }
        [gloomyView addSubview:hud];
        [hud showAnimated:YES];
    });
}

+ (void)showLoadingWithText:(NSString *)text {
//    if (text == nil) {
//        text = KLCSLocalizedString(@"waiting", nil);
//    }
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:gloomyView];
        hud.label.text = text;
        hud.removeFromSuperViewOnHide = YES;
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.bezelView.color = [[UIColor blackColor] colorWithAlphaComponent:1];
        hud.contentColor = UIColor.whiteColor;
        if (isShowGloomy) {
            [self showBlackGloomyView];
        }else {
            [self showClearGloomyView];
        }
        [gloomyView addSubview:hud];
        [hud showAnimated:YES];
    });
}

+ (void)toast:(NSString *)message {
    [self showBriefToast:message];
}

+ (void)showBriefToast:(NSString *)message {
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kDefaultView animated:YES];
        hud.detailsLabel.text = message;
        hud.detailsLabel.font = [UIFont systemFontOfSize:14];
        hud.contentColor = UIColor.whiteColor;
        hud.animationType = MBProgressHUDAnimationZoom;
        hud.mode = MBProgressHUDModeText;
        hud.margin = 10.f;
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.bezelView.color = [[UIColor blackColor] colorWithAlphaComponent:1];
        
        hud.removeFromSuperViewOnHide = YES;
        [hud hideAnimated:NO afterDelay:kShowTime];
    });
}

+ (void)showBriefToast:(NSString *)message time:(NSTimeInterval)showTime {
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kDefaultView animated:YES];
        hud.detailsLabel.text = message;
        hud.detailsLabel.font = [UIFont systemFontOfSize:14];
        hud.contentColor = UIColor.whiteColor;
        hud.animationType = MBProgressHUDAnimationZoom;
        hud.mode = MBProgressHUDModeText;
        hud.margin = 10.f;
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.bezelView.color = [[UIColor blackColor] colorWithAlphaComponent:1];
        
        hud.removeFromSuperViewOnHide = YES;
        [hud hideAnimated:NO afterDelay:showTime];
    });
}

+ (void)showToasttWithCustomImage:(NSString *)imageName toast:(NSString *)message {
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kDefaultView animated:YES];
        UIImageView *littleView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 37, 37)];
        littleView.image = [UIImage imageNamed:imageName];
        hud.customView = littleView;
        hud.removeFromSuperViewOnHide = YES;
        hud.animationType = MBProgressHUDAnimationZoom;
        hud.label.text = message;
        hud.mode = MBProgressHUDModeCustomView;
        [hud showAnimated:YES];
        [hud hideAnimated:YES afterDelay:kShowTime];
    });
}

+(void)hideLoading {
        MBProgressHUD *hud = [KLCSLoadingDialog HUDForView:gloomyView];
    
        gloomyView.center = prestrainView ? prestrainView.center: [UIApplication sharedApplication].keyWindow.center;
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.3
                             animations:^{
                                hud.alpha = 0;
                                gloomyView.alpha = 0;
                             } completion:^(BOOL finished) {
                                [hud removeFromSuperview];
                                [gloomyView removeFromSuperview];
                             }];


        });
}

#pragma mark -   获取view上的hud
+ (MBProgressHUD *)HUDForView:(UIView *)view {
    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:[MBProgressHUD class]]) {
            return (MBProgressHUD *)subview;
        }
    }
    return nil;
}

#pragma mark -   GloomyView背景色
+ (void)showBlackGloomyView {
    gloomyView.backgroundColor = kGloomyBlackColor;
    [self gloomyConfig];
}

+ (void)showClearGloomyView {
    gloomyView.backgroundColor = kGloomyClearCloler;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self gloomyConfig];
    });
}

#pragma mark -   决定GloomyView add到已给view或者window上
+ (void)gloomyConfig {
    gloomyView.hidden = NO;
    gloomyView.alpha = 1;
    if (prestrainView) {
        [prestrainView addSubview:gloomyView];
    }else {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        if (![window.subviews containsObject:gloomyView]) {
            [window addSubview:gloomyView];
        }
    }
}

@end

@implementation GloomyView

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (isAvalibleTouch) {
        [KLCSLoadingDialog hideLoading];
    }
}

@end
