// Generated by gencpp from file lander/gait_feedback_msgsResponse.msg
// DO NOT EDIT!


#ifndef LANDER_MESSAGE_GAIT_FEEDBACK_MSGSRESPONSE_H
#define LANDER_MESSAGE_GAIT_FEEDBACK_MSGSRESPONSE_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace lander
{
template <class ContainerAllocator>
struct gait_feedback_msgsResponse_
{
  typedef gait_feedback_msgsResponse_<ContainerAllocator> Type;

  gait_feedback_msgsResponse_()
    : isFinish(false)
    , foot1_position()
    , foot2_position()
    , foot3_position()
    , foot4_position()  {
      foot1_position.assign(0.0);

      foot2_position.assign(0.0);

      foot3_position.assign(0.0);

      foot4_position.assign(0.0);
  }
  gait_feedback_msgsResponse_(const ContainerAllocator& _alloc)
    : isFinish(false)
    , foot1_position()
    , foot2_position()
    , foot3_position()
    , foot4_position()  {
  (void)_alloc;
      foot1_position.assign(0.0);

      foot2_position.assign(0.0);

      foot3_position.assign(0.0);

      foot4_position.assign(0.0);
  }



   typedef uint8_t _isFinish_type;
  _isFinish_type isFinish;

   typedef boost::array<double, 3>  _foot1_position_type;
  _foot1_position_type foot1_position;

   typedef boost::array<double, 3>  _foot2_position_type;
  _foot2_position_type foot2_position;

   typedef boost::array<double, 3>  _foot3_position_type;
  _foot3_position_type foot3_position;

   typedef boost::array<double, 3>  _foot4_position_type;
  _foot4_position_type foot4_position;





  typedef boost::shared_ptr< ::lander::gait_feedback_msgsResponse_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::lander::gait_feedback_msgsResponse_<ContainerAllocator> const> ConstPtr;

}; // struct gait_feedback_msgsResponse_

typedef ::lander::gait_feedback_msgsResponse_<std::allocator<void> > gait_feedback_msgsResponse;

typedef boost::shared_ptr< ::lander::gait_feedback_msgsResponse > gait_feedback_msgsResponsePtr;
typedef boost::shared_ptr< ::lander::gait_feedback_msgsResponse const> gait_feedback_msgsResponseConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::lander::gait_feedback_msgsResponse_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::lander::gait_feedback_msgsResponse_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::lander::gait_feedback_msgsResponse_<ContainerAllocator1> & lhs, const ::lander::gait_feedback_msgsResponse_<ContainerAllocator2> & rhs)
{
  return lhs.isFinish == rhs.isFinish &&
    lhs.foot1_position == rhs.foot1_position &&
    lhs.foot2_position == rhs.foot2_position &&
    lhs.foot3_position == rhs.foot3_position &&
    lhs.foot4_position == rhs.foot4_position;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::lander::gait_feedback_msgsResponse_<ContainerAllocator1> & lhs, const ::lander::gait_feedback_msgsResponse_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace lander

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsMessage< ::lander::gait_feedback_msgsResponse_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::lander::gait_feedback_msgsResponse_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::lander::gait_feedback_msgsResponse_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::lander::gait_feedback_msgsResponse_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::lander::gait_feedback_msgsResponse_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::lander::gait_feedback_msgsResponse_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::lander::gait_feedback_msgsResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "532b0c4ac83e2427806e5be0d649382c";
  }

  static const char* value(const ::lander::gait_feedback_msgsResponse_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x532b0c4ac83e2427ULL;
  static const uint64_t static_value2 = 0x806e5be0d649382cULL;
};

template<class ContainerAllocator>
struct DataType< ::lander::gait_feedback_msgsResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "lander/gait_feedback_msgsResponse";
  }

  static const char* value(const ::lander::gait_feedback_msgsResponse_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::lander::gait_feedback_msgsResponse_<ContainerAllocator> >
{
  static const char* value()
  {
    return "# 服务器响应发送的数据\n"
"bool isFinish\n"
"float64[3] foot1_position\n"
"float64[3] foot2_position\n"
"float64[3] foot3_position\n"
"float64[3] foot4_position\n"
;
  }

  static const char* value(const ::lander::gait_feedback_msgsResponse_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::lander::gait_feedback_msgsResponse_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.isFinish);
      stream.next(m.foot1_position);
      stream.next(m.foot2_position);
      stream.next(m.foot3_position);
      stream.next(m.foot4_position);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct gait_feedback_msgsResponse_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::lander::gait_feedback_msgsResponse_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::lander::gait_feedback_msgsResponse_<ContainerAllocator>& v)
  {
    s << indent << "isFinish: ";
    Printer<uint8_t>::stream(s, indent + "  ", v.isFinish);
    s << indent << "foot1_position[]" << std::endl;
    for (size_t i = 0; i < v.foot1_position.size(); ++i)
    {
      s << indent << "  foot1_position[" << i << "]: ";
      Printer<double>::stream(s, indent + "  ", v.foot1_position[i]);
    }
    s << indent << "foot2_position[]" << std::endl;
    for (size_t i = 0; i < v.foot2_position.size(); ++i)
    {
      s << indent << "  foot2_position[" << i << "]: ";
      Printer<double>::stream(s, indent + "  ", v.foot2_position[i]);
    }
    s << indent << "foot3_position[]" << std::endl;
    for (size_t i = 0; i < v.foot3_position.size(); ++i)
    {
      s << indent << "  foot3_position[" << i << "]: ";
      Printer<double>::stream(s, indent + "  ", v.foot3_position[i]);
    }
    s << indent << "foot4_position[]" << std::endl;
    for (size_t i = 0; i < v.foot4_position.size(); ++i)
    {
      s << indent << "  foot4_position[" << i << "]: ";
      Printer<double>::stream(s, indent + "  ", v.foot4_position[i]);
    }
  }
};

} // namespace message_operations
} // namespace ros

#endif // LANDER_MESSAGE_GAIT_FEEDBACK_MSGSRESPONSE_H