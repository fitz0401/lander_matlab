# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "lander: 1 messages, 1 services")

set(MSG_I_FLAGS "-Ilander:/home/abc/lander_control_ws/src/custom_msgs/matlab_msg_gen_ros1/glnxa64/src/lander/msg;-Istd_msgs:/home/abc/matlab/sys/ros1/glnxa64/ros1/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(lander_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/abc/lander_control_ws/src/custom_msgs/matlab_msg_gen_ros1/glnxa64/src/lander/msg/gait_plan_msgs.msg" NAME_WE)
add_custom_target(_lander_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "lander" "/home/abc/lander_control_ws/src/custom_msgs/matlab_msg_gen_ros1/glnxa64/src/lander/msg/gait_plan_msgs.msg" ""
)

get_filename_component(_filename "/home/abc/lander_control_ws/src/custom_msgs/matlab_msg_gen_ros1/glnxa64/src/lander/srv/gait_feedback_msgs.srv" NAME_WE)
add_custom_target(_lander_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "lander" "/home/abc/lander_control_ws/src/custom_msgs/matlab_msg_gen_ros1/glnxa64/src/lander/srv/gait_feedback_msgs.srv" ""
)

#
#  langs = gencpp;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(lander
  "/home/abc/lander_control_ws/src/custom_msgs/matlab_msg_gen_ros1/glnxa64/src/lander/msg/gait_plan_msgs.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/lander
)

### Generating Services
_generate_srv_cpp(lander
  "/home/abc/lander_control_ws/src/custom_msgs/matlab_msg_gen_ros1/glnxa64/src/lander/srv/gait_feedback_msgs.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/lander
)

### Generating Module File
_generate_module_cpp(lander
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/lander
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(lander_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(lander_generate_messages lander_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/abc/lander_control_ws/src/custom_msgs/matlab_msg_gen_ros1/glnxa64/src/lander/msg/gait_plan_msgs.msg" NAME_WE)
add_dependencies(lander_generate_messages_cpp _lander_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/abc/lander_control_ws/src/custom_msgs/matlab_msg_gen_ros1/glnxa64/src/lander/srv/gait_feedback_msgs.srv" NAME_WE)
add_dependencies(lander_generate_messages_cpp _lander_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(lander_gencpp)
add_dependencies(lander_gencpp lander_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS lander_generate_messages_cpp)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(lander
  "/home/abc/lander_control_ws/src/custom_msgs/matlab_msg_gen_ros1/glnxa64/src/lander/msg/gait_plan_msgs.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/lander
)

### Generating Services
_generate_srv_py(lander
  "/home/abc/lander_control_ws/src/custom_msgs/matlab_msg_gen_ros1/glnxa64/src/lander/srv/gait_feedback_msgs.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/lander
)

### Generating Module File
_generate_module_py(lander
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/lander
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(lander_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(lander_generate_messages lander_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/abc/lander_control_ws/src/custom_msgs/matlab_msg_gen_ros1/glnxa64/src/lander/msg/gait_plan_msgs.msg" NAME_WE)
add_dependencies(lander_generate_messages_py _lander_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/abc/lander_control_ws/src/custom_msgs/matlab_msg_gen_ros1/glnxa64/src/lander/srv/gait_feedback_msgs.srv" NAME_WE)
add_dependencies(lander_generate_messages_py _lander_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(lander_genpy)
add_dependencies(lander_genpy lander_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS lander_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/lander)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/lander
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(lander_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/lander)
  install(CODE "execute_process(COMMAND \"/home/abc/.matlab/R2022a/ros1/glnxa64/venv/bin/python3\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/lander\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/lander
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(lander_generate_messages_py std_msgs_generate_messages_py)
endif()
