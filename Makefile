include $(THEOS)/makefiles/common.mk

export TARGET = simulator:clang:13.7:8.0
export ARCHS = i386 x86_64

TWEAK_NAME = FLEXSimject

FLEX_ROOT = ./FLEX

# Function to convert /foo/bar to -I/foo/bar
dtoim = $(foreach d,$(1),-I$(d))

# Gather FLEX sources
SOURCES  = $(shell find $(FLEX_ROOT)/Classes -name '*.c')
SOURCES += $(shell find $(FLEX_ROOT)/Classes -name '*.m')
SOURCES += $(shell find $(FLEX_ROOT)/Classes -name '*.mm')
# Gather FLEX headers for search paths
_IMPORTS  = $(shell /bin/ls -d $(FLEX_ROOT)/Classes/*/)
_IMPORTS += $(shell /bin/ls -d $(FLEX_ROOT)/Classes/*/*/)
_IMPORTS += $(shell /bin/ls -d $(FLEX_ROOT)/Classes/*/*/*/)
_IMPORTS += $(shell /bin/ls -d $(FLEX_ROOT)/Classes/*/*/*/*/)
IMPORTS = -I$(FLEX_ROOT)/Classes/ $(call dtoim, $(_IMPORTS))

FLEXSimject_FILES = Tweak.x $(SOURCES)
FLEXSimject_CFLAGS = -fobjc-arc -w -Wno-unsupported-availability-guard $(IMPORTS) -g
FLEXSimject_FRAMEWORKS = CoreGraphics UIKit ImageIO QuartzCore
FLEXSimject_LIBRARIES = sqlite3 z

include $(THEOS_MAKE_PATH)/tweak.mk
