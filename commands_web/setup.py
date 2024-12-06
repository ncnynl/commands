from setuptools import setup, Extension
from Cython.Build import cythonize
import os

# Ensure ROS2 workspace is sourced (if ROS2 is not set up, it will raise error)
ros2_ws = "/opt/ros/humble"  # Change to your ROS2 installation path
if not os.path.isdir(ros2_ws):
    raise RuntimeError("ROS2 workspace not found")

# Set up Cython extension
ext_modules = [
    Extension(
        name="controlx",
        sources=["controlx.pyx"],
        libraries=["rclcpp"],  # Only include the necessary C++ libraries
        include_dirs=[
            os.path.join(ros2_ws, "include"),  # Include ROS2 headers
            os.path.join(ros2_ws, "include/geometry_msgs"),  # Include geometry_msgs headers
            os.path.join(ros2_ws, "include/nav2_msgs"),  # Include nav2_msgs headers
            os.path.join(ros2_ws, "include/action_msgs")  # Include action_msgs headers
        ],
        library_dirs=[os.path.join(ros2_ws, "lib")],  # Link against ROS2 libraries (e.g., rclcpp)
        language="c++",
        extra_compile_args=["-std=c++17"]
    )
]

setup(
    name="controlx",
    ext_modules=cythonize(ext_modules),
)
