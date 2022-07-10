/*
    需求: 
        编写两个节点实现服务通信，客户端节点需要提交两个整数到服务器
        服务器需要解析客户端提交的数据，相加后，将结果响应回客户端，
        客户端再解析

    服务器实现:
        1.包含头文件
        2.初始化 ROS 节点
        3.创建 ROS 句柄
        4.创建 客户端 对象
        5.请求服务，接收响应

*/
// 1.包含头文件
#include "ros/ros.h"
#include "lander_control/gait_plan_msgs.h"

int main(int argc, char *argv[])
{
    setlocale(LC_ALL,"");
    // 2.初始化 ROS 节点
    ros::init(argc,argv,"Control_Plan_Client");
    // 3.创建 ROS 句柄
    ros::NodeHandle nh;
    // 4.创建发布者对象
    ros::Publisher pub = nh.advertise<lander_control::gait_plan_msgs>("GaitPlan",1000);
    // 5.组织被发布的消息，编写发布逻辑并发布消息
    lander_control::gait_plan_msgs rq;
    // 0:getpos; 1:init; 2:planfoot; 3:planmotion

    // sleep
    sleep(10);
    rq.command_index = 1;


    rq.leg_index = 12;
    // rq.foot1_motion = {0.0, 0.0 ,-75.0 };
    // rq.foot2_motion = {0.0, 0.0 ,-75.0 };
    // rq.foot3_motion = {0.0, 0.0 ,-75.0 };
    // rq.foot4_motion = {0.0, 0.0 ,-75.0 };
    rq.foot1_motion = {-6.84, -25, -74.86};
    rq.foot2_motion = {-6.84, 25, -74.86};
    rq.foot3_motion = {-6.84, -25, -74.86};
    rq.foot4_motion = {-6.84, 25, -74.86};
    rq.data_num = 10;
    // rq.foot1_trace_x = {441.840797218405, 443.050321975698, 444.259846732991, 445.469371490284,446.678896247577, 
    //                             447.888421004869, 449.097945762162, 450.307470519455, 451.516995276748, 452.72652003404};
    // rq.foot1_trace_y = {-5.40E-15, 0.093040365945606, 0.186080731891216, 0.279121097836787,0.372161463782398,
    //                             0.465201829727969, 0.55824219567358, 0.651282561619191, 0.744322927564761, 0.837363293510372};
    // rq.foot1_trace_z = {-520.1427, -520.1427, -520.1427, -520.1427,-520.1427, 
    //                             -520.1427, -520.1427, -520.1427, -520.1427, -520.1427};
    // rq.foot2_trace_x = {441.840797218405, 443.050321975698, 444.259846732991, 445.469371490284,446.678896247577, 
    //                             447.888421004869, 449.097945762162, 450.307470519455, 451.516995276748, 452.72652003404};
    // rq.foot2_trace_y = {-5.40E-15, 0.093040365945606, 0.186080731891216, 0.279121097836787,0.372161463782398,
    //                             0.465201829727969, 0.55824219567358, 0.651282561619191, 0.744322927564761, 0.837363293510372};
    // rq.foot2_trace_z = {-520.1427, -520.1427, -520.1427, -520.1427,-520.1427, 
    //                             -520.1427, -520.1427, -520.1427, -520.1427, -520.1427};
    // rq.foot3_trace_x = {441.840797218405, 443.050321975698, 444.259846732991, 445.469371490284,446.678896247577, 
    //                             447.888421004869, 449.097945762162, 450.307470519455, 451.516995276748, 452.72652003404};
    // rq.foot3_trace_y = {-5.40E-15, 0.093040365945606, 0.186080731891216, 0.279121097836787,0.372161463782398,
    //                             0.465201829727969, 0.55824219567358, 0.651282561619191, 0.744322927564761, 0.837363293510372};
    // rq.foot3_trace_z = {-520.1427, -520.1427, -520.1427, -520.1427,-520.1427, 
    //                             -520.1427, -520.1427, -520.1427, -520.1427, -520.1427};
    // rq.foot4_trace_x = {441.840797218405, 443.050321975698, 444.259846732991, 445.469371490284,446.678896247577, 
    //                             447.888421004869, 449.097945762162, 450.307470519455, 451.516995276748, 452.72652003404};
    // rq.foot4_trace_y = {-5.40E-15, 0.093040365945606, 0.186080731891216, 0.279121097836787,0.372161463782398,
    //                             0.465201829727969, 0.55824219567358, 0.651282561619191, 0.744322927564761, 0.837363293510372};
    // rq.foot4_trace_z = {-520.1427, -520.1427, -520.1427, -520.1427,-520.1427, 
    //                             -520.1427, -520.1427, -520.1427, -520.1427, -520.1427};
    
    rq.foot1_trace_x = {435.000000000000,	435.930403659456,	436.860807318912,	437.791210978368,	438.721614637824,	439.652018297280,	440.582421956736,	441.512825616192,	442.443229275648,	443.373632935104};
    rq.foot1_trace_y = {-24.9999999999998,	-24.9999999999998,	-24.9999999999998,	-24.9999999999998	,-24.9999999999998	,-24.9999999999998,	-24.9999999999998	,-24.9999999999998,	-24.9999999999998,	-24.9999999999998};
    rq.foot1_trace_z = {-520,	-520,	-520,	-520,	-520,	-520,	-520,	-520,	-520,	-520};
    rq.foot2_trace_x = {435.000000000000,	435.000000000000,	435.000000000000,	435.000000000000,	435.000000000000,	435.000000000000,	435.000000000000,	435.000000000000,	435.000000000000,	435.000000000000};
    rq.foot2_trace_y = {24.9999999999998,	24.0695963405438,	23.1391926810878,	22.2087890216319,	21.2783853621758,	20.3479817027199,	19.4175780432638,	18.4871743838079,	17.5567707243519,	16.6263670648959};
    rq.foot2_trace_z = {-520,	-520,	-520,	-520,	-520,	-520,	-520,	-520,	-520,	-520};
    rq.foot3_trace_x = {435.000000000000,	435.930403659456,	436.860807318912,	437.791210978368,	438.721614637824,	439.652018297280,	440.582421956736,	441.512825616192,	442.443229275648,	443.373632935104};
    rq.foot3_trace_y = {-24.9999999999998,	-24.9999999999998,	-24.9999999999998,	-24.9999999999998	,-24.9999999999998	,-24.9999999999998,	-24.9999999999998	,-24.9999999999998,	-24.9999999999998,	-24.9999999999998};
    rq.foot3_trace_z = {-520,	-520,	-520,	-520,	-520,	-520,	-520,	-520,	-520,	-520};
    rq.foot4_trace_x = {435.000000000000,	435.000000000000,	435.000000000000,	435.000000000000,	435.000000000000,	435.000000000000,	435.000000000000,	435.000000000000,	435.000000000000,	435.000000000000};
    rq.foot4_trace_y = {24.9999999999998,	24.0695963405438,	23.1391926810878,	22.2087890216319,	21.2783853621758,	20.3479817027199,	19.4175780432638,	18.4871743838079,	17.5567707243519,	16.6263670648959};
    rq.foot4_trace_z = {-520,	-520,	-520,	-520,	-520,	-520,	-520,	-520,	-520,	-520};
    
    ros::Rate r(1);
    pub.publish(rq);
    r.sleep();
    ros::spinOnce();
    return 0;
}

