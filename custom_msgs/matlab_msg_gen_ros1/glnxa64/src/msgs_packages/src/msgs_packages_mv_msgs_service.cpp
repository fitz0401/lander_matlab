// Copyright 2019-2021 The MathWorks, Inc.
// Common copy functions for msgs_packages/mv_msgsRequest
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
#include "msgs_packages/mv_msgs.h"
#include "visibility_control.h"
#include "ROSPubSubTemplates.hpp"
#include "ROSServiceTemplates.hpp"
class MSGS_PACKAGES_EXPORT msgs_packages_msg_mv_msgsRequest_common : public MATLABROSMsgInterface<msgs_packages::mv_msgs::Request> {
  public:
    virtual ~msgs_packages_msg_mv_msgsRequest_common(){}
    virtual void copy_from_struct(msgs_packages::mv_msgs::Request* msg, const matlab::data::Struct& arr, MultiLibLoader loader); 
    //----------------------------------------------------------------------------
    virtual MDArray_T get_arr(MDFactory_T& factory, const msgs_packages::mv_msgs::Request* msg, MultiLibLoader loader, size_t size = 1);
};
  void msgs_packages_msg_mv_msgsRequest_common::copy_from_struct(msgs_packages::mv_msgs::Request* msg, const matlab::data::Struct& arr,
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
        //leg
        const matlab::data::TypedArray<int32_t> leg_arr = arr["Leg"];
        msg->leg = leg_arr[0];
    } catch (matlab::data::InvalidFieldNameException&) {
        throw std::invalid_argument("Field 'Leg' is missing.");
    } catch (matlab::Exception&) {
        throw std::invalid_argument("Field 'Leg' is wrong type; expected a int32.");
    }
    try {
        //x_motion
        const matlab::data::TypedArray<double> x_motion_arr = arr["XMotion"];
        msg->x_motion = x_motion_arr[0];
    } catch (matlab::data::InvalidFieldNameException&) {
        throw std::invalid_argument("Field 'XMotion' is missing.");
    } catch (matlab::Exception&) {
        throw std::invalid_argument("Field 'XMotion' is wrong type; expected a double.");
    }
    try {
        //y_motion
        const matlab::data::TypedArray<double> y_motion_arr = arr["YMotion"];
        msg->y_motion = y_motion_arr[0];
    } catch (matlab::data::InvalidFieldNameException&) {
        throw std::invalid_argument("Field 'YMotion' is missing.");
    } catch (matlab::Exception&) {
        throw std::invalid_argument("Field 'YMotion' is wrong type; expected a double.");
    }
    try {
        //z_motion
        const matlab::data::TypedArray<double> z_motion_arr = arr["ZMotion"];
        msg->z_motion = z_motion_arr[0];
    } catch (matlab::data::InvalidFieldNameException&) {
        throw std::invalid_argument("Field 'ZMotion' is missing.");
    } catch (matlab::Exception&) {
        throw std::invalid_argument("Field 'ZMotion' is wrong type; expected a double.");
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
  MDArray_T msgs_packages_msg_mv_msgsRequest_common::get_arr(MDFactory_T& factory, const msgs_packages::mv_msgs::Request* msg,
       MultiLibLoader loader, size_t size) {
    auto outArray = factory.createStructArray({size,1},{"MessageType","CommandIndex","Leg","XMotion","YMotion","ZMotion","DataNum","Foot1TraceX","Foot1TraceY","Foot1TraceZ","Foot2TraceX","Foot2TraceY","Foot2TraceZ","Foot3TraceX","Foot3TraceY","Foot3TraceZ","Foot4TraceX","Foot4TraceY","Foot4TraceZ"});
    for(size_t ctr = 0; ctr < size; ctr++){
    outArray[ctr]["MessageType"] = factory.createCharArray("msgs_packages/mv_msgsRequest");
    // command_index
    auto currentElement_command_index = (msg + ctr)->command_index;
    outArray[ctr]["CommandIndex"] = factory.createScalar(currentElement_command_index);
    // leg
    auto currentElement_leg = (msg + ctr)->leg;
    outArray[ctr]["Leg"] = factory.createScalar(currentElement_leg);
    // x_motion
    auto currentElement_x_motion = (msg + ctr)->x_motion;
    outArray[ctr]["XMotion"] = factory.createScalar(currentElement_x_motion);
    // y_motion
    auto currentElement_y_motion = (msg + ctr)->y_motion;
    outArray[ctr]["YMotion"] = factory.createScalar(currentElement_y_motion);
    // z_motion
    auto currentElement_z_motion = (msg + ctr)->z_motion;
    outArray[ctr]["ZMotion"] = factory.createScalar(currentElement_z_motion);
    // data_num
    auto currentElement_data_num = (msg + ctr)->data_num;
    outArray[ctr]["DataNum"] = factory.createScalar(currentElement_data_num);
    // foot1_trace_x
    auto currentElement_foot1_trace_x = (msg + ctr)->foot1_trace_x;
    outArray[ctr]["Foot1TraceX"] = factory.createArray<msgs_packages::mv_msgs::Request::_foot1_trace_x_type::const_iterator, double>({currentElement_foot1_trace_x.size(),1}, currentElement_foot1_trace_x.begin(), currentElement_foot1_trace_x.end());
    // foot1_trace_y
    auto currentElement_foot1_trace_y = (msg + ctr)->foot1_trace_y;
    outArray[ctr]["Foot1TraceY"] = factory.createArray<msgs_packages::mv_msgs::Request::_foot1_trace_y_type::const_iterator, double>({currentElement_foot1_trace_y.size(),1}, currentElement_foot1_trace_y.begin(), currentElement_foot1_trace_y.end());
    // foot1_trace_z
    auto currentElement_foot1_trace_z = (msg + ctr)->foot1_trace_z;
    outArray[ctr]["Foot1TraceZ"] = factory.createArray<msgs_packages::mv_msgs::Request::_foot1_trace_z_type::const_iterator, double>({currentElement_foot1_trace_z.size(),1}, currentElement_foot1_trace_z.begin(), currentElement_foot1_trace_z.end());
    // foot2_trace_x
    auto currentElement_foot2_trace_x = (msg + ctr)->foot2_trace_x;
    outArray[ctr]["Foot2TraceX"] = factory.createArray<msgs_packages::mv_msgs::Request::_foot2_trace_x_type::const_iterator, double>({currentElement_foot2_trace_x.size(),1}, currentElement_foot2_trace_x.begin(), currentElement_foot2_trace_x.end());
    // foot2_trace_y
    auto currentElement_foot2_trace_y = (msg + ctr)->foot2_trace_y;
    outArray[ctr]["Foot2TraceY"] = factory.createArray<msgs_packages::mv_msgs::Request::_foot2_trace_y_type::const_iterator, double>({currentElement_foot2_trace_y.size(),1}, currentElement_foot2_trace_y.begin(), currentElement_foot2_trace_y.end());
    // foot2_trace_z
    auto currentElement_foot2_trace_z = (msg + ctr)->foot2_trace_z;
    outArray[ctr]["Foot2TraceZ"] = factory.createArray<msgs_packages::mv_msgs::Request::_foot2_trace_z_type::const_iterator, double>({currentElement_foot2_trace_z.size(),1}, currentElement_foot2_trace_z.begin(), currentElement_foot2_trace_z.end());
    // foot3_trace_x
    auto currentElement_foot3_trace_x = (msg + ctr)->foot3_trace_x;
    outArray[ctr]["Foot3TraceX"] = factory.createArray<msgs_packages::mv_msgs::Request::_foot3_trace_x_type::const_iterator, double>({currentElement_foot3_trace_x.size(),1}, currentElement_foot3_trace_x.begin(), currentElement_foot3_trace_x.end());
    // foot3_trace_y
    auto currentElement_foot3_trace_y = (msg + ctr)->foot3_trace_y;
    outArray[ctr]["Foot3TraceY"] = factory.createArray<msgs_packages::mv_msgs::Request::_foot3_trace_y_type::const_iterator, double>({currentElement_foot3_trace_y.size(),1}, currentElement_foot3_trace_y.begin(), currentElement_foot3_trace_y.end());
    // foot3_trace_z
    auto currentElement_foot3_trace_z = (msg + ctr)->foot3_trace_z;
    outArray[ctr]["Foot3TraceZ"] = factory.createArray<msgs_packages::mv_msgs::Request::_foot3_trace_z_type::const_iterator, double>({currentElement_foot3_trace_z.size(),1}, currentElement_foot3_trace_z.begin(), currentElement_foot3_trace_z.end());
    // foot4_trace_x
    auto currentElement_foot4_trace_x = (msg + ctr)->foot4_trace_x;
    outArray[ctr]["Foot4TraceX"] = factory.createArray<msgs_packages::mv_msgs::Request::_foot4_trace_x_type::const_iterator, double>({currentElement_foot4_trace_x.size(),1}, currentElement_foot4_trace_x.begin(), currentElement_foot4_trace_x.end());
    // foot4_trace_y
    auto currentElement_foot4_trace_y = (msg + ctr)->foot4_trace_y;
    outArray[ctr]["Foot4TraceY"] = factory.createArray<msgs_packages::mv_msgs::Request::_foot4_trace_y_type::const_iterator, double>({currentElement_foot4_trace_y.size(),1}, currentElement_foot4_trace_y.begin(), currentElement_foot4_trace_y.end());
    // foot4_trace_z
    auto currentElement_foot4_trace_z = (msg + ctr)->foot4_trace_z;
    outArray[ctr]["Foot4TraceZ"] = factory.createArray<msgs_packages::mv_msgs::Request::_foot4_trace_z_type::const_iterator, double>({currentElement_foot4_trace_z.size(),1}, currentElement_foot4_trace_z.begin(), currentElement_foot4_trace_z.end());
    }
    return std::move(outArray);
  }
class MSGS_PACKAGES_EXPORT msgs_packages_msg_mv_msgsResponse_common : public MATLABROSMsgInterface<msgs_packages::mv_msgs::Response> {
  public:
    virtual ~msgs_packages_msg_mv_msgsResponse_common(){}
    virtual void copy_from_struct(msgs_packages::mv_msgs::Response* msg, const matlab::data::Struct& arr, MultiLibLoader loader); 
    //----------------------------------------------------------------------------
    virtual MDArray_T get_arr(MDFactory_T& factory, const msgs_packages::mv_msgs::Response* msg, MultiLibLoader loader, size_t size = 1);
};
  void msgs_packages_msg_mv_msgsResponse_common::copy_from_struct(msgs_packages::mv_msgs::Response* msg, const matlab::data::Struct& arr,
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
  }
  //----------------------------------------------------------------------------
  MDArray_T msgs_packages_msg_mv_msgsResponse_common::get_arr(MDFactory_T& factory, const msgs_packages::mv_msgs::Response* msg,
       MultiLibLoader loader, size_t size) {
    auto outArray = factory.createStructArray({size,1},{"MessageType","IsFinish"});
    for(size_t ctr = 0; ctr < size; ctr++){
    outArray[ctr]["MessageType"] = factory.createCharArray("msgs_packages/mv_msgsResponse");
    // isFinish
    auto currentElement_isFinish = (msg + ctr)->isFinish;
    outArray[ctr]["IsFinish"] = factory.createScalar(static_cast<bool>(currentElement_isFinish));
    }
    return std::move(outArray);
  } 
class MSGS_PACKAGES_EXPORT msgs_packages_mv_msgs_service : public ROSMsgElementInterfaceFactory {
  public:
    virtual ~msgs_packages_mv_msgs_service(){}
    virtual std::shared_ptr<MATLABPublisherInterface> generatePublisherInterface(ElementType type);
    virtual std::shared_ptr<MATLABSubscriberInterface> generateSubscriberInterface(ElementType type);
    virtual std::shared_ptr<MATLABRosbagWriterInterface> generateRosbagWriterInterface(ElementType type);
    virtual std::shared_ptr<MATLABSvcServerInterface> generateSvcServerInterface();
    virtual std::shared_ptr<MATLABSvcClientInterface> generateSvcClientInterface();
};  
  std::shared_ptr<MATLABPublisherInterface> 
          msgs_packages_mv_msgs_service::generatePublisherInterface(ElementType type){
    std::shared_ptr<MATLABPublisherInterface> ptr;
    if(type == eRequest){
        ptr = std::make_shared<ROSPublisherImpl<msgs_packages::mv_msgs::Request,msgs_packages_msg_mv_msgsRequest_common>>();
    }else if(type == eResponse){
        ptr = std::make_shared<ROSPublisherImpl<msgs_packages::mv_msgs::Response,msgs_packages_msg_mv_msgsResponse_common>>();
    }else{
        throw std::invalid_argument("Wrong input, Expected 'Request' or 'Response'");
    }
    return ptr;
  }
  std::shared_ptr<MATLABSubscriberInterface> 
          msgs_packages_mv_msgs_service::generateSubscriberInterface(ElementType type){
    std::shared_ptr<MATLABSubscriberInterface> ptr;
    if(type == eRequest){
        ptr = std::make_shared<ROSSubscriberImpl<msgs_packages::mv_msgs::Request,msgs_packages::mv_msgs::Request::ConstPtr,msgs_packages_msg_mv_msgsRequest_common>>();
    }else if(type == eResponse){
        ptr = std::make_shared<ROSSubscriberImpl<msgs_packages::mv_msgs::Response,msgs_packages::mv_msgs::Response::ConstPtr,msgs_packages_msg_mv_msgsResponse_common>>();
    }else{
        throw std::invalid_argument("Wrong input, Expected 'Request' or 'Response'");
    }
    return ptr;
  }
  std::shared_ptr<MATLABSvcServerInterface> 
          msgs_packages_mv_msgs_service::generateSvcServerInterface(){
    return std::make_shared<ROSSvcServerImpl<msgs_packages::mv_msgs::Request,msgs_packages::mv_msgs::Response,msgs_packages_msg_mv_msgsRequest_common,msgs_packages_msg_mv_msgsResponse_common>>();
  }
  std::shared_ptr<MATLABSvcClientInterface> 
          msgs_packages_mv_msgs_service::generateSvcClientInterface(){
    return std::make_shared<ROSSvcClientImpl<msgs_packages::mv_msgs,msgs_packages::mv_msgs::Request,msgs_packages::mv_msgs::Response,msgs_packages_msg_mv_msgsRequest_common,msgs_packages_msg_mv_msgsResponse_common>>();
  }
#include "ROSbagTemplates.hpp" 
  std::shared_ptr<MATLABRosbagWriterInterface> 
          msgs_packages_mv_msgs_service::generateRosbagWriterInterface(ElementType type){
    std::shared_ptr<MATLABRosbagWriterInterface> ptr;
    if(type == eRequest){
        ptr = std::make_shared<ROSBagWriterImpl<msgs_packages::mv_msgsRequest,msgs_packages_msg_mv_msgsRequest_common>>();
    }else if(type == eResponse){
        ptr = std::make_shared<ROSBagWriterImpl<msgs_packages::mv_msgsResponse,msgs_packages_msg_mv_msgsResponse_common>>();
    }else{
        throw std::invalid_argument("Wrong input, Expected 'Request' or 'Response'");
    }
    return ptr;
  }
#include "register_macro.hpp"
// Register the component with class_loader.
// This acts as a sort of entry point, allowing the component to be discoverable when its library
// is being loaded into a running process.
CLASS_LOADER_REGISTER_CLASS(msgs_packages_msg_mv_msgsRequest_common, MATLABROSMsgInterface<msgs_packages::mv_msgsRequest>)
CLASS_LOADER_REGISTER_CLASS(msgs_packages_msg_mv_msgsResponse_common, MATLABROSMsgInterface<msgs_packages::mv_msgsResponse>)
CLASS_LOADER_REGISTER_CLASS(msgs_packages_mv_msgs_service, ROSMsgElementInterfaceFactory)
#ifdef _MSC_VER
#pragma warning(pop)
#else
#pragma GCC diagnostic pop
#endif //_MSC_VER
//gen-1
