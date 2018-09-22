



@interface UIStatusBar: UIView

-(void)setHidden:(BOOL)hide animated:(BOOL)anim;

@end


static BOOL statusHide = YES;
//static BOOL isSettings = NO;



@interface UINavigationController (GestureRe) <UIGestureRecognizerDelegate>

- (void)hideSbar:(BOOL)shouldHide;


@end



%group Hooks

%hook UINavigationController


//BOOL toolbarhid = YES;


- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
	
	%orig;
	
	
	//toolbarhid = [self isToolbarHidden];
	self.hidesBarsOnSwipe = YES;
	
	self.interactivePopGestureRecognizer.delegate = self;
	
	//self.interactivePopGestureRecognizer.tagg = getag;
	
	return self;
	
}
- (instancetype)initWithNavigationBarClass:(Class)navigationBarClass toolbarClass:(Class)toolbarClass {
	
		%orig;
	
	
	//toolbarhid = [self isToolbarHidden];
	self.hidesBarsOnSwipe = YES;
	self.interactivePopGestureRecognizer.delegate = self;
	
	return self;
	
	
}
	
	- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	
	%orig;
	
	self.hidesBarsOnSwipe = YES;
	self.interactivePopGestureRecognizer.delegate = self;
	
	
	return self;
	}


#pragma mark pushViewController

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
	
	%orig;
	
	[self setNavigationBarHidden:NO animated:NO];
	//HBLogDebug(@"push view controller");
	
	[self hideSbar:NO];
	
	self.hidesBarsOnSwipe = YES;
	
	self.interactivePopGestureRecognizer.delegate = self;
	
	
	
}



-(void)setNavigationBarHidden:(BOOL)hide  animated:(BOOL)anim {
	%orig;
	//HBLogDebug(@"setNavHidden:%@",hide? @"yes":@"no");
	if (statusHide) {
		[self hideSbar:hide];
	}else {
		[self hideSbar:NO];
	}
	self.interactivePopGestureRecognizer.delegate = self;
	
}







%new
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gR {

	return YES;
}

%new
- (void)hideSbar:(BOOL)shouldHide {
	
	
	@autoreleasepool{
		UIStatusBar *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
		
		if ([statusBar respondsToSelector:@selector(setHidden:animated:)]) {
		[statusBar setHidden:shouldHide animated:NO];
		}
	}
	
}


//End UINavigationController hook
%end

// End Hooks Group
%end

#define statusPrefs @"/private/var/mobile/Library/Preferences/com.wh0ba.NavAway.statusbar.plist"
#define appsPrefs @"/private/var/mobile/Library/Preferences/com.wh0ba.NavAway.plist"
#define kNotiName CFSTR("com.wh0ba.NavAway/settingschanged")

static NSDictionary *blacklist;
static NSDictionary *statusBarBlackList;

static void reloadPrefs(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
	
	
	
	blacklist = [[NSDictionary alloc] initWithContentsOfFile:appsPrefs];
	statusBarBlackList = [[NSDictionary alloc] initWithContentsOfFile:statusPrefs];
	NSString *bundleid; 
	bundleid = [[NSBundle mainBundle] bundleIdentifier];
	if ([[statusBarBlackList objectForKey:bundleid] boolValue]) {
		statusHide = NO;
	}else {
		statusHide = YES;
	}
	
}

%dtor {
	
	
	CFNotificationCenterRemoveObserver(CFNotificationCenterGetDarwinNotifyCenter() //center
		, NULL //observer
		, kNotiName //name
		, NULL //object
		);
	
	
	
	
}


%ctor {
	@autoreleasepool{
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter() //center
		, NULL //observer
		, reloadPrefs //callBack
		, kNotiName //name
		, NULL //object
		, CFNotificationSuspensionBehaviorDeliverImmediately //suspensionBehavior
		);
	reloadPrefs(NULL,NULL,NULL,NULL,NULL);

	static NSString *bundle;
	 bundle = [[NSBundle mainBundle] bundleIdentifier];
	/*
	if ([bundle isEqualToString:@"com.apple.Preferences"]) {
		isSettings = YES
	}else {
		isSettings = NO
	}*/
	
	if ([[blacklist objectForKey:bundle] boolValue]) {
		%init(Hooks);
	}
	}
}