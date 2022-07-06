// Generated by gencpp from file msgs_packages/mv_msgsRequest.msg
// DO NOT EDIT!


#ifndef MSGS_PACKAGES_MESSAGE_MV_MSGSREQUEST_H
#define MSGS_PACKAGES_MESSAGE_MV_MSGSREQUEST_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace msgs_packages
{
template <class ContainerAllocator>
struct mv_msgsRequest_
{
  typedef mv_msgsRequest_<ContainerAllocator> Type;

  mv_msgsRequest_()
    : command_index(0)
    , leg(0)
    , x_motion(0.0)
    , y_motion(0.0)
    , z_motion(0.0)
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
    }
  mv_msgsRequest_(const ContainerAllocator& _alloc)
    : command_index(0)
    , leg(0)
    , x_motion(0.0)
    , y_motion(0.0)
    , z_motion(0.0)
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
    }



   typedef int32_t _command_index_type;
  _command_index_type command_index;

   typedef int32_t _leg_type;
  _leg_type leg;

   typedef double _x_motion_type;
  _x_motion_type x_motion;

   typedef double _y_motion_type;
  _y_motion_type y_motion;

   typedef double _z_motion_type;
  _z_motion_type z_motion;

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





  typedef boost::shared_ptr< ::msgs_packages::mv_msgsRequest_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::msgs_packages::mv_msgsRequest_<ContainerAllocator> const> ConstPtr;

}; // struct mv_msgsRequest_

typedef ::msgs_packages::mv_msgsRequest_<std::allocator<void> > mv_msgsRequest;

typedef boost::shared_ptr< ::msgs_packages::mv_msgsRequest > mv_msgsRequestPtr;
typedef boost::shared_ptr< ::msgs_packages::mv_msgsRequest const> mv_msgsRequestConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::msgs_packages::mv_msgsRequest_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::msgs_packages::mv_msgsRequest_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::msgs_packages::mv_msgsRequest_<ContainerAllocator1> & lhs, const ::msgs_packages::mv_msgsRequest_<ContainerAllocator2> & rhs)
{
  return lhs.command_index == rhs.command_index &&
    lhs.leg == rhs.leg &&
    lhs.x_motion == rhs.x_motion &&
    lhs.y_motion == rhs.y_motion &&
    lhs.z_motion == rhs.z_motion &&
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
bool operator!=(const ::msgs_packages::mv_msgsRequest_<ContainerAllocator1> & lhs, const ::msgs_packages::mv_msgsRequest_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace msgs_packages

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsMessage< ::msgs_packages::mv_msgsRequest_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::msgs_packages::mv_msgsRequest_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::msgs_packages::mv_msgsRequest_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::msgs_packages::mv_msgsRequest_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::msgs_packages::mv_msgsRequest_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::msgs_packages::mv_msgsRequest_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::msgs_packages::mv_msgsRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "486898fd75f9040f7b995c917fb086ec";
  }

  static const char* value(const ::msgs_packages::mv_msgsRequest_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x486898fd75f9040fULL;
  static const uint64_t static_value2 = 0x7b995c917fb086ecULL;
};

template<class ContainerAllocator>
struct DataType< ::msgs_packages::mv_msgsRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "msgs_packages/mv_msgsRequest";
  }

  static const char* value(const ::msgs_packages::mv_msgsRequest_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::msgs_packages::mv_msgsRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "# 客户端请求\n"
"# 0:getpos; 1:init; 2:planfoot; 3:planmotion\n"
"int32 command_index\n"
"# For planfoot\n"
"int32 leg\n"
"float64 x_motion\n"
"float64 y_motion\n"
"float64 z_motion\n"
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

  static const char* value(const ::msgs_packages::mv_msgsRequest_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::msgs_packages::mv_msgsRequest_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.command_index);
      stream.next(m.leg);
      stream.next(m.x_motion);
      stream.next(m.y_motion);
      stream.next(m.z_motion);
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
  }; // struct mv_msgsRequest_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::msgs_packages::mv_msgsRequest_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::msgs_packages::mv_msgsRequest_<ContainerAllocator>& v)
  {
    s << indent << "command_index: ";
    Printer<int32_t>::stream(s, indent + "  ", v.command_index);
    s << indent << "leg: ";
    Printer<int32_t>::stream(s, indent + "  ", v.leg);
    s << indent << "x_motion: ";
    Printer<double>::stream(s, indent + "  ", v.x_motion);
    s << indent << "y_motion: ";
    Printer<double>::stream(s, indent + "  ", v.y_motion);
    s << indent << "z_motion: ";
    Printer<double>::stream(s, indent + "  ", v.z_motion);
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

#endif // MSGS_PACKAGES_MESSAGE_MV_MSGSREQUEST_H
