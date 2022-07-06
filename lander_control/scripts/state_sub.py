#! /usr/bin/env python3


"""
    需求: 实现基本的话题通信，一方发布数据，一方接收数据，
         实现的关键点:
         1.发送方
         2.接收方
         3.数据(此处为普通文本)


    消息订阅方:
        订阅话题并打印接收到的消息

    实现流程:
        1.导包 
        2.初始化 ROS 节点:命名(唯一)
        3.实例化 订阅者 对象
        4.处理订阅的消息(回调函数)
        5.设置循环调用回调函数



"""
#1.导包 
import rospy
from std_msgs.msg import String
import time


msg = String()  #创建 msg 对象
count = 10  #计数器 


def doMsg(msg):
    rospy.loginfo("I heard:%s",msg.data)
    msg.data = str(count)
    pub.publish(msg)
    rospy.loginfo("写出的数据:%s",msg.data)
    count += 1
    

if __name__ == "__main__":
    #2.初始化 ROS 节点:命名(唯一)
    rospy.init_node("RL")
    #3.实例化 订阅者 对象
    pub = rospy.Publisher("control",String,queue_size=10)
    sub = rospy.Subscriber("state",String,doMsg,queue_size=10)

    # rate = rospy.Rate(100)
    # while count<2000:

    #     #拼接字符串
    #     msg.data = str(count)

    #     pub.publish(msg)
    #     rate.sleep()
    #     rospy.loginfo("写出的数据:%s",msg.data)
    #     count += 1
    time.sleep(20)
    msg.data = str(count)

    pub.publish(msg)
    rospy.loginfo("写出的数据:%s",msg.data)
    count += 1

      
    #4.处理订阅的消息(回调函数)
    #5.设置循环调用回调函数
    rospy.spin()
