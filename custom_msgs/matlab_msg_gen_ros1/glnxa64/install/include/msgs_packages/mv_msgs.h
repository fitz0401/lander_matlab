// Generated by gencpp from file msgs_packages/mv_msgs.msg
// DO NOT EDIT!


#ifndef MSGS_PACKAGES_MESSAGE_MV_MSGS_H
#define MSGS_PACKAGES_MESSAGE_MV_MSGS_H

#include <ros/service_traits.h>


#include <msgs_packages/mv_msgsRequest.h>
#include <msgs_packages/mv_msgsResponse.h>


namespace msgs_packages
{

struct mv_msgs
{

typedef mv_msgsRequest Request;
typedef mv_msgsResponse Response;
Request request;
Response response;

typedef Request RequestType;
typedef Response ResponseType;

}; // struct mv_msgs
} // namespace msgs_packages


namespace ros
{
namespace service_traits
{


template<>
struct MD5Sum< ::msgs_packages::mv_msgs > {
  static const char* value()
  {
    return "618d2543874df9eb2cdf1d712a157e36";
  }

  static const char* value(const ::msgs_packages::mv_msgs&) { return value(); }
};

template<>
struct DataType< ::msgs_packages::mv_msgs > {
  static const char* value()
  {
    return "msgs_packages/mv_msgs";
  }

  static const char* value(const ::msgs_packages::mv_msgs&) { return value(); }
};


// service_traits::MD5Sum< ::msgs_packages::mv_msgsRequest> should match
// service_traits::MD5Sum< ::msgs_packages::mv_msgs >
template<>
struct MD5Sum< ::msgs_packages::mv_msgsRequest>
{
  static const char* value()
  {
    return MD5Sum< ::msgs_packages::mv_msgs >::value();
  }
  static const char* value(const ::msgs_packages::mv_msgsRequest&)
  {
    return value();
  }
};

// service_traits::DataType< ::msgs_packages::mv_msgsRequest> should match
// service_traits::DataType< ::msgs_packages::mv_msgs >
template<>
struct DataType< ::msgs_packages::mv_msgsRequest>
{
  static const char* value()
  {
    return DataType< ::msgs_packages::mv_msgs >::value();
  }
  static const char* value(const ::msgs_packages::mv_msgsRequest&)
  {
    return value();
  }
};

// service_traits::MD5Sum< ::msgs_packages::mv_msgsResponse> should match
// service_traits::MD5Sum< ::msgs_packages::mv_msgs >
template<>
struct MD5Sum< ::msgs_packages::mv_msgsResponse>
{
  static const char* value()
  {
    return MD5Sum< ::msgs_packages::mv_msgs >::value();
  }
  static const char* value(const ::msgs_packages::mv_msgsResponse&)
  {
    return value();
  }
};

// service_traits::DataType< ::msgs_packages::mv_msgsResponse> should match
// service_traits::DataType< ::msgs_packages::mv_msgs >
template<>
struct DataType< ::msgs_packages::mv_msgsResponse>
{
  static const char* value()
  {
    return DataType< ::msgs_packages::mv_msgs >::value();
  }
  static const char* value(const ::msgs_packages::mv_msgsResponse&)
  {
    return value();
  }
};

} // namespace service_traits
} // namespace ros

#endif // MSGS_PACKAGES_MESSAGE_MV_MSGS_H
