#ifndef LANDER__VISIBILITY_CONTROL_H_
#define LANDER__VISIBILITY_CONTROL_H_
#if defined _WIN32 || defined __CYGWIN__
  #ifdef __GNUC__
    #define LANDER_EXPORT __attribute__ ((dllexport))
    #define LANDER_IMPORT __attribute__ ((dllimport))
  #else
    #define LANDER_EXPORT __declspec(dllexport)
    #define LANDER_IMPORT __declspec(dllimport)
  #endif
  #ifdef LANDER_BUILDING_LIBRARY
    #define LANDER_PUBLIC LANDER_EXPORT
  #else
    #define LANDER_PUBLIC LANDER_IMPORT
  #endif
  #define LANDER_PUBLIC_TYPE LANDER_PUBLIC
  #define LANDER_LOCAL
#else
  #define LANDER_EXPORT __attribute__ ((visibility("default")))
  #define LANDER_IMPORT
  #if __GNUC__ >= 4
    #define LANDER_PUBLIC __attribute__ ((visibility("default")))
    #define LANDER_LOCAL  __attribute__ ((visibility("hidden")))
  #else
    #define LANDER_PUBLIC
    #define LANDER_LOCAL
  #endif
  #define LANDER_PUBLIC_TYPE
#endif
#endif  // LANDER__VISIBILITY_CONTROL_H_
// Generated 06-Jul-2022 09:37:09
// Copyright 2019-2020 The MathWorks, Inc.
