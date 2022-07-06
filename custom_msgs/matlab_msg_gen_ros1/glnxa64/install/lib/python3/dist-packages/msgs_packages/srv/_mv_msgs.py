# This Python file uses the following encoding: utf-8
"""autogenerated by genpy from msgs_packages/mv_msgsRequest.msg. Do not edit."""
import codecs
import sys
python3 = True if sys.hexversion > 0x03000000 else False
import genpy
import struct


class mv_msgsRequest(genpy.Message):
  _md5sum = "486898fd75f9040f7b995c917fb086ec"
  _type = "msgs_packages/mv_msgsRequest"
  _has_header = False  # flag to mark the presence of a Header object
  _full_text = """# 客户端请求
# 0:getpos; 1:init; 2:planfoot; 3:planmotion
int32 command_index
# For planfoot
int32 leg
float64 x_motion
float64 y_motion
float64 z_motion
# For planmotion
int32 data_num
float64[] foot1_trace_x
float64[] foot1_trace_y
float64[] foot1_trace_z
float64[] foot2_trace_x
float64[] foot2_trace_y
float64[] foot2_trace_z
float64[] foot3_trace_x
float64[] foot3_trace_y
float64[] foot3_trace_z
float64[] foot4_trace_x
float64[] foot4_trace_y
float64[] foot4_trace_z
"""
  __slots__ = ['command_index','leg','x_motion','y_motion','z_motion','data_num','foot1_trace_x','foot1_trace_y','foot1_trace_z','foot2_trace_x','foot2_trace_y','foot2_trace_z','foot3_trace_x','foot3_trace_y','foot3_trace_z','foot4_trace_x','foot4_trace_y','foot4_trace_z']
  _slot_types = ['int32','int32','float64','float64','float64','int32','float64[]','float64[]','float64[]','float64[]','float64[]','float64[]','float64[]','float64[]','float64[]','float64[]','float64[]','float64[]']

  def __init__(self, *args, **kwds):
    """
    Constructor. Any message fields that are implicitly/explicitly
    set to None will be assigned a default value. The recommend
    use is keyword arguments as this is more robust to future message
    changes.  You cannot mix in-order arguments and keyword arguments.

    The available fields are:
       command_index,leg,x_motion,y_motion,z_motion,data_num,foot1_trace_x,foot1_trace_y,foot1_trace_z,foot2_trace_x,foot2_trace_y,foot2_trace_z,foot3_trace_x,foot3_trace_y,foot3_trace_z,foot4_trace_x,foot4_trace_y,foot4_trace_z

    :param args: complete set of field values, in .msg order
    :param kwds: use keyword arguments corresponding to message field names
    to set specific fields.
    """
    if args or kwds:
      super(mv_msgsRequest, self).__init__(*args, **kwds)
      # message fields cannot be None, assign default values for those that are
      if self.command_index is None:
        self.command_index = 0
      if self.leg is None:
        self.leg = 0
      if self.x_motion is None:
        self.x_motion = 0.
      if self.y_motion is None:
        self.y_motion = 0.
      if self.z_motion is None:
        self.z_motion = 0.
      if self.data_num is None:
        self.data_num = 0
      if self.foot1_trace_x is None:
        self.foot1_trace_x = []
      if self.foot1_trace_y is None:
        self.foot1_trace_y = []
      if self.foot1_trace_z is None:
        self.foot1_trace_z = []
      if self.foot2_trace_x is None:
        self.foot2_trace_x = []
      if self.foot2_trace_y is None:
        self.foot2_trace_y = []
      if self.foot2_trace_z is None:
        self.foot2_trace_z = []
      if self.foot3_trace_x is None:
        self.foot3_trace_x = []
      if self.foot3_trace_y is None:
        self.foot3_trace_y = []
      if self.foot3_trace_z is None:
        self.foot3_trace_z = []
      if self.foot4_trace_x is None:
        self.foot4_trace_x = []
      if self.foot4_trace_y is None:
        self.foot4_trace_y = []
      if self.foot4_trace_z is None:
        self.foot4_trace_z = []
    else:
      self.command_index = 0
      self.leg = 0
      self.x_motion = 0.
      self.y_motion = 0.
      self.z_motion = 0.
      self.data_num = 0
      self.foot1_trace_x = []
      self.foot1_trace_y = []
      self.foot1_trace_z = []
      self.foot2_trace_x = []
      self.foot2_trace_y = []
      self.foot2_trace_z = []
      self.foot3_trace_x = []
      self.foot3_trace_y = []
      self.foot3_trace_z = []
      self.foot4_trace_x = []
      self.foot4_trace_y = []
      self.foot4_trace_z = []

  def _get_types(self):
    """
    internal API method
    """
    return self._slot_types

  def serialize(self, buff):
    """
    serialize message into buffer
    :param buff: buffer, ``StringIO``
    """
    try:
      _x = self
      buff.write(_get_struct_2i3di().pack(_x.command_index, _x.leg, _x.x_motion, _x.y_motion, _x.z_motion, _x.data_num))
      length = len(self.foot1_trace_x)
      buff.write(_struct_I.pack(length))
      pattern = '<%sd'%length
      buff.write(struct.Struct(pattern).pack(*self.foot1_trace_x))
      length = len(self.foot1_trace_y)
      buff.write(_struct_I.pack(length))
      pattern = '<%sd'%length
      buff.write(struct.Struct(pattern).pack(*self.foot1_trace_y))
      length = len(self.foot1_trace_z)
      buff.write(_struct_I.pack(length))
      pattern = '<%sd'%length
      buff.write(struct.Struct(pattern).pack(*self.foot1_trace_z))
      length = len(self.foot2_trace_x)
      buff.write(_struct_I.pack(length))
      pattern = '<%sd'%length
      buff.write(struct.Struct(pattern).pack(*self.foot2_trace_x))
      length = len(self.foot2_trace_y)
      buff.write(_struct_I.pack(length))
      pattern = '<%sd'%length
      buff.write(struct.Struct(pattern).pack(*self.foot2_trace_y))
      length = len(self.foot2_trace_z)
      buff.write(_struct_I.pack(length))
      pattern = '<%sd'%length
      buff.write(struct.Struct(pattern).pack(*self.foot2_trace_z))
      length = len(self.foot3_trace_x)
      buff.write(_struct_I.pack(length))
      pattern = '<%sd'%length
      buff.write(struct.Struct(pattern).pack(*self.foot3_trace_x))
      length = len(self.foot3_trace_y)
      buff.write(_struct_I.pack(length))
      pattern = '<%sd'%length
      buff.write(struct.Struct(pattern).pack(*self.foot3_trace_y))
      length = len(self.foot3_trace_z)
      buff.write(_struct_I.pack(length))
      pattern = '<%sd'%length
      buff.write(struct.Struct(pattern).pack(*self.foot3_trace_z))
      length = len(self.foot4_trace_x)
      buff.write(_struct_I.pack(length))
      pattern = '<%sd'%length
      buff.write(struct.Struct(pattern).pack(*self.foot4_trace_x))
      length = len(self.foot4_trace_y)
      buff.write(_struct_I.pack(length))
      pattern = '<%sd'%length
      buff.write(struct.Struct(pattern).pack(*self.foot4_trace_y))
      length = len(self.foot4_trace_z)
      buff.write(_struct_I.pack(length))
      pattern = '<%sd'%length
      buff.write(struct.Struct(pattern).pack(*self.foot4_trace_z))
    except struct.error as se: self._check_types(struct.error("%s: '%s' when writing '%s'" % (type(se), str(se), str(locals().get('_x', self)))))
    except TypeError as te: self._check_types(ValueError("%s: '%s' when writing '%s'" % (type(te), str(te), str(locals().get('_x', self)))))

  def deserialize(self, str):
    """
    unpack serialized message in str into this message instance
    :param str: byte array of serialized message, ``str``
    """
    if python3:
      codecs.lookup_error("rosmsg").msg_type = self._type
    try:
      end = 0
      _x = self
      start = end
      end += 36
      (_x.command_index, _x.leg, _x.x_motion, _x.y_motion, _x.z_motion, _x.data_num,) = _get_struct_2i3di().unpack(str[start:end])
      start = end
      end += 4
      (length,) = _struct_I.unpack(str[start:end])
      pattern = '<%sd'%length
      start = end
      s = struct.Struct(pattern)
      end += s.size
      self.foot1_trace_x = s.unpack(str[start:end])
      start = end
      end += 4
      (length,) = _struct_I.unpack(str[start:end])
      pattern = '<%sd'%length
      start = end
      s = struct.Struct(pattern)
      end += s.size
      self.foot1_trace_y = s.unpack(str[start:end])
      start = end
      end += 4
      (length,) = _struct_I.unpack(str[start:end])
      pattern = '<%sd'%length
      start = end
      s = struct.Struct(pattern)
      end += s.size
      self.foot1_trace_z = s.unpack(str[start:end])
      start = end
      end += 4
      (length,) = _struct_I.unpack(str[start:end])
      pattern = '<%sd'%length
      start = end
      s = struct.Struct(pattern)
      end += s.size
      self.foot2_trace_x = s.unpack(str[start:end])
      start = end
      end += 4
      (length,) = _struct_I.unpack(str[start:end])
      pattern = '<%sd'%length
      start = end
      s = struct.Struct(pattern)
      end += s.size
      self.foot2_trace_y = s.unpack(str[start:end])
      start = end
      end += 4
      (length,) = _struct_I.unpack(str[start:end])
      pattern = '<%sd'%length
      start = end
      s = struct.Struct(pattern)
      end += s.size
      self.foot2_trace_z = s.unpack(str[start:end])
      start = end
      end += 4
      (length,) = _struct_I.unpack(str[start:end])
      pattern = '<%sd'%length
      start = end
      s = struct.Struct(pattern)
      end += s.size
      self.foot3_trace_x = s.unpack(str[start:end])
      start = end
      end += 4
      (length,) = _struct_I.unpack(str[start:end])
      pattern = '<%sd'%length
      start = end
      s = struct.Struct(pattern)
      end += s.size
      self.foot3_trace_y = s.unpack(str[start:end])
      start = end
      end += 4
      (length,) = _struct_I.unpack(str[start:end])
      pattern = '<%sd'%length
      start = end
      s = struct.Struct(pattern)
      end += s.size
      self.foot3_trace_z = s.unpack(str[start:end])
      start = end
      end += 4
      (length,) = _struct_I.unpack(str[start:end])
      pattern = '<%sd'%length
      start = end
      s = struct.Struct(pattern)
      end += s.size
      self.foot4_trace_x = s.unpack(str[start:end])
      start = end
      end += 4
      (length,) = _struct_I.unpack(str[start:end])
      pattern = '<%sd'%length
      start = end
      s = struct.Struct(pattern)
      end += s.size
      self.foot4_trace_y = s.unpack(str[start:end])
      start = end
      end += 4
      (length,) = _struct_I.unpack(str[start:end])
      pattern = '<%sd'%length
      start = end
      s = struct.Struct(pattern)
      end += s.size
      self.foot4_trace_z = s.unpack(str[start:end])
      return self
    except struct.error as e:
      raise genpy.DeserializationError(e)  # most likely buffer underfill


  def serialize_numpy(self, buff, numpy):
    """
    serialize message with numpy array types into buffer
    :param buff: buffer, ``StringIO``
    :param numpy: numpy python module
    """
    try:
      _x = self
      buff.write(_get_struct_2i3di().pack(_x.command_index, _x.leg, _x.x_motion, _x.y_motion, _x.z_motion, _x.data_num))
      length = len(self.foot1_trace_x)
      buff.write(_struct_I.pack(length))
      pattern = '<%sd'%length
      buff.write(self.foot1_trace_x.tostring())
      length = len(self.foot1_trace_y)
      buff.write(_struct_I.pack(length))
      pattern = '<%sd'%length
      buff.write(self.foot1_trace_y.tostring())
      length = len(self.foot1_trace_z)
      buff.write(_struct_I.pack(length))
      pattern = '<%sd'%length
      buff.write(self.foot1_trace_z.tostring())
      length = len(self.foot2_trace_x)
      buff.write(_struct_I.pack(length))
      pattern = '<%sd'%length
      buff.write(self.foot2_trace_x.tostring())
      length = len(self.foot2_trace_y)
      buff.write(_struct_I.pack(length))
      pattern = '<%sd'%length
      buff.write(self.foot2_trace_y.tostring())
      length = len(self.foot2_trace_z)
      buff.write(_struct_I.pack(length))
      pattern = '<%sd'%length
      buff.write(self.foot2_trace_z.tostring())
      length = len(self.foot3_trace_x)
      buff.write(_struct_I.pack(length))
      pattern = '<%sd'%length
      buff.write(self.foot3_trace_x.tostring())
      length = len(self.foot3_trace_y)
      buff.write(_struct_I.pack(length))
      pattern = '<%sd'%length
      buff.write(self.foot3_trace_y.tostring())
      length = len(self.foot3_trace_z)
      buff.write(_struct_I.pack(length))
      pattern = '<%sd'%length
      buff.write(self.foot3_trace_z.tostring())
      length = len(self.foot4_trace_x)
      buff.write(_struct_I.pack(length))
      pattern = '<%sd'%length
      buff.write(self.foot4_trace_x.tostring())
      length = len(self.foot4_trace_y)
      buff.write(_struct_I.pack(length))
      pattern = '<%sd'%length
      buff.write(self.foot4_trace_y.tostring())
      length = len(self.foot4_trace_z)
      buff.write(_struct_I.pack(length))
      pattern = '<%sd'%length
      buff.write(self.foot4_trace_z.tostring())
    except struct.error as se: self._check_types(struct.error("%s: '%s' when writing '%s'" % (type(se), str(se), str(locals().get('_x', self)))))
    except TypeError as te: self._check_types(ValueError("%s: '%s' when writing '%s'" % (type(te), str(te), str(locals().get('_x', self)))))

  def deserialize_numpy(self, str, numpy):
    """
    unpack serialized message in str into this message instance using numpy for array types
    :param str: byte array of serialized message, ``str``
    :param numpy: numpy python module
    """
    if python3:
      codecs.lookup_error("rosmsg").msg_type = self._type
    try:
      end = 0
      _x = self
      start = end
      end += 36
      (_x.command_index, _x.leg, _x.x_motion, _x.y_motion, _x.z_motion, _x.data_num,) = _get_struct_2i3di().unpack(str[start:end])
      start = end
      end += 4
      (length,) = _struct_I.unpack(str[start:end])
      pattern = '<%sd'%length
      start = end
      s = struct.Struct(pattern)
      end += s.size
      self.foot1_trace_x = numpy.frombuffer(str[start:end], dtype=numpy.float64, count=length)
      start = end
      end += 4
      (length,) = _struct_I.unpack(str[start:end])
      pattern = '<%sd'%length
      start = end
      s = struct.Struct(pattern)
      end += s.size
      self.foot1_trace_y = numpy.frombuffer(str[start:end], dtype=numpy.float64, count=length)
      start = end
      end += 4
      (length,) = _struct_I.unpack(str[start:end])
      pattern = '<%sd'%length
      start = end
      s = struct.Struct(pattern)
      end += s.size
      self.foot1_trace_z = numpy.frombuffer(str[start:end], dtype=numpy.float64, count=length)
      start = end
      end += 4
      (length,) = _struct_I.unpack(str[start:end])
      pattern = '<%sd'%length
      start = end
      s = struct.Struct(pattern)
      end += s.size
      self.foot2_trace_x = numpy.frombuffer(str[start:end], dtype=numpy.float64, count=length)
      start = end
      end += 4
      (length,) = _struct_I.unpack(str[start:end])
      pattern = '<%sd'%length
      start = end
      s = struct.Struct(pattern)
      end += s.size
      self.foot2_trace_y = numpy.frombuffer(str[start:end], dtype=numpy.float64, count=length)
      start = end
      end += 4
      (length,) = _struct_I.unpack(str[start:end])
      pattern = '<%sd'%length
      start = end
      s = struct.Struct(pattern)
      end += s.size
      self.foot2_trace_z = numpy.frombuffer(str[start:end], dtype=numpy.float64, count=length)
      start = end
      end += 4
      (length,) = _struct_I.unpack(str[start:end])
      pattern = '<%sd'%length
      start = end
      s = struct.Struct(pattern)
      end += s.size
      self.foot3_trace_x = numpy.frombuffer(str[start:end], dtype=numpy.float64, count=length)
      start = end
      end += 4
      (length,) = _struct_I.unpack(str[start:end])
      pattern = '<%sd'%length
      start = end
      s = struct.Struct(pattern)
      end += s.size
      self.foot3_trace_y = numpy.frombuffer(str[start:end], dtype=numpy.float64, count=length)
      start = end
      end += 4
      (length,) = _struct_I.unpack(str[start:end])
      pattern = '<%sd'%length
      start = end
      s = struct.Struct(pattern)
      end += s.size
      self.foot3_trace_z = numpy.frombuffer(str[start:end], dtype=numpy.float64, count=length)
      start = end
      end += 4
      (length,) = _struct_I.unpack(str[start:end])
      pattern = '<%sd'%length
      start = end
      s = struct.Struct(pattern)
      end += s.size
      self.foot4_trace_x = numpy.frombuffer(str[start:end], dtype=numpy.float64, count=length)
      start = end
      end += 4
      (length,) = _struct_I.unpack(str[start:end])
      pattern = '<%sd'%length
      start = end
      s = struct.Struct(pattern)
      end += s.size
      self.foot4_trace_y = numpy.frombuffer(str[start:end], dtype=numpy.float64, count=length)
      start = end
      end += 4
      (length,) = _struct_I.unpack(str[start:end])
      pattern = '<%sd'%length
      start = end
      s = struct.Struct(pattern)
      end += s.size
      self.foot4_trace_z = numpy.frombuffer(str[start:end], dtype=numpy.float64, count=length)
      return self
    except struct.error as e:
      raise genpy.DeserializationError(e)  # most likely buffer underfill

_struct_I = genpy.struct_I
def _get_struct_I():
    global _struct_I
    return _struct_I
_struct_2i3di = None
def _get_struct_2i3di():
    global _struct_2i3di
    if _struct_2i3di is None:
        _struct_2i3di = struct.Struct("<2i3di")
    return _struct_2i3di
# This Python file uses the following encoding: utf-8
"""autogenerated by genpy from msgs_packages/mv_msgsResponse.msg. Do not edit."""
import codecs
import sys
python3 = True if sys.hexversion > 0x03000000 else False
import genpy
import struct


class mv_msgsResponse(genpy.Message):
  _md5sum = "6016345cd57c8634afed560eaaf81c72"
  _type = "msgs_packages/mv_msgsResponse"
  _has_header = False  # flag to mark the presence of a Header object
  _full_text = """# 服务器响应发送的数据
bool isFinish

"""
  __slots__ = ['isFinish']
  _slot_types = ['bool']

  def __init__(self, *args, **kwds):
    """
    Constructor. Any message fields that are implicitly/explicitly
    set to None will be assigned a default value. The recommend
    use is keyword arguments as this is more robust to future message
    changes.  You cannot mix in-order arguments and keyword arguments.

    The available fields are:
       isFinish

    :param args: complete set of field values, in .msg order
    :param kwds: use keyword arguments corresponding to message field names
    to set specific fields.
    """
    if args or kwds:
      super(mv_msgsResponse, self).__init__(*args, **kwds)
      # message fields cannot be None, assign default values for those that are
      if self.isFinish is None:
        self.isFinish = False
    else:
      self.isFinish = False

  def _get_types(self):
    """
    internal API method
    """
    return self._slot_types

  def serialize(self, buff):
    """
    serialize message into buffer
    :param buff: buffer, ``StringIO``
    """
    try:
      _x = self.isFinish
      buff.write(_get_struct_B().pack(_x))
    except struct.error as se: self._check_types(struct.error("%s: '%s' when writing '%s'" % (type(se), str(se), str(locals().get('_x', self)))))
    except TypeError as te: self._check_types(ValueError("%s: '%s' when writing '%s'" % (type(te), str(te), str(locals().get('_x', self)))))

  def deserialize(self, str):
    """
    unpack serialized message in str into this message instance
    :param str: byte array of serialized message, ``str``
    """
    if python3:
      codecs.lookup_error("rosmsg").msg_type = self._type
    try:
      end = 0
      start = end
      end += 1
      (self.isFinish,) = _get_struct_B().unpack(str[start:end])
      self.isFinish = bool(self.isFinish)
      return self
    except struct.error as e:
      raise genpy.DeserializationError(e)  # most likely buffer underfill


  def serialize_numpy(self, buff, numpy):
    """
    serialize message with numpy array types into buffer
    :param buff: buffer, ``StringIO``
    :param numpy: numpy python module
    """
    try:
      _x = self.isFinish
      buff.write(_get_struct_B().pack(_x))
    except struct.error as se: self._check_types(struct.error("%s: '%s' when writing '%s'" % (type(se), str(se), str(locals().get('_x', self)))))
    except TypeError as te: self._check_types(ValueError("%s: '%s' when writing '%s'" % (type(te), str(te), str(locals().get('_x', self)))))

  def deserialize_numpy(self, str, numpy):
    """
    unpack serialized message in str into this message instance using numpy for array types
    :param str: byte array of serialized message, ``str``
    :param numpy: numpy python module
    """
    if python3:
      codecs.lookup_error("rosmsg").msg_type = self._type
    try:
      end = 0
      start = end
      end += 1
      (self.isFinish,) = _get_struct_B().unpack(str[start:end])
      self.isFinish = bool(self.isFinish)
      return self
    except struct.error as e:
      raise genpy.DeserializationError(e)  # most likely buffer underfill

_struct_I = genpy.struct_I
def _get_struct_I():
    global _struct_I
    return _struct_I
_struct_B = None
def _get_struct_B():
    global _struct_B
    if _struct_B is None:
        _struct_B = struct.Struct("<B")
    return _struct_B
class mv_msgs(object):
  _type          = 'msgs_packages/mv_msgs'
  _md5sum = '618d2543874df9eb2cdf1d712a157e36'
  _request_class  = mv_msgsRequest
  _response_class = mv_msgsResponse
