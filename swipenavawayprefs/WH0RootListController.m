#include "WH0RootListController.h"
#define swipeNavAwayPath @"/User/Library/Preferences/com.wh0ba.swipenavawayprefs.plist"

// @interface FBSystemService : NSObject

// +(id)sharedInstance;
// - (void)exitAndRelaunch:(bool)arg1;

// @end


@implementation WH0RootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}

	return _specifiers;
}





/*
- (void)setPreferenceValue:(id)value specifier:(PSSpecifier*)specifier {
	NSString *path = [NSString stringWithFormat:@"/User/Library/Preferences/%@.plist", specifier.properties[@"defaults"]];
	NSMutableDictionary *settings = [NSMutableDictionary dictionary];
	[settings addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:path]];
	[settings setObject:value forKey:specifier.properties[@"key"]];
	[settings writeToFile:path atomically:YES];
	CFStringRef notificationName = (CFStringRef)specifier.properties[@"PostNotification"];
	if (notificationName) {
		CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), notificationName, NULL, NULL, YES);
	}
}*/



- (void)followme {
	UIApplication *app = [UIApplication sharedApplication];
	if ([app canOpenURL:[NSURL URLWithString:@"twitter://user?screen_name=wh0ba"]]) {
		[app openURL:[NSURL URLWithString:@"twitter://user?screen_name=wh0ba"]];
	} else if ([app canOpenURL:[NSURL URLWithString:@"tweetbot:///user_profile/wh0ba"]]) {
		[app openURL:[NSURL URLWithString:@"tweetbot:///user_profile/wh0ba"]];
	} else {
		[app openURL:[NSURL URLWithString:@"https://mobile.twitter.com/wh0ba"]];
	}
}

- (void)donatem {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.paypal.me/wh0ba"]];
}



@end
