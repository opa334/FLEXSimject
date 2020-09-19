#import "FLEXManager.h"

%group Keyboard

%hook mainVC

- (NSArray<UIKeyCommand *> *)keyCommands
{
	NSArray<UIKeyCommand *> *orig = %orig;

	UIKeyCommand* flexKeyCommand = [UIKeyCommand keyCommandWithInput:@"f" modifierFlags:UIKeyModifierAlternate action:@selector(flexKeyPressed:)];

	if(orig)
	{
		return [orig arrayByAddingObject:flexKeyCommand];
	}
	else
	{
		return @[flexKeyCommand];
	}
}

%new
- (void)flexKeyPressed:(id)sender
{
	[[FLEXManager sharedManager] showExplorer];
}

%end

%end

void appOrSceneLoaded(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo)
{
	Class mainVC = [UIApplication sharedApplication].keyWindow.rootViewController.class;

	if(mainVC)
	{
		static dispatch_once_t onceToken;
		dispatch_once (&onceToken, ^
		{
			%init(Keyboard, mainVC=mainVC);
		});
	}
}

%ctor
{
	CFNotificationCenterAddObserver(CFNotificationCenterGetLocalCenter(), NULL, appOrSceneLoaded, (CFStringRef)UIApplicationDidFinishLaunchingNotification, NULL, CFNotificationSuspensionBehaviorCoalesce);
	CFNotificationCenterAddObserver(CFNotificationCenterGetLocalCenter(), NULL, appOrSceneLoaded, (CFStringRef)UISceneWillConnectNotification, NULL, CFNotificationSuspensionBehaviorCoalesce);
}
