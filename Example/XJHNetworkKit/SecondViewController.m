//
//  SecondViewController.m
//  XJHNetworkKit_Example
//
//  Created by xujunhao on 2018/9/13.
//  Copyright © 2018年 cocoadogs. All rights reserved.
//

#import "SecondViewController.h"
#import <Masonry/Masonry.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import <XJHNetworkKit/XJHNetworkKit.h>
#import "HJMoodListAPI.h"

@interface SecondViewController ()

@property (nonatomic, strong) UIButton *networkBtn;
@property (nonatomic, strong) HJMoodListAPI *listApi;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	[self buildUI];
	[self configNetwork];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
	NSLog(@"---SecondViewController---dealloc---");
}

#pragma mark - UI Build Method

- (void)buildUI {
	self.view.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:self.networkBtn];
	[self.networkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
		make.center.equalTo(self.view);
		make.size.mas_equalTo(CGSizeMake(100, 40));
	}];
}

#pragma mark - Private Method

- (void)configNetwork {
	[[XJHNetworkConfig sharedInstance] configNetwork:^(XJHNetworkConfigParamsBuilder *builder) {
		builder.baseUrl = @"http://101.37.88.191:8080";
	}];
}

- (void)testNetwork {
	[self.listApi startWithSuccess:^(id responseObject) {
		NSLog(@"响应数据 = %@", responseObject);
	} failure:^(NSError *error) {
		NSLog(@"响应错误 = %@", error);
	}];
}

#pragma mark - Lazy Load Methods

-(HJMoodListAPI *)listApi {
	if (!_listApi) {
		_listApi = [[HJMoodListAPI alloc] init];
	}
	return _listApi;
}

- (UIButton *)networkBtn {
	if (!_networkBtn) {
		_networkBtn = [[UIButton alloc] init];
		[_networkBtn setTitle:@"网络请求" forState:UIControlStateNormal];
		[_networkBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
		[_networkBtn setBackgroundColor:[UIColor whiteColor]];
		_networkBtn.layer.cornerRadius = 5.0f;
		_networkBtn.layer.borderWidth = 0.5f;
		_networkBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
		@weakify(self)
		[[_networkBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
			@strongify(self)
			[self testNetwork];
		}];
	}
	return _networkBtn;
}

@end
