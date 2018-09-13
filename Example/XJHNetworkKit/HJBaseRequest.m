//
//  HJBaseRequest.m
//  XJHNetworkKit_Example
//
//  Created by xujunhao on 2018/9/13.
//  Copyright © 2018年 cocoadogs. All rights reserved.
//

#import "HJBaseRequest.h"

@implementation HJBaseRequest

- (void)requestFinished:(__kindof YTKBaseRequest *)request {
	NSLog(@"请求成功了，不一定是真的成功了");
}

- (void)requestFailed:(__kindof YTKBaseRequest *)request {
	NSLog(@"请求失败了，好伤心");
}

@end
