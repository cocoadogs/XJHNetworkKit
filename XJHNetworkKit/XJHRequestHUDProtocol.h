//
//  XJHRequestHUDProtocol.h
//  XJHNetworkKit
//
//  Created by xujunhao on 2018/9/13.
//

#import <Foundation/Foundation.h>

@protocol XJHRequestHUDProtocol <NSObject>

@optional

/**
 等待加载提示语，默认为空
 
 @return 等待提示语
 */
- (NSString *)progressPrompt;

/**
 成功提示语，默认为空
 
 @return 成功提示语
 */
- (NSString *)successPrompt;

/**
 失败提示语，默认为"请求失败"
 
 @return 失败提示语
 */
- (NSString *)errorPrompt;

/**
 等待状态视图
 
 @return view
 */
- (UIView *)progressView;

/**
 成功状态视图
 
 @return view
 */
- (UIView *)successView;

/**
 失败状态视图
 
 @return view
 */
- (UIView *)errorView;

/**
 显示加载等待状态视图
 */
- (void)showProgressHUD;

/**
 显示加载成功状态视图
 */
- (void)showSuccessHUD;

/**
 显示加载失败状态视图
 */
- (void)showErrorHUD;

@end
