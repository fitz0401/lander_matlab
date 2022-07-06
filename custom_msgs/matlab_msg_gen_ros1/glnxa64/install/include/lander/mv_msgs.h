// Generated by gencpp from file lander/mv_msgs.msg
// DO NOT EDIT!


#ifndef LANDER_MESSAGE_MV_MSGS_H
#define LANDER_MESSAGE_MV_MSGS_H

#include <ros/service_traits.h>


#include <lander/mv_msgsRequest.h>
#include <lander/mv_msgsResponse.h>


namespace lander
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
} // namespace lander


namespace ros
{
namespace service_traits
{


template<>
struct MD5Sum< ::lander::mv_msgs > {
  static const char* value()
  {
    return "618d2543874df9eb2cdf1d712a157e36";
  }

  static const char* value(const ::lander::mv_msgs&) { return value(); }
};

template<>
struct DataType< ::lander::mv_msgs > {
  static const char* value()
  {
    return "lander/mv_msgs";
  }

  static const char* value(const ::lander::mv_msgs&) { return value(); }
};


// service_traits::MD5Sum< ::lander::mv_msgsRequest> should match
// service_traits::MD5Sum< ::lander::mv_msgs >
template<>
struct MD5Sum< ::lander::mv_msgsRequest>
{
  static const char* value()
  {
    return MD5Sum< ::lander::mv_msgs >::value();
  }
  static const char* value(const ::lander::mv_msgsRequest&)
  {
    return value();
  }
};

// service_traits::DataType< ::lander::mv_msgsRequest> should match
// service_traits::DataType< ::lander::mv_msgs >
template<>
struct DataType< ::lander::mv_msgsRequest>
{
  static const char* value()
  {
    return DataType< ::lander::mv_msgs >::value();
  }
  static const char* value(const ::lander::mv_msgsRequest&)
  {
    return value();
  }
};

// service_traits::MD5Sum< ::lander::mv_msgsResponse> should match
// service_traits::MD5Sum< ::lander::mv_msgs >
template<>
struct MD5Sum< ::lander::mv_msgsResponse>
{
  static const char* value()
  {
    return MD5Sum< ::lander::mv_msgs >::value();
  }
  static const char* value(const ::lander::mv_msgsResponse&)
  {
    return value();
  }
};

// service_traits::DataType< ::lander::mv_msgsResponse> should match
// service_traits::DataType< ::lander::mv_msgs >
template<>
struct DataType< ::lander::mv_msgsResponse>
{
  static const char* value()
  {
    return DataType< ::lander::mv_msgs >::value();
  }
  static const char* value(const ::lander::mv_msgsResponse&)
  {
    return value();
  }
};

} // namespace service_traits
} // namespace ros

#endif // LANDER_MESSAGE_MV_MSGS_H
