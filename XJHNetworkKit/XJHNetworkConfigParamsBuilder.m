//
//  XJHNetworkConfigParamsBuilder.m
//  XJHNetworkKit
//
//  Created by xujunhao on 2018/9/12.
//

#import "XJHNetworkConfigParamsBuilder.h"
#import <YTKNetwork/YTKNetworkAgent.h>

@implementation XJHNetworkConfigParamsBuilder

- (AFHTTPSessionManager *)sessionManager {
	return _sessionManager?:[self defaultSessionManager];
}

- (AFHTTPRequestSerializer<AFURLRequestSerialization> *)requestSerializer {
	return _requestSerializer ?: [self defaultRequestSerializer];
}

- (AFHTTPResponseSerializer<AFURLResponseSerialization> *)responseSerializer {
	return _responseSerializer ?: [self defaultResponseSerializer];
}

- (NSString *)baseUrl {
	return _baseUrl;
}

- (NSString *)cdnUrl {
	return _cdnUrl;
}

- (NSDictionary<NSString *,NSString *> *)customHeaderFieldValueDictionary {
	return _customHeaderFieldValueDictionary;
}

#pragma mark - Default Value Methods

- (AFHTTPSessionManager *)defaultSessionManager {
	YTKNetworkAgent *agent = [YTKNetworkAgent sharedAgent];
	return [agent valueForKeyPath:@"_manager"];
}

- (AFHTTPRequestSerializer<AFURLRequestSerialization> *)defaultRequestSerializer {
	AFJSONRequestSerializer *serializer = [AFJSONRequestSerializer serializer];
	[serializer setValue:@"application/json" forHTTPHeaderField:@"content-type"];
	[serializer setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
	return serializer;
}

- (AFHTTPResponseSerializer<AFURLResponseSerialization> *)defaultResponseSerializer {
	AFJSONResponseSerializer *serializer = [AFJSONResponseSerializer serializer];
	serializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", @"text/css", @"image/jpeg", @"image/png", nil];
	serializer.removesKeysWithNullValues = YES;
	serializer.acceptableStatusCodes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(100, 500)];
	return serializer;
}

- (AFSecurityPolicy *)defaultSecurityPolicy {
	// 先导入证书 证书由服务端生成，具体由服务端人员操作，xxx为具体证书对应主域名
	NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"_.xxx.com" ofType:@"cer"];//证书的路径
	NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
	NSSet *cerSet = [NSSet setWithObject:cerData];
	
	// AFSSLPinningModeCertificate 使用证书验证模式
	AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey withPinnedCertificates:cerSet];
	// allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
	// 如果是需要验证自建证书，需要设置为YES
	securityPolicy.allowInvalidCertificates = YES;
	
	//validatesDomainName 是否需要验证域名，默认为YES;
	//假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
	//置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
	//如置为NO，建议自己添加对应域名的校验逻辑。
	securityPolicy.validatesDomainName = NO;
	return securityPolicy;
}

@end
