//
//  XJHRequest.m
//  XJHNetworkKit
//
//  Created by xujunhao on 2018/9/12.
//

#import "XJHRequest.h"
#import "XJHRequest+HUDDefalut.h"
#import "XJHNetworkConfig.h"
#import <ReactiveObjC/ReactiveObjC.h>

///请求超时s
const static NSInteger kTimeoutInterval = 60;

@interface XJHRequest ()

@property (nonatomic, copy) XJHRequestSuccess success;
@property (nonatomic, copy) XJHRequestFailure failure;
@property (nonatomic, copy) NSDictionary *page;
@property (nonatomic, strong) NSError *requestError;

@end

@implementation XJHRequest

#pragma mark - LifeCycle Method

- (instancetype)init {
	if (self = [super init]) {
		_showProgress = YES;
		_showError = YES;
		_showSuccess = NO;
		self.delegate = self;
	}
	return self;
}

- (void)dealloc {
	NSLog(@"API dealloc---%@", NSStringFromClass([self class]));
	if (!self.isCancelled) {
		[self stop];
	}
}

#pragma mark - Public Methods

- (void)startWithSuccess:(XJHRequestSuccess)success
				 failure:(XJHRequestFailure)failure {
	_success = [success copy];
	_failure = [failure copy];
	self.page = nil;
	@weakify(self)
	[self startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
		@strongify(self)
		!self.success?:self.success(request.responseObject);
	} failure:^(__kindof YTKBaseRequest * _Nonnull request) {
		@strongify(self)
		!self.failure?:self.failure(request.error);
	}];
}

- (void)startWithPage:(NSDictionary *)page
			  success:(XJHRequestSuccess)success
			  failure:(XJHRequestFailure)failure {
	self.page = page;
	@weakify(self)
	[self startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
		@strongify(self)
		!self.success?:self.success(request.responseObject);
	} failure:^(__kindof YTKBaseRequest * _Nonnull request) {
		@strongify(self)
		!self.failure?:self.failure(request.error);
	}];
}

#pragma mark - YTKBaseRequest Override Methods

- (void)startWithCompletionBlockWithSuccess:(nullable YTKRequestCompletionBlock)success
									failure:(nullable YTKRequestCompletionBlock)failure {
	[self.HUDDelegator showProgressHUD];
	@weakify(self)
	self.successCompletionBlock = ^(__kindof YTKBaseRequest * _Nonnull request) {
		@strongify(self)
		[self.HUDDelegator showSuccessHUD];
		success(request);
	};
	self.failureCompletionBlock = ^(__kindof YTKBaseRequest * _Nonnull request) {
		@strongify(self)
		self.requestError = request.error;
		[self.HUDDelegator showErrorHUD];
		failure(request);
	};
	[self start];
}

- (void)clearCompletionBlock {
	[super clearCompletionBlock];
	self.success = nil;
	self.failure = nil;
}

- (NSString *)baseUrl
{
	return [YTKNetworkConfig sharedConfig].baseUrl;
}

- (NSTimeInterval)requestTimeoutInterval {
	return kTimeoutInterval;
}

- (YTKRequestSerializerType)requestSerializerType {
	return YTKRequestSerializerTypeHTTP;
}

- (YTKResponseSerializerType)responseSerializerType {
	return YTKResponseSerializerTypeJSON;
}

- (YTKRequestMethod)requestMethod {
	return YTKRequestMethodPOST;
}

- (NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary {
	if ([XJHNetworkConfig sharedInstance].useCustomHeader) {
		return [XJHNetworkConfig sharedInstance].customHeaderFieldValueDictionary;
	}
	return nil;
}

- (NSURLRequest *)buildCustomUrlRequest {
	if ([XJHNetworkConfig sharedInstance].useCustomRequest) {
		if (self.requestMethod == YTKRequestMethodPOST) {
			NSAssert([self requestHeaderFieldValueDictionary], @"自定义Header不得为空");
			NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [self baseUrl], [self requestUrl]]] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
			[request setHTTPMethod:@"POST"];
			[request setAllHTTPHeaderFields:[self requestHeaderFieldValueDictionary]];
			[request setHTTPBody:self.httpBody];
			return request;
		}
	}
	return nil;
}

#pragma mark - XJHRequestHUDProtocol Delegate Method

- (NSString *)errorPrompt {
	return self.requestError.localizedDescription;
}


#pragma mark - Lazy Load Methods

- (NSMutableDictionary *)params {
	if (!_params) {
		_params = [[NSMutableDictionary alloc] initWithCapacity:10];
	}
	if (self.page.allKeys.count > 0) {
		[_params addEntriesFromDictionary:self.page];
	}
	return _params;
}

- (NSObject<XJHRequestHUDProtocol> *)HUDDelegator {
	if (!_HUDDelegator) {
		_HUDDelegator = self;
	}
	return _HUDDelegator;
}


@end
