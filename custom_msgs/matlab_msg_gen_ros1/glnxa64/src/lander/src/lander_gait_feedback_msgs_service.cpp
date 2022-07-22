// Copyright 2019-2021 The MathWorks, Inc.
// Common copy functions for lander/gait_feedback_msgsRequest
#include "boost/date_time.hpp"
#include "boost/shared_array.hpp"
#ifdef _MSC_VER
#pragma warning(push)
#pragma warning(disable : 4244)
#pragma warning(disable : 4265)
#pragma warning(disable : 4458)
#pragma warning(disable : 4100)
#pragma warning(disable : 4127)
#pragma warning(disable : 4267)
#pragma warning(disable : 4068)
#pragma warning(disable : 4245)
#else
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wpedantic"
#pragma GCC diagnostic ignored "-Wunused-local-typedefs"
#pragma GCC diagnostic ignored "-Wredundant-decls"
#pragma GCC diagnostic ignored "-Wnon-virtual-dtor"
#pragma GCC diagnostic ignored "-Wdelete-non-virtual-dtor"
#pragma GCC diagnostic ignored "-Wunused-parameter"
#pragma GCC diagnostic ignored "-Wunused-variable"
#pragma GCC diagnostic ignored "-Wshadow"
#endif //_MSC_VER
#include "ros/ros.h"
#include "lander/gait_feedback_msgs.h"
#include "visibility_control.h"
#include "ROSPubSubTemplates.hpp"
#include "ROSServiceTemplates.hpp"
class LANDER_EXPORT lander_msg_gait_feedback_msgsRequest_common : public MATLABROSMsgInterface<lander::gait_feedback_msgs::Request> {
  public:
    virtual ~lander_msg_gait_feedback_msgsRequest_common(){}
    virtual void copy_from_struct(lander::gait_feedback_msgs::Request* msg, const matlab::data::Struct& arr, MultiLibLoader loader); 
    //----------------------------------------------------------------------------
    virtual MDArray_T get_arr(MDFactory_T& factory, const lander::gait_feedback_msgs::Request* msg, MultiLibLoader loader, size_t size = 1);
};
  void lander_msg_gait_feedback_msgsRequest_common::copy_from_struct(lander::gait_feedback_msgs::Request* msg, const matlab::data::Struct& arr,
               MultiLibLoader loader) {
    try {
        //command_index
        const matlab::data::TypedArray<int32_t> command_index_arr = arr["CommandIndex"];
        msg->command_index = command_index_arr[0];
    } catch (matlab::data::InvalidFieldNameException&) {
        throw std::invalid_argument("Field 'CommandIndex' is missing.");
    } catch (matlab::Exception&) {
        throw std::invalid_argument("Field 'CommandIndex' is wrong type; expected a int32.");
    }
    try {
        //leg_index
        const matlab::data::TypedArray<int32_t> leg_index_arr = arr["LegIndex"];
        msg->leg_index = leg_index_arr[0];
    } catch (matlab::data::InvalidFieldNameException&) {
        throw std::invalid_argument("Field 'LegIndex' is missing.");
    } catch (matlab::Exception&) {
        throw std::invalid_argument("Field 'LegIndex' is wrong type; expected a int32.");
    }
    try {
        //foot1_motion
        const matlab::data::TypedArray<double> foot1_motion_arr = arr["Foot1Motion"];
        size_t nelem = 3;
        	std::copy(foot1_motion_arr.begin(), foot1_motion_arr.begin()+nelem, msg->foot1_motion.begin());
    } catch (matlab::data::InvalidFieldNameException&) {
        throw std::invalid_argument("Field 'Foot1Motion' is missing.");
    } catch (matlab::Exception&) {
        throw std::invalid_argument("Field 'Foot1Motion' is wrong type; expected a double.");
    }
    try {
        //foot2_motion
        const matlab::data::TypedArray<double> foot2_motion_arr = arr["Foot2Motion"];
        size_t nelem = 3;
        	std::copy(foot2_motion_arr.begin(), foot2_motion_arr.begin()+nelem, msg->foot2_motion.begin());
    } catch (matlab::data::InvalidFieldNameException&) {
        throw std::invalid_argument("Field 'Foot2Motion' is missing.");
    } catch (matlab::Exception&) {
        throw std::invalid_argument("Field 'Foot2Motion' is wrong type; expected a double.");
    }
    try {
        //foot3_motion
        const matlab::data::TypedArray<double> foot3_motion_arr = arr["Foot3Motion"];
        size_t nelem = 3;
        	std::copy(foot3_motion_arr.begin(), foot3_motion_arr.begin()+nelem, msg->foot3_motion.begin());
    } catch (matlab::data::InvalidFieldNameException&) {
        throw std::invalid_argument("Field 'Foot3Motion' is missing.");
    } catch (matlab::Exception&) {
        throw std::invalid_argument("Field 'Foot3Motion' is wrong type; expected a double.");
    }
    try {
        //foot4_motion
        const matlab::data::TypedArray<double> foot4_motion_arr = arr["Foot4Motion"];
        size_t nelem = 3;
        	std::copy(foot4_motion_arr.begin(), foot4_motion_arr.begin()+nelem, msg->foot4_motion.begin());
    } catch (matlab::data::InvalidFieldNameException&) {
        throw std::invalid_argument("Field 'Foot4Motion' is missing.");
    } catch (matlab::Exception&) {
        throw std::invalid_argument("Field 'Foot4Motion' is wrong type; expected a double.");
    }
    try {
        //data_num
        const matlab::data::TypedArray<int32_t> data_num_arr = arr["DataNum"];
        msg->data_num = data_num_arr[0];
    } catch (matlab::data::InvalidFieldNameException&) {
        throw std::invalid_argument("Field 'DataNum' is missing.");
    } catch (matlab::Exception&) {
        throw std::invalid_argument("Field 'DataNum' is wrong type; expected a int32.");
    }
    try {
        //foot1_trace_x
        const matlab::data::TypedArray<double> foot1_trace_x_arr = arr["Foot1TraceX"];
        size_t nelem = foot1_trace_x_arr.getNumberOfElements();
        	msg->foot1_trace_x.resize(nelem);
        	std::copy(foot1_trace_x_arr.begin(), foot1_trace_x_arr.begin()+nelem, msg->foot1_trace_x.begin());
    } catch (matlab::data::InvalidFieldNameException&) {
        throw std::invalid_argument("Field 'Foot1TraceX' is missing.");
    } catch (matlab::Exception&) {
        throw std::invalid_argument("Field 'Foot1TraceX' is wrong type; expected a double.");
    }
    try {
        //foot1_trace_y
        const matlab::data::TypedArray<double> foot1_trace_y_arr = arr["Foot1TraceY"];
        size_t nelem = foot1_trace_y_arr.getNumberOfElements();
        	msg->foot1_trace_y.resize(nelem);
        	std::copy(foot1_trace_y_arr.begin(), foot1_trace_y_arr.begin()+nelem, msg->foot1_trace_y.begin());
    } catch (matlab::data::InvalidFieldNameException&) {
        throw std::invalid_argument("Field 'Foot1TraceY' is missing.");
    } catch (matlab::Exception&) {
        throw std::invalid_argument("Field 'Foot1TraceY' is wrong type; expected a double.");
    }
    try {
        //foot1_trace_z
        const matlab::data::TypedArray<double> foot1_trace_z_arr = arr["Foot1TraceZ"];
        size_t nelem = foot1_trace_z_arr.getNumberOfElements();
        	msg->foot1_trace_z.resize(nelem);
        	std::copy(foot1_trace_z_arr.begin(), foot1_trace_z_arr.begin()+nelem, msg->foot1_trace_z.begin());
    } catch (matlab::data::InvalidFieldNameException&) {
        throw std::invalid_argument("Field 'Foot1TraceZ' is missing.");
    } catch (matlab::Exception&) {
        throw std::invalid_argument("Field 'Foot1TraceZ' is wrong type; expected a double.");
    }
    try {
        //foot2_trace_x
        const matlab::data::TypedArray<double> foot2_trace_x_arr = arr["Foot2TraceX"];
        size_t nelem = foot2_trace_x_arr.getNumberOfElements();
        	msg->foot2_trace_x.resize(nelem);
        	std::copy(foot2_trace_x_arr.begin(), foot2_trace_x_arr.begin()+nelem, msg->foot2_trace_x.begin());
    } catch (matlab::data::InvalidFieldNameException&) {
        throw std::invalid_argument("Field 'Foot2TraceX' is missing.");
    } catch (matlab::Exception&) {
        throw std::invalid_argument("Field 'Foot2TraceX' is wrong type; expected a double.");
    }
    try {
        //foot2_trace_y
        const matlab::data::TypedArray<double> foot2_trace_y_arr = arr["Foot2TraceY"];
        size_t nelem = foot2_trace_y_arr.getNumberOfElements();
        	msg->foot2_trace_y.resize(nelem);
        	std::copy(foot2_trace_y_arr.begin(), foot2_trace_y_arr.begin()+nelem, msg->foot2_trace_y.begin());
    } catch (matlab::data::InvalidFieldNameException&) {
        throw std::invalid_argument("Field 'Foot2TraceY' is missing.");
    } catch (matlab::Exception&) {
        throw std::invalid_argument("Field 'Foot2TraceY' is wrong type; expected a double.");
    }
    try {
        //foot2_trace_z
        const matlab::data::TypedArray<double> foot2_trace_z_arr = arr["Foot2TraceZ"];
        size_t nelem = foot2_trace_z_arr.getNumberOfElements();
        	msg->foot2_trace_z.resize(nelem);
        	std::copy(foot2_trace_z_arr.begin(), foot2_trace_z_arr.begin()+nelem, msg->foot2_trace_z.begin());
    } catch (matlab::data::InvalidFieldNameException&) {
        throw std::invalid_argument("Field 'Foot2TraceZ' is missing.");
    } catch (matlab::Exception&) {
        throw std::invalid_argument("Field 'Foot2TraceZ' is wrong type; expected a double.");
    }
    try {
        //foot3_trace_x
        const matlab::data::TypedArray<double> foot3_trace_x_arr = arr["Foot3TraceX"];
        size_t nelem = foot3_trace_x_arr.getNumberOfElements();
        	msg->foot3_trace_x.resize(nelem);
        	std::copy(foot3_trace_x_arr.begin(), foot3_trace_x_arr.begin()+nelem, msg->foot3_trace_x.begin());
    } catch (matlab::data::InvalidFieldNameException&) {
        throw std::invalid_argument("Field 'Foot3TraceX' is missing.");
    } catch (matlab::Exception&) {
        throw std::invalid_argument("Field 'Foot3TraceX' is wrong type; expected a double.");
    }
    try {
        //foot3_trace_y
        const matlab::data::TypedArray<double> foot3_trace_y_arr = arr["Foot3TraceY"];
        size_t nelem = foot3_trace_y_arr.getNumberOfElements();
        	msg->foot3_trace_y.resize(nelem);
        	std::copy(foot3_trace_y_arr.begin(), foot3_trace_y_arr.begin()+nelem, msg->foot3_trace_y.begin());
    } catch (matlab::data::InvalidFieldNameException&) {
        throw std::invalid_argument("Field 'Foot3TraceY' is missing.");
    } catch (matlab::Exception&) {
        throw std::invalid_argument("Field 'Foot3TraceY' is wrong type; expected a double.");
    }
    try {
        //foot3_trace_z
        const matlab::data::TypedArray<double> foot3_trace_z_arr = arr["Foot3TraceZ"];
        size_t nelem = foot3_trace_z_arr.getNumberOfElements();
        	msg->foot3_trace_z.resize(nelem);
        	std::copy(foot3_trace_z_arr.begin(), foot3_trace_z_arr.begin()+nelem, msg->foot3_trace_z.begin());
    } catch (matlab::data::InvalidFieldNameException&) {
        throw std::invalid_argument("Field 'Foot3TraceZ' is missing.");
    } catch (matlab::Exception&) {
        throw std::invalid_argument("Field 'Foot3TraceZ' is wrong type; expected a double.");
    }
    try {
        //foot4_trace_x
        const matlab::data::TypedArray<double> foot4_trace_x_arr = arr["Foot4TraceX"];
        size_t nelem = foot4_trace_x_arr.getNumberOfElements();
        	msg->foot4_trace_x.resize(nelem);
        	std::copy(foot4_trace_x_arr.begin(), foot4_trace_x_arr.begin()+nelem, msg->foot4_trace_x.begin());
    } catch (matlab::data::InvalidFieldNameException&) {
        throw std::invalid_argument("Field 'Foot4TraceX' is missing.");
    } catch (matlab::Exception&) {
        throw std::invalid_argument("Field 'Foot4TraceX' is wrong type; expected a double.");
    }
    try {
        //foot4_trace_y
        const matlab::data::TypedArray<double> foot4_trace_y_arr = arr["Foot4TraceY"];
        size_t nelem = foot4_trace_y_arr.getNumberOfElements();
        	msg->foot4_trace_y.resize(nelem);
        	std::copy(foot4_trace_y_arr.begin(), foot4_trace_y_arr.begin()+nelem, msg->foot4_trace_y.begin());
    } catch (matlab::data::InvalidFieldNameException&) {
        throw std::invalid_argument("Field 'Foot4TraceY' is missing.");
    } catch (matlab::Exception&) {
        throw std::invalid_argument("Field 'Foot4TraceY' is wrong type; expected a double.");
    }
    try {
        //foot4_trace_z
        const matlab::data::TypedArray<double> foot4_trace_z_arr = arr["Foot4TraceZ"];
        size_t nelem = foot4_trace_z_arr.getNumberOfElements();
        	msg->foot4_trace_z.resize(nelem);
        	std::copy(foot4_trace_z_arr.begin(), foot4_trace_z_arr.begin()+nelem, msg->foot4_trace_z.begin());
    } catch (matlab::data::InvalidFieldNameException&) {
        throw std::invalid_argument("Field 'Foot4TraceZ' is missing.");
    } catch (matlab::Exception&) {
        throw std::invalid_argument("Field 'Foot4TraceZ' is wrong type; expected a double.");
    }
  }
  //----------------------------------------------------------------------------
  MDArray_T lander_msg_gait_feedback_msgsRequest_common::get_arr(MDFactory_T& factory, const lander::gait_feedback_msgs::Request* msg,
       MultiLibLoader loader, size_t size) {
    auto outArray = factory.createStructArray({size,1},{"MessageType","CommandIndex","LegIndex","Foot1Motion","Foot2Motion","Foot3Motion","Foot4Motion","DataNum","Foot1TraceX","Foot1TraceY","Foot1TraceZ","Foot2TraceX","Foot2TraceY","Foot2TraceZ","Foot3TraceX","Foot3TraceY","Foot3TraceZ","Foot4TraceX","Foot4TraceY","Foot4TraceZ"});
    for(size_t ctr = 0; ctr < size; ctr++){
    outArray[ctr]["MessageType"] = factory.createCharArray("lander/gait_feedback_msgsRequest");
    // command_index
    auto currentElement_command_index = (msg + ctr)->command_index;
    outArray[ctr]["CommandIndex"] = factory.createScalar(currentElement_command_index);
    // leg_index
    auto currentElement_leg_index = (msg + ctr)->leg_index;
    outArray[ctr]["LegIndex"] = factory.createScalar(currentElement_leg_index);
    // foot1_motion
    auto currentElement_foot1_motion = (msg + ctr)->foot1_motion;
    outArray[ctr]["Foot1Motion"] = factory.createArray<lander::gait_feedback_msgs::Request::_foot1_motion_type::const_iterator, double>({currentElement_foot1_motion.size(),1}, currentElement_foot1_motion.begin(), currentElement_foot1_motion.end());
    // foot2_motion
    auto currentElement_foot2_motion = (msg + ctr)->foot2_motion;
    outArray[ctr]["Foot2Motion"] = factory.createArray<lander::gait_feedback_msgs::Request::_foot2_motion_type::const_iterator, double>({currentElement_foot2_motion.size(),1}, currentElement_foot2_motion.begin(), currentElement_foot2_motion.end());
    // foot3_motion
    auto currentElement_foot3_motion = (msg + ctr)->foot3_motion;
    outArray[ctr]["Foot3Motion"] = factory.createArray<lander::gait_feedback_msgs::Request::_foot3_motion_type::const_iterator, double>({currentElement_foot3_motion.size(),1}, currentElement_foot3_motion.begin(), currentElement_foot3_motion.end());
    // foot4_motion
    auto currentElement_foot4_motion = (msg + ctr)->foot4_motion;
    outArray[ctr]["Foot4Motion"] = factory.createArray<lander::gait_feedback_msgs::Request::_foot4_motion_type::const_iterator, double>({currentElement_foot4_motion.size(),1}, currentElement_foot4_motion.begin(), currentElement_foot4_motion.end());
    // data_num
    auto currentElement_data_num = (msg + ctr)->data_num;
    outArray[ctr]["DataNum"] = factory.createScalar(currentElement_data_num);
    // foot1_trace_x
    auto currentElement_foot1_trace_x = (msg + ctr)->foot1_trace_x;
    outArray[ctr]["Foot1TraceX"] = factory.createArray<lander::gait_feedback_msgs::Request::_foot1_trace_x_type::const_iterator, double>({currentElement_foot1_trace_x.size(),1}, currentElement_foot1_trace_x.begin(), currentElement_foot1_trace_x.end());
    // foot1_trace_y
    auto currentElement_foot1_trace_y = (msg + ctr)->foot1_trace_y;
    outArray[ctr]["Foot1TraceY"] = factory.createArray<lander::gait_feedback_msgs::Request::_foot1_trace_y_type::const_iterator, double>({currentElement_foot1_trace_y.size(),1}, currentElement_foot1_trace_y.begin(), currentElement_foot1_trace_y.end());
    // foot1_trace_z
    auto currentElement_foot1_trace_z = (msg + ctr)->foot1_trace_z;
    outArray[ctr]["Foot1TraceZ"] = factory.createArray<lander::gait_feedback_msgs::Request::_foot1_trace_z_type::const_iterator, double>({currentElement_foot1_trace_z.size(),1}, currentElement_foot1_trace_z.begin(), currentElement_foot1_trace_z.end());
    // foot2_trace_x
    auto currentElement_foot2_trace_x = (msg + ctr)->foot2_trace_x;
    outArray[ctr]["Foot2TraceX"] = factory.createArray<lander::gait_feedback_msgs::Request::_foot2_trace_x_type::const_iterator, double>({currentElement_foot2_trace_x.size(),1}, currentElement_foot2_trace_x.begin(), currentElement_foot2_trace_x.end());
    // foot2_trace_y
    auto currentElement_foot2_trace_y = (msg + ctr)->foot2_trace_y;
    outArray[ctr]["Foot2TraceY"] = factory.createArray<lander::gait_feedback_msgs::Request::_foot2_trace_y_type::const_iterator, double>({currentElement_foot2_trace_y.size(),1}, currentElement_foot2_trace_y.begin(), currentElement_foot2_trace_y.end());
    // foot2_trace_z
    auto currentElement_foot2_trace_z = (msg + ctr)->foot2_trace_z;
    outArray[ctr]["Foot2TraceZ"] = factory.createArray<lander::gait_feedback_msgs::Request::_foot2_trace_z_type::const_iterator, double>({currentElement_foot2_trace_z.size(),1}, currentElement_foot2_trace_z.begin(), currentElement_foot2_trace_z.end());
    // foot3_trace_x
    auto currentElement_foot3_trace_x = (msg + ctr)->foot3_trace_x;
    outArray[ctr]["Foot3TraceX"] = factory.createArray<lander::gait_feedback_msgs::Request::_foot3_trace_x_type::const_iterator, double>({currentElement_foot3_trace_x.size(),1}, currentElement_foot3_trace_x.begin(), currentElement_foot3_trace_x.end());
    // foot3_trace_y
    auto currentElement_foot3_trace_y = (msg + ctr)->foot3_trace_y;
    outArray[ctr]["Foot3TraceY"] = factory.createArray<lander::gait_feedback_msgs::Request::_foot3_trace_y_type::const_iterator, double>({currentElement_foot3_trace_y.size(),1}, currentElement_foot3_trace_y.begin(), currentElement_foot3_trace_y.end());
    // foot3_trace_z
    auto currentElement_foot3_trace_z = (msg + ctr)->foot3_trace_z;
    outArray[ctr]["Foot3TraceZ"] = factory.createArray<lander::gait_feedback_msgs::Request::_foot3_trace_z_type::const_iterator, double>({currentElement_foot3_trace_z.size(),1}, currentElement_foot3_trace_z.begin(), currentElement_foot3_trace_z.end());
    // foot4_trace_x
    auto currentElement_foot4_trace_x = (msg + ctr)->foot4_trace_x;
    outArray[ctr]["Foot4TraceX"] = factory.createArray<lander::gait_feedback_msgs::Request::_foot4_trace_x_type::const_iterator, double>({currentElement_foot4_trace_x.size(),1}, currentElement_foot4_trace_x.begin(), currentElement_foot4_trace_x.end());
    // foot4_trace_y
    auto currentElement_foot4_trace_y = (msg + ctr)->foot4_trace_y;
    outArray[ctr]["Foot4TraceY"] = factory.createArray<lander::gait_feedback_msgs::Request::_foot4_trace_y_type::const_iterator, double>({currentElement_foot4_trace_y.size(),1}, currentElement_foot4_trace_y.begin(), currentElement_foot4_trace_y.end());
    // foot4_trace_z
    auto currentElement_foot4_trace_z = (msg + ctr)->foot4_trace_z;
    outArray[ctr]["Foot4TraceZ"] = factory.createArray<lander::gait_feedback_msgs::Request::_foot4_trace_z_type::const_iterator, double>({currentElement_foot4_trace_z.size(),1}, currentElement_foot4_trace_z.begin(), currentElement_foot4_trace_z.end());
    }
    return std::move(outArray);
  }
class LANDER_EXPORT lander_msg_gait_feedback_msgsResponse_common : public MATLABROSMsgInterface<lander::gait_feedback_msgs::Response> {
  public:
    virtual ~lander_msg_gait_feedback_msgsResponse_common(){}
    virtual void copy_from_struct(lander::gait_feedback_msgs::Response* msg, const matlab::data::Struct& arr, MultiLibLoader loader); 
    //----------------------------------------------------------------------------
    virtual MDArray_T get_arr(MDFactory_T& factory, const lander::gait_feedback_msgs::Response* msg, MultiLibLoader loader, size_t size = 1);
};
  void lander_msg_gait_feedback_msgsResponse_common::copy_from_struct(lander::gait_feedback_msgs::Response* msg, const matlab::data::Struct& arr,
               MultiLibLoader loader) {
    try {
        //isFinish
        const matlab::data::TypedArray<bool> isFinish_arr = arr["IsFinish"];
        msg->isFinish = isFinish_arr[0];
    } catch (matlab::data::InvalidFieldNameException&) {
        throw std::invalid_argument("Field 'IsFinish' is missing.");
    } catch (matlab::Exception&) {
        throw std::invalid_argument("Field 'IsFinish' is wrong type; expected a logical.");
    }
    try {
        //foot1_position
        const matlab::data::TypedArray<double> foot1_position_arr = arr["Foot1Position"];
        size_t nelem = 3;
        	std::copy(foot1_position_arr.begin(), foot1_position_arr.begin()+nelem, msg->foot1_position.begin());
    } catch (matlab::data::InvalidFieldNameException&) {
        throw std::invalid_argument("Field 'Foot1Position' is missing.");
    } catch (matlab::Exception&) {
        throw std::invalid_argument("Field 'Foot1Position' is wrong type; expected a double.");
    }
    try {
        //foot2_position
        const matlab::data::TypedArray<double> foot2_position_arr = arr["Foot2Position"];
        size_t nelem = 3;
        	std::copy(foot2_position_arr.begin(), foot2_position_arr.begin()+nelem, msg->foot2_position.begin());
    } catch (matlab::data::InvalidFieldNameException&) {
        throw std::invalid_argument("Field 'Foot2Position' is missing.");
    } catch (matlab::Exception&) {
        throw std::invalid_argument("Field 'Foot2Position' is wrong type; expected a double.");
    }
    try {
        //foot3_position
        const matlab::data::TypedArray<double> foot3_position_arr = arr["Foot3Position"];
        size_t nelem = 3;
        	std::copy(foot3_position_arr.begin(), foot3_position_arr.begin()+nelem, msg->foot3_position.begin());
    } catch (matlab::data::InvalidFieldNameException&) {
        throw std::invalid_argument("Field 'Foot3Position' is missing.");
    } catch (matlab::Exception&) {
        throw std::invalid_argument("Field 'Foot3Position' is wrong type; expected a double.");
    }
    try {
        //foot4_position
        const matlab::data::TypedArray<double> foot4_position_arr = arr["Foot4Position"];
        size_t nelem = 3;
        	std::copy(foot4_position_arr.begin(), foot4_position_arr.begin()+nelem, msg->foot4_position.begin());
    } catch (matlab::data::InvalidFieldNameException&) {
        throw std::invalid_argument("Field 'Foot4Position' is missing.");
    } catch (matlab::Exception&) {
        throw std::invalid_argument("Field 'Foot4Position' is wrong type; expected a double.");
    }
  }
  //----------------------------------------------------------------------------
  MDArray_T lander_msg_gait_feedback_msgsResponse_common::get_arr(MDFactory_T& factory, const lander::gait_feedback_msgs::Response* msg,
       MultiLibLoader loader, size_t size) {
    auto outArray = factory.createStructArray({size,1},{"MessageType","IsFinish","Foot1Position","Foot2Position","Foot3Position","Foot4Position"});
    for(size_t ctr = 0; ctr < size; ctr++){
    outArray[ctr]["MessageType"] = factory.createCharArray("lander/gait_feedback_msgsResponse");
    // isFinish
    auto currentElement_isFinish = (msg + ctr)->isFinish;
    outArray[ctr]["IsFinish"] = factory.createScalar(static_cast<bool>(currentElement_isFinish));
    // foot1_position
    auto currentElement_foot1_position = (msg + ctr)->foot1_position;
    outArray[ctr]["Foot1Position"] = factory.createArray<lander::gait_feedback_msgs::Response::_foot1_position_type::const_iterator, double>({currentElement_foot1_position.size(),1}, currentElement_foot1_position.begin(), currentElement_foot1_position.end());
    // foot2_position
    auto currentElement_foot2_position = (msg + ctr)->foot2_position;
    outArray[ctr]["Foot2Position"] = factory.createArray<lander::gait_feedback_msgs::Response::_foot2_position_type::const_iterator, double>({currentElement_foot2_position.size(),1}, currentElement_foot2_position.begin(), currentElement_foot2_position.end());
    // foot3_position
    auto currentElement_foot3_position = (msg + ctr)->foot3_position;
    outArray[ctr]["Foot3Position"] = factory.createArray<lander::gait_feedback_msgs::Response::_foot3_position_type::const_iterator, double>({currentElement_foot3_position.size(),1}, currentElement_foot3_position.begin(), currentElement_foot3_position.end());
    // foot4_position
    auto currentElement_foot4_position = (msg + ctr)->foot4_position;
    outArray[ctr]["Foot4Position"] = factory.createArray<lander::gait_feedback_msgs::Response::_foot4_position_type::const_iterator, double>({currentElement_foot4_position.size(),1}, currentElement_foot4_position.begin(), currentElement_foot4_position.end());
    }
    return std::move(outArray);
  } 
class LANDER_EXPORT lander_gait_feedback_msgs_service : public ROSMsgElementInterfaceFactory {
  public:
    virtual ~lander_gait_feedback_msgs_service(){}
    virtual std::shared_ptr<MATLABPublisherInterface> generatePublisherInterface(ElementType type);
    virtual std::shared_ptr<MATLABSubscriberInterface> generateSubscriberInterface(ElementType type);
    virtual std::shared_ptr<MATLABRosbagWriterInterface> generateRosbagWriterInterface(ElementType type);
    virtual std::shared_ptr<MATLABSvcServerInterface> generateSvcServerInterface();
    virtual std::shared_ptr<MATLABSvcClientInterface> generateSvcClientInterface();
};  
  std::shared_ptr<MATLABPublisherInterface> 
          lander_gait_feedback_msgs_service::generatePublisherInterface(ElementType type){
    std::shared_ptr<MATLABPublisherInterface> ptr;
    if(type == eRequest){
        ptr = std::make_shared<ROSPublisherImpl<lander::gait_feedback_msgs::Request,lander_msg_gait_feedback_msgsRequest_common>>();
    }else if(type == eResponse){
        ptr = std::make_shared<ROSPublisherImpl<lander::gait_feedback_msgs::Response,lander_msg_gait_feedback_msgsResponse_common>>();
    }else{
        throw std::invalid_argument("Wrong input, Expected 'Request' or 'Response'");
    }
    return ptr;
  }
  std::shared_ptr<MATLABSubscriberInterface> 
          lander_gait_feedback_msgs_service::generateSubscriberInterface(ElementType type){
    std::shared_ptr<MATLABSubscriberInterface> ptr;
    if(type == eRequest){
        ptr = std::make_shared<ROSSubscriberImpl<lander::gait_feedback_msgs::Request,lander::gait_feedback_msgs::Request::ConstPtr,lander_msg_gait_feedback_msgsRequest_common>>();
    }else if(type == eResponse){
        ptr = std::make_shared<ROSSubscriberImpl<lander::gait_feedback_msgs::Response,lander::gait_feedback_msgs::Response::ConstPtr,lander_msg_gait_feedback_msgsResponse_common>>();
    }else{
        throw std::invalid_argument("Wrong input, Expected 'Request' or 'Response'");
    }
    return ptr;
  }
  std::shared_ptr<MATLABSvcServerInterface> 
          lander_gait_feedback_msgs_service::generateSvcServerInterface(){
    return std::make_shared<ROSSvcServerImpl<lander::gait_feedback_msgs::Request,lander::gait_feedback_msgs::Response,lander_msg_gait_feedback_msgsRequest_common,lander_msg_gait_feedback_msgsResponse_common>>();
  }
  std::shared_ptr<MATLABSvcClientInterface> 
          lander_gait_feedback_msgs_service::generateSvcClientInterface(){
    return std::make_shared<ROSSvcClientImpl<lander::gait_feedback_msgs,lander::gait_feedback_msgs::Request,lander::gait_feedback_msgs::Response,lander_msg_gait_feedback_msgsRequest_common,lander_msg_gait_feedback_msgsResponse_common>>();
  }
#include "ROSbagTemplates.hpp" 
  std::shared_ptr<MATLABRosbagWriterInterface> 
          lander_gait_feedback_msgs_service::generateRosbagWriterInterface(ElementType type){
    std::shared_ptr<MATLABRosbagWriterInterface> ptr;
    if(type == eRequest){
        ptr = std::make_shared<ROSBagWriterImpl<lander::gait_feedback_msgsRequest,lander_msg_gait_feedback_msgsRequest_common>>();
    }else if(type == eResponse){
        ptr = std::make_shared<ROSBagWriterImpl<lander::gait_feedback_msgsResponse,lander_msg_gait_feedback_msgsResponse_common>>();
    }else{
        throw std::invalid_argument("Wrong input, Expected 'Request' or 'Response'");
    }
    return ptr;
  }
#include "register_macro.hpp"
// Register the component with class_loader.
// This acts as a sort of entry point, allowing the component to be discoverable when its library
// is being loaded into a running process.
CLASS_LOADER_REGISTER_CLASS(lander_msg_gait_feedback_msgsRequest_common, MATLABROSMsgInterface<lander::gait_feedback_msgsRequest>)
CLASS_LOADER_REGISTER_CLASS(lander_msg_gait_feedback_msgsResponse_common, MATLABROSMsgInterface<lander::gait_feedback_msgsResponse>)
CLASS_LOADER_REGISTER_CLASS(lander_gait_feedback_msgs_service, ROSMsgElementInterfaceFactory)
#ifdef _MSC_VER
#pragma warning(pop)
#else
#pragma GCC diagnostic pop
#endif //_MSC_VER
//gen-1
