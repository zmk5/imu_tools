FROM ros:foxy-ros-core

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    clang-format \
    python3-colcon-common-extensions \
    python3-rosdep

# Create ROS workspace
COPY . /ws/src/imu_tools
WORKDIR /ws

# Use rosdep to install all dependencies (including ROS itself)
RUN rosdep init && \
    rosdep update && \
    rosdep install --from-paths src -i -y --rosdistro foxy

RUN /bin/bash -c "source /opt/ros/foxy/setup.bash && \
    colcon build --parallel-workers 1 && \
    colcon test --parallel-workers 1"
