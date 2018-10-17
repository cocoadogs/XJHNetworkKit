//
//  XJHRequest+HUDDefalut.m
//  XJHNetworkKit
//
//  Created by xujunhao on 2018/9/13.
//

#import "XJHRequest+HUDDefalut.h"
#import <MBProgressHUD/MBProgressHUD.h>

#define XJHRequestKitImageNamed(name) [UIImage imageNamed:name inBundle:[NSBundle bundleWithURL:[[NSBundle bundleForClass:NSClassFromString(@"XJHRequest")] URLForResource:@"XJHNetworkKit" withExtension:@"bundle"]] compatibleWithTraitCollection:nil]

@implementation XJHRequest (HUDDefalut)

- (NSString *)progressPrompt {
	return @"";
}

- (NSString *)successPrompt {
	return @"";
}

- (NSString *)errorPrompt {
	NSError *error = [self valueForKeyPath:@"requestError"];
	return error.localizedDescription;
}

- (UIView *)progressView {
	UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
	[MBProgressHUD hideAllHUDsForView:window animated:YES];
	MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithWindow:window];
	HUD.square = NO;
	HUD.customView = nil;
	HUD.detailsLabelText = [self progressPrompt];
	HUD.detailsLabelColor = [UIColor whiteColor];
	HUD.mode = MBProgressHUDModeIndeterminate;
	return HUD;
}

- (UIView *)successView {
	UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
	[MBProgressHUD hideAllHUDsForView:window animated:YES];
	MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithWindow:window];
	HUD.mode = MBProgressHUDModeCustomView;
	HUD.customView = ({
		UIImageView *successImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
		successImageView.contentMode = UIViewContentModeScaleAspectFill;
		successImageView.clipsToBounds = YES;
		successImageView.image = [XJHRequestKitImageNamed(@"hud_success") imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
		successImageView.tintColor = [UIColor whiteColor];
		successImageView;
	});
	HUD.customView.tintColor = [UIColor whiteColor];
	HUD.square = NO;
	HUD.detailsLabelColor = [UIColor whiteColor];
	HUD.detailsLabelText = [self successPrompt];
	HUD.removeFromSuperViewOnHide = YES;
	return HUD;
}

- (UIView *)errorView {
	UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
	[MBProgressHUD hideAllHUDsForView:window animated:YES];
	MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithWindow:window];
	HUD.mode = MBProgressHUDModeCustomView;
	HUD.customView = ({
		UIImageView *successImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
		successImageView.contentMode = UIViewContentModeScaleAspectFill;
		successImageView.clipsToBounds = YES;
		successImageView.image = [XJHRequestKitImageNamed(@"hud_error") imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
		successImageView.tintColor = [UIColor whiteColor];
		successImageView;
	});
	HUD.customView.tintColor = [UIColor whiteColor];
	HUD.square = NO;
	HUD.detailsLabelColor = [UIColor whiteColor];
	HUD.detailsLabelText = [self errorPrompt];
	HUD.removeFromSuperViewOnHide = YES;
	return HUD;
}

- (void)showProgressHUD {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	if (self.showProgress) {
		UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
		MBProgressHUD *HUD = (MBProgressHUD *)[self progressView];
		[window addSubview:HUD];
		[HUD show:YES];
	}
}

- (void)showSuccessHUD {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	if (self.showSuccess) {
		UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
		MBProgressHUD *HUD = (MBProgressHUD *)[self successView];
		[window addSubview:HUD];
		[HUD show:YES];
		[HUD hide:YES afterDelay:1.5];
	}
}

- (void)showErrorHUD {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	if (self.showError) {
		UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
		MBProgressHUD *HUD = (MBProgressHUD *)[self errorView];
		[window addSubview:HUD];
		[HUD show:YES];
		[HUD hide:YES afterDelay:1.5];
	}
}

@end
