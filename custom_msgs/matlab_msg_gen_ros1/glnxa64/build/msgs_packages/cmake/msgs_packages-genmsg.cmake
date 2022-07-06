# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "msgs_packages: 0 messages, 1 services")

set(MSG_I_FLAGS "-Istd_msgs:/home/abc/matlab/sys/ros1/glnxa64/ros1/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(msgs_packages_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/abc/lander_control_ws/src/custom_msgs/matlab_msg_gen_ros1/glnxa64/src/msgs_packages/srv/mv_msgs.srv" NAME_WE)
add_custom_target(_msgs_packages_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "msgs_packages" "/home/abc/lander_control_ws/src/custom_msgs/matlab_msg_gen_ros1/glnxa64/src/msgs_packages/srv/mv_msgs.srv" ""
)

#
#  langs = gencpp;genpy
#

### Section generating for lang: gencpp
### Generating Messages

### Generating Services
_generate_srv_cpp(msgs_packages
  "/home/abc/lander_control_ws/src/custom_msgs/matlab_msg_gen_ros1/glnxa64/src/msgs_packages/srv/mv_msgs.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/msgs_packages
)

### Generating Module File
_generate_module_cpp(msgs_packages
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/msgs_packages
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(msgs_packages_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(msgs_packages_generate_messages msgs_packages_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/abc/lander_control_ws/src/custom_msgs/matlab_msg_gen_ros1/glnxa64/src/msgs_packages/srv/mv_msgs.srv" NAME_WE)
add_dependencies(msgs_packages_generate_messages_cpp _msgs_packages_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(msgs_packages_gencpp)
add_dependencies(msgs_packages_gencpp msgs_packages_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS msgs_packages_generate_messages_cpp)

### Section generating for lang: genpy
### Generating Messages

### Generating Services
_generate_srv_py(msgs_packages
  "/home/abc/lander_control_ws/src/custom_msgs/matlab_msg_gen_ros1/glnxa64/src/msgs_packages/srv/mv_msgs.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/msgs_packages
)

### Generating Module File
_generate_module_py(msgs_packages
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/msgs_packages
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(msgs_packages_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(msgs_packages_generate_messages msgs_packages_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/abc/lander_control_ws/src/custom_msgs/matlab_msg_gen_ros1/glnxa64/src/msgs_packages/srv/mv_msgs.srv" NAME_WE)
add_dependencies(msgs_packages_generate_messages_py _msgs_packages_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(msgs_packages_genpy)
add_dependencies(msgs_packages_genpy msgs_packages_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS msgs_packages_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/msgs_packages)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/msgs_packages
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(msgs_packages_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/msgs_packages)
  install(CODE "execute_process(COMMAND \"/home/abc/.matlab/R2022a/ros1/glnxa64/venv/bin/python3\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/msgs_packages\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/msgs_packages
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(msgs_packages_generate_messages_py std_msgs_generate_messages_py)
endif()
