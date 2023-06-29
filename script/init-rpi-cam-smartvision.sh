#!/bin/bash
# Copyright 2022 Xilinx Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
OUTPUT=$(media-ctl -d $1 -p)
I2C_BUS=$(echo "$OUTPUT" | grep '.*- entity.*imx219' | awk -F' ' '{print $5}')
media-ctl -V "\"imx219 ${I2C_BUS}\":0 [fmt:SRGGB10_1X10/1920x1080]" -d $1
MIPI_CSI=$(echo "$OUTPUT" | grep '.*- entity.*mipi_csi2_rx_subsystem' | awk -F' ' '{print $4}')
media-ctl -V "\"${MIPI_CSI}\":0 [fmt:SRGGB10_1X10/1920x1080 field:none colorspace:srgb]" -d $1
media-ctl -V "\"${MIPI_CSI}\":1  [fmt:SRGGB10_1X10/1920x1080 field:none colorspace:srgb]" -d $1
ISP_PIPE=$(echo "$OUTPUT" | grep '.*- entity.*ISPPipeline_accel' | awk -F' ' '{print $4}')
media-ctl -V "\"${ISP_PIPE}\":0  [fmt:SRGGB10_1X10/1920x1080 field:none colorspace:srgb]" -d $1
media-ctl -V "\"${ISP_PIPE}\":1  [fmt:RBG888_1X24/1920x1080 field:none colorspace:srgb]" -d $1
V_PROC=$(echo "$OUTPUT" | grep '.*- entity.*.v_proc_ss ' | awk -F' ' '{print $4}')
media-ctl -V "\"${V_PROC}\":0  [fmt:RBG888_1X24/1920x1080 field:none colorspace:srgb]" -d $1
media-ctl -V "\"${V_PROC}\":1  [fmt:RBG888_1X24/1024x768 field:none colorspace:srgb]" -d $1
