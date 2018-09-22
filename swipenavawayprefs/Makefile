GO_EASY_ON_ME = 1



include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = NavAway
${BUNDLE_NAME}_FILES = WH0RootListController.m
${BUNDLE_NAME}_INSTALL_PATH = /Library/PreferenceBundles
${BUNDLE_NAME}_FRAMEWORKS = UIKit
${BUNDLE_NAME}_PRIVATE_FRAMEWORKS = Preferences
${BUNDLE_NAME}_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/swipenavawayprefs.plist$(ECHO_END)
