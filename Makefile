include $(THEOS)/makefiles/common.mk

TARGET = ::9.3:9

TWEAK_NAME = NavAway
${TWEAK_NAME}_FILES = Tweak.xm
${TWEAK_NAME}_FRAMEWORKS = UIKit
${TWEAK_NAME}_CFLAGS = -fobjc-arc
TARGET_CODESIGN_FLAGS = -Sent.plist
include $(THEOS_MAKE_PATH)/tweak.mk


after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += swipenavawayprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
