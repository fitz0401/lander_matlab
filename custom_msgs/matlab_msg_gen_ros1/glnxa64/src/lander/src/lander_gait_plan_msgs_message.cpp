// Copyright 2019-2021 The MathWorks, Inc.
// Common copy functions for lander/gait_plan_msgs
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
#include "lander/gait_plan_msgs.h"
#include "visibility_control.h"
#include "MATLABROSMsgInterface.hpp"
#include "ROSPubSubTemplates.hpp"
class LANDER_EXPORT lander_msg_gait_plan_msgs_common : public MATLABROSMsgInterface<lander::gait_plan_msgs> {
  public:
    virtual ~lander_msg_gait_plan_msgs_common(){}
    virtual void copy_from_struct(lander::gait_plan_msgs* msg, const matlab::data::Struct& arr, MultiLibLoader loader); 
    //----------------------------------------------------------------------------
    virtual MDArray_T get_arr(MDFactory_T& factory, const lander::gait_plan_msgs* msg, MultiLibLoader loader, size_t size = 1);
};
  void lander_msg_gait_plan_msgs_common::copy_from_struct(lander::gait_plan_msgs* msg, const matlab::data::Struct& arr,
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
  MDArray_T lander_msg_gait_plan_msgs_common::get_arr(MDFactory_T& factory, const lander::gait_plan_msgs* msg,
       MultiLibLoader loader, size_t size) {
    auto outArray = factory.createStructArray({size,1},{"MessageType","CommandIndex","LegIndex","Foot1Motion","Foot2Motion","Foot3Motion","Foot4Motion","DataNum","Foot1TraceX","Foot1TraceY","Foot1TraceZ","Foot2TraceX","Foot2TraceY","Foot2TraceZ","Foot3TraceX","Foot3TraceY","Foot3TraceZ","Foot4TraceX","Foot4TraceY","Foot4TraceZ"});
    for(size_t ctr = 0; ctr < size; ctr++){
    outArray[ctr]["MessageType"] = factory.createCharArray("lander/gait_plan_msgs");
    // command_index
    auto currentElement_command_index = (msg + ctr)->command_index;
    outArray[ctr]["CommandIndex"] = factory.createScalar(currentElement_command_index);
    // leg_index
    auto currentElement_leg_index = (msg + ctr)->leg_index;
    outArray[ctr]["LegIndex"] = factory.createScalar(currentElement_leg_index);
    // foot1_motion
    auto currentElement_foot1_motion = (msg + ctr)->foot1_motion;
    outArray[ctr]["Foot1Motion"] = factory.createArray<lander::gait_plan_msgs::_foot1_motion_type::const_iterator, double>({currentElement_foot1_motion.size(),1}, currentElement_foot1_motion.begin(), currentElement_foot1_motion.end());
    // foot2_motion
    auto currentElement_foot2_motion = (msg + ctr)->foot2_motion;
    outArray[ctr]["Foot2Motion"] = factory.createArray<lander::gait_plan_msgs::_foot2_motion_type::const_iterator, double>({currentElement_foot2_motion.size(),1}, currentElement_foot2_motion.begin(), currentElement_foot2_motion.end());
    // foot3_motion
    auto currentElement_foot3_motion = (msg + ctr)->foot3_motion;
    outArray[ctr]["Foot3Motion"] = factory.createArray<lander::gait_plan_msgs::_foot3_motion_type::const_iterator, double>({currentElement_foot3_motion.size(),1}, currentElement_foot3_motion.begin(), currentElement_foot3_motion.end());
    // foot4_motion
    auto currentElement_foot4_motion = (msg + ctr)->foot4_motion;
    outArray[ctr]["Foot4Motion"] = factory.createArray<lander::gait_plan_msgs::_foot4_motion_type::const_iterator, double>({currentElement_foot4_motion.size(),1}, currentElement_foot4_motion.begin(), currentElement_foot4_motion.end());
    // data_num
    auto currentElement_data_num = (msg + ctr)->data_num;
    outArray[ctr]["DataNum"] = factory.createScalar(currentElement_data_num);
    // foot1_trace_x
    auto currentElement_foot1_trace_x = (msg + ctr)->foot1_trace_x;
    outArray[ctr]["Foot1TraceX"] = factory.createArray<lander::gait_plan_msgs::_foot1_trace_x_type::const_iterator, double>({currentElement_foot1_trace_x.size(),1}, currentElement_foot1_trace_x.begin(), currentElement_foot1_trace_x.end());
    // foot1_trace_y
    auto currentElement_foot1_trace_y = (msg + ctr)->foot1_trace_y;
    outArray[ctr]["Foot1TraceY"] = factory.createArray<lander::gait_plan_msgs::_foot1_trace_y_type::const_iterator, double>({currentElement_foot1_trace_y.size(),1}, currentElement_foot1_trace_y.begin(), currentElement_foot1_trace_y.end());
    // foot1_trace_z
    auto currentElement_foot1_trace_z = (msg + ctr)->foot1_trace_z;
    outArray[ctr]["Foot1TraceZ"] = factory.createArray<lander::gait_plan_msgs::_foot1_trace_z_type::const_iterator, double>({currentElement_foot1_trace_z.size(),1}, currentElement_foot1_trace_z.begin(), currentElement_foot1_trace_z.end());
    // foot2_trace_x
    auto currentElement_foot2_trace_x = (msg + ctr)->foot2_trace_x;
    outArray[ctr]["Foot2TraceX"] = factory.createArray<lander::gait_plan_msgs::_foot2_trace_x_type::const_iterator, double>({currentElement_foot2_trace_x.size(),1}, currentElement_foot2_trace_x.begin(), currentElement_foot2_trace_x.end());
    // foot2_trace_y
    auto currentElement_foot2_trace_y = (msg + ctr)->foot2_trace_y;
    outArray[ctr]["Foot2TraceY"] = factory.createArray<lander::gait_plan_msgs::_foot2_trace_y_type::const_iterator, double>({currentElement_foot2_trace_y.size(),1}, currentElement_foot2_trace_y.begin(), currentElement_foot2_trace_y.end());
    // foot2_trace_z
    auto currentElement_foot2_trace_z = (msg + ctr)->foot2_trace_z;
    outArray[ctr]["Foot2TraceZ"] = factory.createArray<lander::gait_plan_msgs::_foot2_trace_z_type::const_iterator, double>({currentElement_foot2_trace_z.size(),1}, currentElement_foot2_trace_z.begin(), currentElement_foot2_trace_z.end());
    // foot3_trace_x
    auto currentElement_foot3_trace_x = (msg + ctr)->foot3_trace_x;
    outArray[ctr]["Foot3TraceX"] = factory.createArray<lander::gait_plan_msgs::_foot3_trace_x_type::const_iterator, double>({currentElement_foot3_trace_x.size(),1}, currentElement_foot3_trace_x.begin(), currentElement_foot3_trace_x.end());
    // foot3_trace_y
    auto currentElement_foot3_trace_y = (msg + ctr)->foot3_trace_y;
    outArray[ctr]["Foot3TraceY"] = factory.createArray<lander::gait_plan_msgs::_foot3_trace_y_type::const_iterator, double>({currentElement_foot3_trace_y.size(),1}, currentElement_foot3_trace_y.begin(), currentElement_foot3_trace_y.end());
    // foot3_trace_z
    auto currentElement_foot3_trace_z = (msg + ctr)->foot3_trace_z;
    outArray[ctr]["Foot3TraceZ"] = factory.createArray<lander::gait_plan_msgs::_foot3_trace_z_type::const_iterator, double>({currentElement_foot3_trace_z.size(),1}, currentElement_foot3_trace_z.begin(), currentElement_foot3_trace_z.end());
    // foot4_trace_x
    auto currentElement_foot4_trace_x = (msg + ctr)->foot4_trace_x;
    outArray[ctr]["Foot4TraceX"] = factory.createArray<lander::gait_plan_msgs::_foot4_trace_x_type::const_iterator, double>({currentElement_foot4_trace_x.size(),1}, currentElement_foot4_trace_x.begin(), currentElement_foot4_trace_x.end());
    // foot4_trace_y
    auto currentElement_foot4_trace_y = (msg + ctr)->foot4_trace_y;
    outArray[ctr]["Foot4TraceY"] = factory.createArray<lander::gait_plan_msgs::_foot4_trace_y_type::const_iterator, double>({currentElement_foot4_trace_y.size(),1}, currentElement_foot4_trace_y.begin(), currentElement_foot4_trace_y.end());
    // foot4_trace_z
    auto currentElement_foot4_trace_z = (msg + ctr)->foot4_trace_z;
    outArray[ctr]["Foot4TraceZ"] = factory.createArray<lander::gait_plan_msgs::_foot4_trace_z_type::const_iterator, double>({currentElement_foot4_trace_z.size(),1}, currentElement_foot4_trace_z.begin(), currentElement_foot4_trace_z.end());
    }
    return std::move(outArray);
  } 
class LANDER_EXPORT lander_gait_plan_msgs_message : public ROSMsgElementInterfaceFactory {
  public:
    virtual ~lander_gait_plan_msgs_message(){}
    virtual std::shared_ptr<MATLABPublisherInterface> generatePublisherInterface(ElementType type);
    virtual std::shared_ptr<MATLABSubscriberInterface> generateSubscriberInterface(ElementType type);
    virtual std::shared_ptr<MATLABRosbagWriterInterface> generateRosbagWriterInterface(ElementType type);
};  
  std::shared_ptr<MATLABPublisherInterface> 
          lander_gait_plan_msgs_message::generatePublisherInterface(ElementType type){
    if(type != eMessage){
        throw std::invalid_argument("Wrong input, Expected eMessage");
    }
    return std::make_shared<ROSPublisherImpl<lander::gait_plan_msgs,lander_msg_gait_plan_msgs_common>>();
  }
  std::shared_ptr<MATLABSubscriberInterface> 
         lander_gait_plan_msgs_message::generateSubscriberInterface(ElementType type){
    if(type != eMessage){
        throw std::invalid_argument("Wrong input, Expected eMessage");
    }
    return std::make_shared<ROSSubscriberImpl<lander::gait_plan_msgs,lander::gait_plan_msgs::ConstPtr,lander_msg_gait_plan_msgs_common>>();
  }
#include "ROSbagTemplates.hpp" 
  std::shared_ptr<MATLABRosbagWriterInterface>
         lander_gait_plan_msgs_message::generateRosbagWriterInterface(ElementType type){
    if(type != eMessage){
        throw std::invalid_argument("Wrong input, Expected eMessage");
    }
    return std::make_shared<ROSBagWriterImpl<lander::gait_plan_msgs,lander_msg_gait_plan_msgs_common>>();
  }
#include "register_macro.hpp"
// Register the component with class_loader.
// This acts as a sort of entry point, allowing the component to be discoverable when its library
// is being loaded into a running process.
CLASS_LOADER_REGISTER_CLASS(lander_msg_gait_plan_msgs_common, MATLABROSMsgInterface<lander::gait_plan_msgs>)
CLASS_LOADER_REGISTER_CLASS(lander_gait_plan_msgs_message, ROSMsgElementInterfaceFactory)
#ifdef _MSC_VER
#pragma warning(pop)
#else
#pragma GCC diagnostic pop
#endif //_MSC_VER
//gen-1