//
//  XJHNetworkConfig.h
//  XJHNetworkKit
//
//  Created by xujunhao on 2018/9/12.
//  XJHNetwork整体配置

#import <Foundation/Foundation.h>
@class XJHNetworkConfigParamsBuilder;

typedef void(^XJHNetworkBaseConfiguration)(XJHNetworkConfigParamsBuilder *builder);

@interface XJHNetworkConfig : NSObject

+ (instancetype)sharedInstance;

///自定义HTTP Header信息字典
@property (nonatomic, copy, readonly) NSDictionary<NSString *,NSString *> *customHeaderFieldValueDictionary;

///是否启用自定义request，默认不启用
@property (nonatomic, assign, readonly) BOOL useCustomRequest;

///是否启用自定header，默认不启动
@property (nonatomic, assign, readonly) BOOL useCustomHeader;


- (void)configNetwork:(XJHNetworkBaseConfiguration)configuration;

@end
