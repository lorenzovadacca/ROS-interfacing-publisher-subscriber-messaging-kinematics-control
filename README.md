# ROS interfacing, publisher and subscriber messaging, kinematics control (Robotics)

A comprehensive hands-on laboratory project introducing the integration between **ROS (Robot Operating System)** and **MATLAB/Simulink**, developed for the **Robotics** course at Politecnico di Torino.

---

## Table of contents
1. [Overview](#overview)
2. [Prerequisites & Requirements](#prerequisites--requirements)
3. [Architecture & Core Concepts](#architecture--core-concepts)
   - [ROS Master & Computational Graph](#1-ros-master--computational-graph)
   - [Publish-Subscribe Messaging](#2-publish-subscribe-messaging)
   - [Service-Client Mechanism](#3-service-client-mechanism)
   - [Parameter Server Interaction](#4-parameter-server-interaction)
   - [Trajectory Planning & Automated Valet](#5-trajectory-planning--automated-valet)
4. [File & Task Mapping](#file--task-mapping)
5. [Project Structure](#project-structure)
6. [Usage Guide](#usage-guide)
   - [Task 1: ROS Master & Node Initialization](#task-1-ros-master--node-initialization)
   - [Task 2: Topic Inspection & Introspection](#task-2-topic-inspection--introspection)
   - [Task 3: Publisher & Subscriber Integration](#task-3-publisher--subscriber-integration)
   - [Task 4: Message Inspection & Binary Serialization](#task-4-message-inspection--binary-serialization)
   - [Task 5: Synchronous Services (Server & Client)](#task-5-synchronous-services-server--client)
   - [Task 6: Parameter Server Configuration](#task-6-parameter-server-configuration)
   - [Path Planning: Automated Parking Valet](#path-planning-automated-parking-valet)

---

## Overview

This laboratory focuses on foundational middleware principles in robotics software architecture. Using MATLAB's **ROS Toolbox**, students instantiate and interact with a ROS computation graph directly from the MATLAB workspace:
* **Middleware Management:** Programmatic startup, registration, and shutdown of the ROS Master (`rosinit`, `rosshutdown`).
* **Asynchronous Communication:** Creation of custom publisher/subscriber nodes using standard message primitives (`std_msgs/String`, `geometry_msgs/Twist`, `sensor_msgs/LaserScan`).
* **Synchronous Communication:** Implementation of service servers and clients using standard request-response protocols (`roscpp_tutorials/TwoInts`, `std_srvs/Empty`).
* **Global Configuration:** Reading, setting, and searching variables on the centralized Parameter Server (`rosparam`).
* **Motion Planning Application:** Collision-free path planning using Hybrid $A^*$ for autonomous vehicle parking simulation.

---

## Requirements

* **MATLAB Version:** R2022b or later (recommended).
* **Required Toolboxes:**
  * **ROS Toolbox** (mandatory)
  * **Navigation Toolbox** (required for parking lot planner & Hybrid $A^*$)
  * **Automated Driving Toolbox** (optional, recommended for vehicle costmaps)
* Ensure your working directory in MATLAB is set to `/L1_ROS_MATLAB`.

---

## Architecture

### 1. ROS Master & Computational Graph
* **ROS Master (`rosinit`):** Central naming service facilitating peer-to-peer discovery between nodes.
* **Nodes:** Execution processes mapped into the graph via MATLAB handles and callbacks.
* **Introspection:** Command-line inspection commands (`rosnode list`, `rostopic list`, `rosservice list`).

### 2. Publish-Subscribe Messaging
* **Asynchronous Unidirectional Pipeline:** Decoupled data transmission over strongly typed topics.
* **Message Handling:** Data extraction utilizing the high-performance `"DataFormat", "struct"` paradigm to eliminate object overhead in memory-intensive streaming loops.
* **Callbacks:** Non-blocking function handles triggered upon arrival of sensor data (e.g., `/pose`, `/scan`, `/chatter`).

### 3. Service-Client Mechanism
* **Synchronous Two-Way Transaction:** Blocking remote procedure calls (RPC) executing defined tasks.
* **Server Verification:** Deterministic synchronization via `waitForServer(client, "Timeout", T)` prior to invocation to prevent timeout exceptions.

### 4. Parameter Server Interaction
* **Global Key-Value Storage:** Shared dictionary accessible across the graph for static/semi-static parameters (e.g., maximum speeds, hardware IP endpoints, goal coordinates).
* **Namespacing:** Hierarchical parameter segregation (`/myrobot/ROBOT_IP`, `/newrobot/ROBOT_NAME`).

### 5. Trajectory Planning & Automated Valet
* **Hybrid $A^*$ Planning:** Generates continuous-curvature, kinematically feasible trajectories respecting non-holonomic vehicle motion models and minimum turn radii.
* **Occupancy & Costmaps:** Utilizes vehicle polygon inflation (`exampleHelperVisualizePathWithVehicleModel.m`) over parking costmap matrices (`parkingLotCostVal.mat`, `garage_fl1_southend.mat`).

---

## File mapping

| Script / Asset | Task / Description | Key APIs Used |
| :--- | :--- | :--- |
| `RBTX_LAB01_T1_nodes.m` | Master init, fake network instantiation, graph introspection | `rosinit`, `rosnode list`, `rostopic list`, `rostopic info`, `rostopic echo` |
| `RBTX_LAB01_T2_topics.m` | Topic listing, message type queries, and topic streaming | `rostopic type`, `rostopic info /pose`, `rostopic echo /pose` |
| `RBTX_LAB01_T3_part1_subscriber.m` | Subscriber creation, range sensor plotting, pose callback | `rossubscriber`, `receive`, `rosPlot` |
| `RBTX_LAB01_T3_part2_publisher.m` | Publisher instantiation, string message creation & send | `rospublisher`, `rosmessage`, `send` |
| `RBTX_LAB01_T3_part3_PubAndSub.m` | Loopback communication (simultaneous publisher/subscriber) | `rospublisher`, `rossubscriber`, `send`, `pause` |
| `RBTX_LAB01_T4_Messages.m` | Message extraction, mutation, inspection, and `.mat` serialization | `rosmessage`, `rosShowDetails`, `save`, `load` |
| `RBTX_LAB01_T5_Services.m` | Service server and client creation for `std_srvs/Empty` | `rossvcserver`, `rossvcclient`, `waitForServer`, `call` |
| `RBTX_LAB01_T5_ClientAndServer.m` | Arithmetic sum service (`roscpp_tutorials/TwoInts`) | `rosmsg show`, `isServerAvailable`, `call` |
| `RBTX_LAB01_T6_ParameterServer.m` | Parameter Server read, write, check, delete, and search | `rosparam`, `set`, `get`, `has`, `del`, `search` |
| `exampleHelperVisualizePathWithVehicleModel.m` | Polygon vehicle footprint visualization along planned paths | `polyshape`, `transformtraj`, `plot` |
| `parkingLotCostVal.mat` | Costmap representation for open parking scenarios | Binary/Cost matrix |
| `garage_fl1_southend.mat` | High-fidelity parking garage map matrix | Costmap grid |

---

## Project structure

```plaintext
L1_ROS_MATLAB/
├── L1 - ROS Basics with MATLAB - part1.pdf   # Slide deck & lecture reference
├── RBTX_LAB01_T1_nodes.m                     # Node discovery & graph initialization
├── RBTX_LAB01_T2_topics.m                    # Topic inspection & message types
├── RBTX_LAB01_T3_part1_subscriber.m          # Range & pose subscriber implementation
├── RBTX_LAB01_T3_part2_publisher.m           # String chatter publisher
├── RBTX_LAB01_T3_part3_PubAndSub.m           # Combined pub-sub continuous loop
├── RBTX_LAB01_T4_Messages.m                  # Geometry Twist message manipulation
├── RBTX_LAB01_T5_Services.m                  # Empty service definition & invocation
├── RBTX_LAB01_T5_ClientAndServer.m           # TwoInts client-server sum interaction
├── RBTX_LAB01_T6_ParameterServer.m           # Rosparam parameter server management
├── exampleHelperVisualizePathWithVehicleModel.m # Hybrid A* vehicle plotting helper
├── exampleMaps.mat                           # Costmap structures for navigation
├── garage_fl1_southend.mat                   # Garage scenario occupancy grid
├── parkingLotCostVal.mat                     # Parking scenario cost matrix
└── README.md                                 # Lab documentation
```

---

## Usage

### Task 1: ROS Master & Node Initialization
Initialize the ROS master and create a dummy simulation network:
```matlab
cd('L1_ROS_MATLAB')
RBTX_LAB01_T1_nodes
```

### Task 2: Topic Inspection & Introspection
Inspect topics, their active publisher/subscriber count, and data types:
```matlab
RBTX_LAB01_T2_topics
```

### Task 3: Publisher & Subscriber Integration
1. **Subscriber Test:** Read simulated laser scans (`/scan`) and pose transformations (`/pose`):
   ```matlab
   RBTX_LAB01_T3_part1_subscriber
   ```
2. **Publisher Test:** Transmit a single test payload to the `/chatter` topic:
   ```matlab
   RBTX_LAB01_T3_part2_publisher
   ```
3. **Loopback Execution:** Run a 10-cycle transmit/receive loop with a dedicated callback:
   ```matlab
   RBTX_LAB01_T3_part3_PubAndSub
   ```

### Task 4: Message Inspection & Binary Serialization
Inspect and manipulate fields of a `geometry_msgs/Twist` struct and save incoming pose structures into `.mat` format:
```matlab
RBTX_LAB01_T4_Messages
```

### Task 5: Synchronous Services (Server & Client)
1. **Empty Trigger Service:**
   ```matlab
   RBTX_LAB01_T5_Services
   ```
2. **Arithmetic Sum Service Server & Client:**
   ```matlab
   RBTX_LAB01_T5_ClientAndServer
   ```

### Task 6: Parameter Server Configuration
Set, retrieve, and delete ROS parameters under user-defined and root namespaces:
```matlab
RBTX_LAB01_T6_ParameterServer
```

### Path Planning: Automated Parking Valet
To run the autonomous parking valet path planner referenced in the course documentation:
1. Load the parking costmap:
   ```matlab
   load('parkingLotCostVal.mat')
   ```
2. Follow the automated valet workflow in `L1 - ROS Basics with MATLAB - part1.pdf` (Slides 35–39) to configure the vehicle dimensions, set initial and goal poses, and execute `exampleHelperVisualizePathWithVehicleModel`.
