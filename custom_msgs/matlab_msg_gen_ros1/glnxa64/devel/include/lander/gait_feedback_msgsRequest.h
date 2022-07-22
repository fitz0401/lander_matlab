// Generated by gencpp from file lander/gait_feedback_msgsRequest.msg
// DO NOT EDIT!


#ifndef LANDER_MESSAGE_GAIT_FEEDBACK_MSGSREQUEST_H
#define LANDER_MESSAGE_GAIT_FEEDBACK_MSGSREQUEST_H


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
struct gait_feedback_msgsRequest_
{
  typedef gait_feedback_msgsRequest_<ContainerAllocator> Type;

  gait_feedback_msgsRequest_()
    : command_index(0)
    , leg_index(0)
    , foot1_motion()
    , foot2_motion()
    , foot3_motion()
    , foot4_motion()
    , data_num(0)
    , foot1_trace_x()
    , foot1_trace_y()
    , foot1_trace_z()
    , foot2_trace_x()
    , foot2_trace_y()
    , foot2_trace_z()
    , foot3_trace_x()
    , foot3_trace_y()
    , foot3_trace_z()
    , foot4_trace_x()
    , foot4_trace_y()
    , foot4_trace_z()  {
      foot1_motion.assign(0.0);

      foot2_motion.assign(0.0);

      foot3_motion.assign(0.0);

      foot4_motion.assign(0.0);
  }
  gait_feedback_msgsRequest_(const ContainerAllocator& _alloc)
    : command_index(0)
    , leg_index(0)
    , foot1_motion()
    , foot2_motion()
    , foot3_motion()
    , foot4_motion()
    , data_num(0)
    , foot1_trace_x(_alloc)
    , foot1_trace_y(_alloc)
    , foot1_trace_z(_alloc)
    , foot2_trace_x(_alloc)
    , foot2_trace_y(_alloc)
    , foot2_trace_z(_alloc)
    , foot3_trace_x(_alloc)
    , foot3_trace_y(_alloc)
    , foot3_trace_z(_alloc)
    , foot4_trace_x(_alloc)
    , foot4_trace_y(_alloc)
    , foot4_trace_z(_alloc)  {
  (void)_alloc;
      foot1_motion.assign(0.0);

      foot2_motion.assign(0.0);

      foot3_motion.assign(0.0);

      foot4_motion.assign(0.0);
  }



   typedef int32_t _command_index_type;
  _command_index_type command_index;

   typedef int32_t _leg_index_type;
  _leg_index_type leg_index;

   typedef boost::array<double, 3>  _foot1_motion_type;
  _foot1_motion_type foot1_motion;

   typedef boost::array<double, 3>  _foot2_motion_type;
  _foot2_motion_type foot2_motion;

   typedef boost::array<double, 3>  _foot3_motion_type;
  _foot3_motion_type foot3_motion;

   typedef boost::array<double, 3>  _foot4_motion_type;
  _foot4_motion_type foot4_motion;

   typedef int32_t _data_num_type;
  _data_num_type data_num;

   typedef std::vector<double, typename ContainerAllocator::template rebind<double>::other >  _foot1_trace_x_type;
  _foot1_trace_x_type foot1_trace_x;

   typedef std::vector<double, typename ContainerAllocator::template rebind<double>::other >  _foot1_trace_y_type;
  _foot1_trace_y_type foot1_trace_y;

   typedef std::vector<double, typename ContainerAllocator::template rebind<double>::other >  _foot1_trace_z_type;
  _foot1_trace_z_type foot1_trace_z;

   typedef std::vector<double, typename ContainerAllocator::template rebind<double>::other >  _foot2_trace_x_type;
  _foot2_trace_x_type foot2_trace_x;

   typedef std::vector<double, typename ContainerAllocator::template rebind<double>::other >  _foot2_trace_y_type;
  _foot2_trace_y_type foot2_trace_y;

   typedef std::vector<double, typename ContainerAllocator::template rebind<double>::other >  _foot2_trace_z_type;
  _foot2_trace_z_type foot2_trace_z;

   typedef std::vector<double, typename ContainerAllocator::template rebind<double>::other >  _foot3_trace_x_type;
  _foot3_trace_x_type foot3_trace_x;

   typedef std::vector<double, typename ContainerAllocator::template rebind<double>::other >  _foot3_trace_y_type;
  _foot3_trace_y_type foot3_trace_y;

   typedef std::vector<double, typename ContainerAllocator::template rebind<double>::other >  _foot3_trace_z_type;
  _foot3_trace_z_type foot3_trace_z;

   typedef std::vector<double, typename ContainerAllocator::template rebind<double>::other >  _foot4_trace_x_type;
  _foot4_trace_x_type foot4_trace_x;

   typedef std::vector<double, typename ContainerAllocator::template rebind<double>::other >  _foot4_trace_y_type;
  _foot4_trace_y_type foot4_trace_y;

   typedef std::vector<double, typename ContainerAllocator::template rebind<double>::other >  _foot4_trace_z_type;
  _foot4_trace_z_type foot4_trace_z;





  typedef boost::shared_ptr< ::lander::gait_feedback_msgsRequest_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::lander::gait_feedback_msgsRequest_<ContainerAllocator> const> ConstPtr;

}; // struct gait_feedback_msgsRequest_

typedef ::lander::gait_feedback_msgsRequest_<std::allocator<void> > gait_feedback_msgsRequest;

typedef boost::shared_ptr< ::lander::gait_feedback_msgsRequest > gait_feedback_msgsRequestPtr;
typedef boost::shared_ptr< ::lander::gait_feedback_msgsRequest const> gait_feedback_msgsRequestConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::lander::gait_feedback_msgsRequest_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::lander::gait_feedback_msgsRequest_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::lander::gait_feedback_msgsRequest_<ContainerAllocator1> & lhs, const ::lander::gait_feedback_msgsRequest_<ContainerAllocator2> & rhs)
{
  return lhs.command_index == rhs.command_index &&
    lhs.leg_index == rhs.leg_index &&
    lhs.foot1_motion == rhs.foot1_motion &&
    lhs.foot2_motion == rhs.foot2_motion &&
    lhs.foot3_motion == rhs.foot3_motion &&
    lhs.foot4_motion == rhs.foot4_motion &&
    lhs.data_num == rhs.data_num &&
    lhs.foot1_trace_x == rhs.foot1_trace_x &&
    lhs.foot1_trace_y == rhs.foot1_trace_y &&
    lhs.foot1_trace_z == rhs.foot1_trace_z &&
    lhs.foot2_trace_x == rhs.foot2_trace_x &&
    lhs.foot2_trace_y == rhs.foot2_trace_y &&
    lhs.foot2_trace_z == rhs.foot2_trace_z &&
    lhs.foot3_trace_x == rhs.foot3_trace_x &&
    lhs.foot3_trace_y == rhs.foot3_trace_y &&
    lhs.foot3_trace_z == rhs.foot3_trace_z &&
    lhs.foot4_trace_x == rhs.foot4_trace_x &&
    lhs.foot4_trace_y == rhs.foot4_trace_y &&
    lhs.foot4_trace_z == rhs.foot4_trace_z;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::lander::gait_feedback_msgsRequest_<ContainerAllocator1> & lhs, const ::lander::gait_feedback_msgsRequest_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace lander

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsMessage< ::lander::gait_feedback_msgsRequest_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::lander::gait_feedback_msgsRequest_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::lander::gait_feedback_msgsRequest_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::lander::gait_feedback_msgsRequest_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::lander::gait_feedback_msgsRequest_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::lander::gait_feedback_msgsRequest_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::lander::gait_feedback_msgsRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "b401d108fe4e07f912067db7a9916b5e";
  }

  static const char* value(const ::lander::gait_feedback_msgsRequest_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0xb401d108fe4e07f9ULL;
  static const uint64_t static_value2 = 0x12067db7a9916b5eULL;
};

template<class ContainerAllocator>
struct DataType< ::lander::gait_feedback_msgsRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "lander/gait_feedback_msgsRequest";
  }

  static const char* value(const ::lander::gait_feedback_msgsRequest_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::lander::gait_feedback_msgsRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "# 客户端请求\n"
"# 0:getpos; 1:init; 2:planfoot; 3:planmotion\n"
"int32 command_index\n"
"# For planfoot\n"
"int32 leg_index\n"
"float64[3] foot1_motion\n"
"float64[3] foot2_motion\n"
"float64[3] foot3_motion\n"
"float64[3] foot4_motion\n"
"# For planmotion\n"
"int32 data_num\n"
"float64[] foot1_trace_x\n"
"float64[] foot1_trace_y\n"
"float64[] foot1_trace_z\n"
"float64[] foot2_trace_x\n"
"float64[] foot2_trace_y\n"
"float64[] foot2_trace_z\n"
"float64[] foot3_trace_x\n"
"float64[] foot3_trace_y\n"
"float64[] foot3_trace_z\n"
"float64[] foot4_trace_x\n"
"float64[] foot4_trace_y\n"
"float64[] foot4_trace_z\n"
;
  }

  static const char* value(const ::lander::gait_feedback_msgsRequest_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::lander::gait_feedback_msgsRequest_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.command_index);
      stream.next(m.leg_index);
      stream.next(m.foot1_motion);
      stream.next(m.foot2_motion);
      stream.next(m.foot3_motion);
      stream.next(m.foot4_motion);
      stream.next(m.data_num);
      stream.next(m.foot1_trace_x);
      stream.next(m.foot1_trace_y);
      stream.next(m.foot1_trace_z);
      stream.next(m.foot2_trace_x);
      stream.next(m.foot2_trace_y);
      stream.next(m.foot2_trace_z);
      stream.next(m.foot3_trace_x);
      stream.next(m.foot3_trace_y);
      stream.next(m.foot3_trace_z);
      stream.next(m.foot4_trace_x);
      stream.next(m.foot4_trace_y);
      stream.next(m.foot4_trace_z);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct gait_feedback_msgsRequest_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::lander::gait_feedback_msgsRequest_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::lander::gait_feedback_msgsRequest_<ContainerAllocator>& v)
  {
    s << indent << "command_index: ";
    Printer<int32_t>::stream(s, indent + "  ", v.command_index);
    s << indent << "leg_index: ";
    Printer<int32_t>::stream(s, indent + "  ", v.leg_index);
    s << indent << "foot1_motion[]" << std::endl;
    for (size_t i = 0; i < v.foot1_motion.size(); ++i)
    {
      s << indent << "  foot1_motion[" << i << "]: ";
      Printer<double>::stream(s, indent + "  ", v.foot1_motion[i]);
    }
    s << indent << "foot2_motion[]" << std::endl;
    for (size_t i = 0; i < v.foot2_motion.size(); ++i)
    {
      s << indent << "  foot2_motion[" << i << "]: ";
      Printer<double>::stream(s, indent + "  ", v.foot2_motion[i]);
    }
    s << indent << "foot3_motion[]" << std::endl;
    for (size_t i = 0; i < v.foot3_motion.size(); ++i)
    {
      s << indent << "  foot3_motion[" << i << "]: ";
      Printer<double>::stream(s, indent + "  ", v.foot3_motion[i]);
    }
    s << indent << "foot4_motion[]" << std::endl;
    for (size_t i = 0; i < v.foot4_motion.size(); ++i)
    {
      s << indent << "  foot4_motion[" << i << "]: ";
      Printer<double>::stream(s, indent + "  ", v.foot4_motion[i]);
    }
    s << indent << "data_num: ";
    Printer<int32_t>::stream(s, indent + "  ", v.data_num);
    s << indent << "foot1_trace_x[]" << std::endl;
    for (size_t i = 0; i < v.foot1_trace_x.size(); ++i)
    {
      s << indent << "  foot1_trace_x[" << i << "]: ";
      Printer<double>::stream(s, indent + "  ", v.foot1_trace_x[i]);
    }
    s << indent << "foot1_trace_y[]" << std::endl;
    for (size_t i = 0; i < v.foot1_trace_y.size(); ++i)
    {
      s << indent << "  foot1_trace_y[" << i << "]: ";
      Printer<double>::stream(s, indent + "  ", v.foot1_trace_y[i]);
    }
    s << indent << "foot1_trace_z[]" << std::endl;
    for (size_t i = 0; i < v.foot1_trace_z.size(); ++i)
    {
      s << indent << "  foot1_trace_z[" << i << "]: ";
      Printer<double>::stream(s, indent + "  ", v.foot1_trace_z[i]);
    }
    s << indent << "foot2_trace_x[]" << std::endl;
    for (size_t i = 0; i < v.foot2_trace_x.size(); ++i)
    {
      s << indent << "  foot2_trace_x[" << i << "]: ";
      Printer<double>::stream(s, indent + "  ", v.foot2_trace_x[i]);
    }
    s << indent << "foot2_trace_y[]" << std::endl;
    for (size_t i = 0; i < v.foot2_trace_y.size(); ++i)
    {
      s << indent << "  foot2_trace_y[" << i << "]: ";
      Printer<double>::stream(s, indent + "  ", v.foot2_trace_y[i]);
    }
    s << indent << "foot2_trace_z[]" << std::endl;
    for (size_t i = 0; i < v.foot2_trace_z.size(); ++i)
    {
      s << indent << "  foot2_trace_z[" << i << "]: ";
      Printer<double>::stream(s, indent + "  ", v.foot2_trace_z[i]);
    }
    s << indent << "foot3_trace_x[]" << std::endl;
    for (size_t i = 0; i < v.foot3_trace_x.size(); ++i)
    {
      s << indent << "  foot3_trace_x[" << i << "]: ";
      Printer<double>::stream(s, indent + "  ", v.foot3_trace_x[i]);
    }
    s << indent << "foot3_trace_y[]" << std::endl;
    for (size_t i = 0; i < v.foot3_trace_y.size(); ++i)
    {
      s << indent << "  foot3_trace_y[" << i << "]: ";
      Printer<double>::stream(s, indent + "  ", v.foot3_trace_y[i]);
    }
    s << indent << "foot3_trace_z[]" << std::endl;
    for (size_t i = 0; i < v.foot3_trace_z.size(); ++i)
    {
      s << indent << "  foot3_trace_z[" << i << "]: ";
      Printer<double>::stream(s, indent + "  ", v.foot3_trace_z[i]);
    }
    s << indent << "foot4_trace_x[]" << std::endl;
    for (size_t i = 0; i < v.foot4_trace_x.size(); ++i)
    {
      s << indent << "  foot4_trace_x[" << i << "]: ";
      Printer<double>::stream(s, indent + "  ", v.foot4_trace_x[i]);
    }
    s << indent << "foot4_trace_y[]" << std::endl;
    for (size_t i = 0; i < v.foot4_trace_y.size(); ++i)
    {
      s << indent << "  foot4_trace_y[" << i << "]: ";
      Printer<double>::stream(s, indent + "  ", v.foot4_trace_y[i]);
    }
    s << indent << "foot4_trace_z[]" << std::endl;
    for (size_t i = 0; i < v.foot4_trace_z.size(); ++i)
    {
      s << indent << "  foot4_trace_z[" << i << "]: ";
      Printer<double>::stream(s, indent + "  ", v.foot4_trace_z[i]);
    }
  }
};

} // namespace message_operations
} // namespace ros

#endif // LANDER_MESSAGE_GAIT_FEEDBACK_MSGSREQUEST_H
