//
//  XJHRequest.h
//  XJHNetworkKit
//
//  Created by xujunhao on 2018/9/12.
//

#import <YTKNetwork/YTKNetwork.h>
#import "XJHRequestHUDProtocol.h"

typedef void(^XJHRequestSuccess)(id responseObject);
typedef void(^XJHRequestFailure)(NSError *error);

@interface XJHRequest : YTKRequest<YTKRequestDelegate, XJHRequestHUDProtocol>

///是否显示加载等待状态，默认为YES
@property (nonatomic, assign) BOOL showProgress;

///是否显示加载成功状态，默认为NO
@property (nonatomic, assign) BOOL showSuccess;

///是否显示加载失败状态，默认为YES
@property (nonatomic, assign) BOOL showError;

///HUD处理委托对象，默认为自己
@property (nonatomic, strong) NSObject<XJHRequestHUDProtocol> *HUDDelegator;

///请求参数
@property (nonatomic, strong) NSMutableDictionary *params;

///自定义请求body，仅在useCustomRequest=YES下使用
@property (nonatomic, strong) NSData *httpBody;

/**
 不带分页获取数据

 @param success 请求成功
 @param failure 请求失败
 */
- (void)startWithSuccess:(XJHRequestSuccess)success
				 failure:(XJHRequestFailure)failure;

/**
 带分页获取数据

 @param page 分页参数
 @param success 请求成功
 @param failure 请求失败
 */
- (void)startWithPage:(NSDictionary *)page
			  success:(XJHRequestSuccess)success
			  failure:(XJHRequestFailure)failure;

@end
