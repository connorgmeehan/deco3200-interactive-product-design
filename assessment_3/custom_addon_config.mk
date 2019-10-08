# All variables and this file are optional, if they are not present the PG and the
# makefiles will try to parse the correct values from the file system.
#
# Variables that specify exclusions can use % as a wildcard to specify that anything in
# that position will match. A partial path can also be specified to, for example, exclude
# a whole folder from the parsed paths from the file system
#
# Variables can be specified using = or +=
# = will clear the contents of that variable both specified from the file or the ones parsed
# from the file system
# += will add the values to the previous ones in the file or the ones parsed from the file
# system
#
# The PG can be used to detect errors in this file, just create a new project with this addon
# and the PG will write to the console the kind of error and in which line it is

meta:
	ADDON_NAME = ofxOpenCv
	ADDON_DESCRIPTION = Addon for computer vision using the open source library openCv
	ADDON_AUTHOR = OF Team
	ADDON_TAGS = "computer vision" "opencv" "image processing"
	ADDON_URL = http://github.com/openframeworks/openFrameworks

common:
	# dependencies with other addons, a list of them separated by spaces
	# or use += in several lines
	# ADDON_DEPENDENCIES =

	# include search paths, this will be usually parsed from the file system
	# but if the addon or addon libraries need special search paths they can be
	# specified here separated by spaces or one per line using +=
	# openFrameworks/addons/ofxOpenCv/libs/opencv/include/opencv/cv.h

	ADDON_LIBS = 
	ADDON_LIBS += ../libs/opencv/lib/

	# any special flag that should be passed to the compiler when using this
	# addon
	# ADDON_CFLAGS =

	# any special flag that should be passed to the linker when using this
	# addon, also used for system libraries with -lname
	ADDON_LDFLAGS = -L ./libs/opencv/lib -lopencv_dnn -lopencv_highgui -lopencv_ml -lopencv_objdetect -lopencv_shape -lopencv_stitching -lopencv_superres -lopencv_videostab -lopencv_calib3d -lopencv_videoio -lopencv_imgcodecs -lopencv_features2d -lopencv_video -lopencv_photo -lopencv_imgproc -lopencv_flann -lopencv_viz -lopencv_core -lopencv_objdetect

	# linux only, any library that should be included in the project using
	# pkg-config
	# ADDON_PKG_CONFIG_LIBRARIES =

	# osx/iOS only, any framework that should be included in the project
	# ADDON_FRAMEWORKS =

	# source files, these will be usually parsed from the file system looking
	# in the src folders in libs and the root of the addon. if your addon needs
	# to include files in different places or a different set of files per platform
	# they can be specified here
	# ADDON_SOURCES =

	# some addons need resources to be copied to the bin/data folder of the project
	# specify here any files that need to be copied, you can use wildcards like * and ?
	# ADDON_DATA =

	# when parsing the file system looking for libraries exclude this for all or
	# a specific platform
	# ADDON_LIBS_EXCLUDE =

linux64:
  # ADDON_PKG_CONFIG_LIBRARIES = opencv harfbuzz
	ADDON_PKG_CONFIG_LIBARIES = opencv
	ADDON_INCLUDES = src
	ADDON_INCLUDES += libs/opencv/include/opencv
	ADDON_INCLUDES += libs/opencv/include/opencv2

	ADDON_LIBS =
	ADDON_LIBS += libs/opencv/lib/libopencv_calib3d.so.3.4
	ADDON_LIBS += libs/opencv/lib/libopencv_core.so.3.4
	ADDON_LIBS += libs/opencv/lib/libopencv_dnn.so.3.4
	ADDON_LIBS += libs/opencv/lib/libopencv_features2d.so.3.4
	ADDON_LIBS += libs/opencv/lib/libopencv_flann.so.3.4
	ADDON_LIBS += libs/opencv/lib/libopencv_highgui.so.3.4
	ADDON_LIBS += libs/opencv/lib/libopencv_imgcodecs.so.3.4
	ADDON_LIBS += libs/opencv/lib/libopencv_imgproc.so.3.4
	ADDON_LIBS += libs/opencv/lib/libopencv_ml.so.3.4
	ADDON_LIBS += libs/opencv/lib/libopencv_objdetect.so.3.4
	ADDON_LIBS += libs/opencv/lib/libopencv_photo.so.3.4
	ADDON_LIBS += libs/opencv/lib/libopencv_shape.so.3.4
	ADDON_LIBS += libs/opencv/lib/libopencv_stitching.so.3.4
	ADDON_LIBS += libs/opencv/lib/libopencv_superres.so.3.4
	ADDON_LIBS += libs/opencv/lib/libopencv_videoio.so.3.4
	ADDON_LIBS += libs/opencv/lib/libopencv_video.so.3.4
	ADDON_LIBS += libs/opencv/lib/libopencv_videostab.so.3.4
	ADDON_LIBS += libs/opencv/lib/libopencv_viz.so.3.4

linux:
	ADDON_PKG_CONFIG_LIBARIES = opencv
	ADDON_INCLUDES = src
	ADDON_INCLUDES += libs/opencv/include/opencv
	ADDON_INCLUDES += libs/opencv/include/opencv2


	ADDON_LIBS =
	ADDON_LIBS += libs/opencv/lib/libopencv_calib3d.so.3.4
	ADDON_LIBS += libs/opencv/lib/libopencv_core.so.3.4
	ADDON_LIBS += libs/opencv/lib/libopencv_dnn.so.3.4
	ADDON_LIBS += libs/opencv/lib/libopencv_features2d.so.3.4
	ADDON_LIBS += libs/opencv/lib/libopencv_flann.so.3.4
	ADDON_LIBS += libs/opencv/lib/libopencv_highgui.so.3.4
	ADDON_LIBS += libs/opencv/lib/libopencv_imgcodecs.so.3.4
	ADDON_LIBS += libs/opencv/lib/libopencv_imgproc.so.3.4
	ADDON_LIBS += libs/opencv/lib/libopencv_ml.so.3.4
	ADDON_LIBS += libs/opencv/lib/libopencv_objdetect.so.3.4
	ADDON_LIBS += libs/opencv/lib/libopencv_photo.so.3.4
	ADDON_LIBS += libs/opencv/lib/libopencv_shape.so.3.4
	ADDON_LIBS += libs/opencv/lib/libopencv_stitching.so.3.4
	ADDON_LIBS += libs/opencv/lib/libopencv_superres.so.3.4
	ADDON_LIBS += libs/opencv/lib/libopencv_videoio.so.3.4
	ADDON_LIBS += libs/opencv/lib/libopencv_video.so.3.4
	ADDON_LIBS += libs/opencv/lib/libopencv_videostab.so.3.4
	ADDON_LIBS += libs/opencv/lib/libopencv_viz.so.3.4

linuxarmv6l:
	ADDON_PKG_CONFIG_LIBRARIES = opencv
	ADDON_LIBS_EXCLUDE = libs/opencv/%
	ADDON_INCLUDES_EXCLUDE = libs/opencv
	ADDON_INCLUDES_EXCLUDE += libs/opencv/%

linuxarmv7l:
	ADDON_PKG_CONFIG_LIBRARIES = opencv
	ADDON_LIBS_EXCLUDE = libs/opencv/%
	ADDON_INCLUDES_EXCLUDE = libs/opencv
	ADDON_INCLUDES_EXCLUDE += libs/opencv/%

msys2:
	ADDON_PKG_CONFIG_LIBRARIES = opencv
	ADDON_LIBS_EXCLUDE = libs/opencv/%
	ADDON_INCLUDES_EXCLUDE = libs/opencv
	ADDON_INCLUDES_EXCLUDE += libs/opencv/%

android/x86:
	ADDON_LIBS =
	ADDON_LIBS += libs/opencv/lib/android/x86/libopencv_shape.a
	ADDON_LIBS += libs/opencv/lib/android/x86/libopencv_photo.a
	ADDON_LIBS += libs/opencv/lib/android/x86/libopencv_superres.a
	ADDON_LIBS += libs/opencv/lib/android/x86/libopencv_stitching.a
	ADDON_LIBS += libs/opencv/lib/android/x86/libopencv_calib3d.a
	ADDON_LIBS += libs/opencv/lib/android/x86/libopencv_features2d.a
	ADDON_LIBS += libs/opencv/lib/android/x86/libopencv_objdetect.a
	ADDON_LIBS += libs/opencv/lib/android/x86/libopencv_videostab.a
	ADDON_LIBS += libs/opencv/lib/android/x86/libopencv_video.a
	ADDON_LIBS += libs/opencv/lib/android/x86/libopencv_imgproc.a
	ADDON_LIBS += libs/opencv/lib/android/x86/libopencv_ml.a
	ADDON_LIBS += libs/opencv/lib/android/x86/libopencv_core.a
	ADDON_LIBS += libs/opencv/lib/android/x86/libopencv_flann.a
	ADDON_LIBS += libs/opencv/lib/android/x86/libopencv_contrib.a

android/armeabi-v7a:
	ADDON_LIBS =
	ADDON_LIBS += libs/opencv/lib/android/armeabi-v7a/libopencv_shape.a
	ADDON_LIBS += libs/opencv/lib/android/armeabi-v7a/libopencv_photo.a
	ADDON_LIBS += libs/opencv/lib/android/armeabi-v7a/libopencv_superres.a
	ADDON_LIBS += libs/opencv/lib/android/armeabi-v7a/libopencv_stitching.a
	ADDON_LIBS += libs/opencv/lib/android/armeabi-v7a/libopencv_calib3d.a
	ADDON_LIBS += libs/opencv/lib/android/armeabi-v7a/libopencv_features2d.a
	ADDON_LIBS += libs/opencv/lib/android/armeabi-v7a/libopencv_objdetect.a
	ADDON_LIBS += libs/opencv/lib/android/armeabi-v7a/libopencv_videostab.a
	ADDON_LIBS += libs/opencv/lib/android/armeabi-v7a/libopencv_video.a
	ADDON_LIBS += libs/opencv/lib/android/armeabi-v7a/libopencv_imgproc.a
	ADDON_LIBS += libs/opencv/lib/android/armeabi-v7a/libopencv_ml.a
	ADDON_LIBS += libs/opencv/lib/android/armeabi-v7a/libopencv_core.a
	ADDON_LIBS += libs/opencv/lib/android/armeabi-v7a/libopencv_flann.a
	ADDON_LIBS += libs/opencv/lib/android/armeabi-v7a/libopencv_contrib.a

emscripten:
	ADDON_LIBS =
	ADDON_LIBS += libs/opencv/lib/emscripten/libopencv_shape.a
	ADDON_LIBS += libs/opencv/lib/emscripten/libopencv_photo.a
	ADDON_LIBS += libs/opencv/lib/emscripten/libopencv_superres.a
	ADDON_LIBS += libs/opencv/lib/emscripten/libopencv_stitching.a
	ADDON_LIBS += libs/opencv/lib/emscripten/libopencv_calib3d.a
	ADDON_LIBS += libs/opencv/lib/emscripten/libopencv_features2d.a
	ADDON_LIBS += libs/opencv/lib/emscripten/libopencv_objdetect.a
	ADDON_LIBS += libs/opencv/lib/emscripten/libopencv_videostab.a
	ADDON_LIBS += libs/opencv/lib/emscripten/libopencv_video.a
	ADDON_LIBS += libs/opencv/lib/emscripten/libopencv_imgproc.a
	ADDON_LIBS += libs/opencv/lib/emscripten/libopencv_ml.a
	ADDON_LIBS += libs/opencv/lib/emscripten/libopencv_core.a
	ADDON_LIBS += libs/opencv/lib/emscripten/libopencv_flann.a
	ADDON_LIBS += libs/opencv/lib/emscripten/libopencv_contrib.a
	ADDON_LIBS += libs/opencv/lib/emscripten/libzlib.a


ios:
	# osx/iOS only, any framework that should be included in the project
	ADDON_FRAMEWORKS = AssetsLibrary

