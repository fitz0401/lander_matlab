#ifndef MSGS_PACKAGES__VISIBILITY_CONTROL_H_
#define MSGS_PACKAGES__VISIBILITY_CONTROL_H_
#if defined _WIN32 || defined __CYGWIN__
  #ifdef __GNUC__
    #define MSGS_PACKAGES_EXPORT __attribute__ ((dllexport))
    #define MSGS_PACKAGES_IMPORT __attribute__ ((dllimport))
  #else
    #define MSGS_PACKAGES_EXPORT __declspec(dllexport)
    #define MSGS_PACKAGES_IMPORT __declspec(dllimport)
  #endif
  #ifdef MSGS_PACKAGES_BUILDING_LIBRARY
    #define MSGS_PACKAGES_PUBLIC MSGS_PACKAGES_EXPORT
  #else
    #define MSGS_PACKAGES_PUBLIC MSGS_PACKAGES_IMPORT
  #endif
  #define MSGS_PACKAGES_PUBLIC_TYPE MSGS_PACKAGES_PUBLIC
  #define MSGS_PACKAGES_LOCAL
#else
  #define MSGS_PACKAGES_EXPORT __attribute__ ((visibility("default")))
  #define MSGS_PACKAGES_IMPORT
  #if __GNUC__ >= 4
    #define MSGS_PACKAGES_PUBLIC __attribute__ ((visibility("default")))
    #define MSGS_PACKAGES_LOCAL  __attribute__ ((visibility("hidden")))
  #else
    #define MSGS_PACKAGES_PUBLIC
    #define MSGS_PACKAGES_LOCAL
  #endif
  #define MSGS_PACKAGES_PUBLIC_TYPE
#endif
#endif  // MSGS_PACKAGES__VISIBILITY_CONTROL_H_
// Generated 04-Jul-2022 18:57:28
// Copyright 2019-2020 The MathWorks, Inc.
