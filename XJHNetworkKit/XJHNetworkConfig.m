//
//  XJHNetworkConfig.m
//  XJHNetworkKit
//
//  Created by xujunhao on 2018/9/12.
//

#import "XJHNetworkConfig.h"
#import "XJHNetworkConfigParamsBuilder.h"
#import <YTKNetwork/YTKNetworkConfig.h>
#import <YTKNetwork/YTKNetworkAgent.h>

static XJHNetworkConfig *instance = nil;

@interface XJHNetworkConfig ()

@property (nonatomic, copy, readwrite) NSDictionary<NSString *,NSString *> *customHeaderFieldValueDictionary;
@property (nonatomic, assign, readwrite) BOOL useCustomRequest;
@property (nonatomic, assign, readwrite) BOOL useCustomHeader;

@end

@implementation XJHNetworkConfig

+ (instancetype)sharedInstance {
	return [[self alloc] init];
}

- (instancetype)init {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		instance = [super init];
	});
	return instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		instance = [super allocWithZone:zone];
	});
	return instance;
}

#pragma mark - Public Method


- (void)configNetwork:(XJHNetworkBaseConfiguration)configuration {
	XJHNetworkConfigParamsBuilder *configBuilder = [[XJHNetworkConfigParamsBuilder alloc] init];
	!configuration?:configuration(configBuilder);
	NSAssert(configBuilder.baseUrl, @"baseUrl不得为空");
	AFHTTPSessionManager *manager = configBuilder.sessionManager;
	manager.requestSerializer = configBuilder.requestSerializer;
	manager.responseSerializer = configBuilder.responseSerializer;
	YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
	config.baseUrl = configBuilder.baseUrl;
	if (configBuilder.useCDN) {
		config.cdnUrl = configBuilder.cdnUrl;
	}
	if (configBuilder.requestSecurityPolicy) {
		config.securityPolicy = configBuilder.securityPolicy;
	}
	self.customHeaderFieldValueDictionary = configBuilder.customHeaderFieldValueDictionary;
	self.useCustomHeader = configBuilder.useCustomHeader;
	self.useCustomRequest = configBuilder.useCustomRequest;
}

@end
