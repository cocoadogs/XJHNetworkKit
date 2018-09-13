//
//  XJHNetworkConfigParamsBuilder.h
//  XJHNetworkKit
//
//  Created by xujunhao on 2018/9/12.
//  XJHNetworkConfig配置参数

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface XJHNetworkConfigParamsBuilder : NSObject

#pragma mark - AFHTTPSessionManager Property

///AFHTTPSessionManager
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

///AFHTTPSessionManager的requestSerializer，eg：AFJSONRequestSerializer
@property (nonatomic, strong) AFHTTPRequestSerializer<AFURLRequestSerialization> *requestSerializer;

///AFHTTPSessionManager的responseSerializer，eg：AFJSONResponseSerializer
@property (nonatomic, strong) AFHTTPResponseSerializer<AFURLResponseSerialization> *responseSerializer;

#pragma mark - YTKNetworkConfig Property

///baseUrl
@property (nonatomic, copy) NSString *baseUrl;

///CDN Url
@property (nonatomic, copy) NSString *cdnUrl;

///AFHTTPSessionManager安全策略，eg：HTTPS
@property (nonatomic, strong) AFSecurityPolicy *securityPolicy;

///是否开启安全验证策略，默认为NO
@property (nonatomic, assign) BOOL requestSecurityPolicy;

///是否开启CND，默认为NO
@property (nonatomic, assign) BOOL useCDN;

#pragma mark - Custom Property

///是否启用自定义request，默认不启用
@property (nonatomic, assign) BOOL useCustomRequest;

///是否使用自定义请求头，默认为NO
@property (nonatomic, assign) BOOL useCustomHeader;

///自定义HTTP Header信息字典，默认为nil
@property (nonatomic, copy) NSDictionary<NSString *,NSString *> *customHeaderFieldValueDictionary;

@end
