//
//  HJMoodListAPI.m
//  XJHNetworkKit_Example
//
//  Created by xujunhao on 2018/9/13.
//  Copyright © 2018年 cocoadogs. All rights reserved.
//

#import "HJMoodListAPI.h"

@implementation HJMoodListAPI

- (NSString *)requestUrl {
	return @"/api/market/coin_price";
}

- (id)requestArgument {
	return self.params;
}

- (YTKRequestMethod)requestMethod {
	return YTKRequestMethodGET;
}

@end
