#################################################################################
# Filename: ddrc_test01_timing.xdc
# Date:2014-05-20  
# Author: Andrey Filippov
# Description: DDR3 controller test with axi constraints
#
# Copyright (c) 2014 Elphel, Inc.
# ddrc_test01_timing.xdc is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
#  ddrc_test01_timing.xdc is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/> .
#################################################################################
#create_clock -period 2.500 -name clk -waveform {0.000 1.250} [get_ports CLK]
#axi_aclk  [get_pins -hierarchical *pll*CLKIN1]
create_clock -name axi_aclk -period 10 [get_nets -hierarchical *axi_aclk]


#Clock        Period    Waveform           Attributes  Sources
#axi_aclk     10.00000  {0.00000 5.00000}  P           {bufg_axi_aclk_i/O}
#clk_fb       10.00000  {0.00000 5.00000}  P,G         {ddrc_sequencer_i/phy_cmd_i/phy_top_i/mmcm_phase_cntr_i/MMCME2_ADV_i/CLKFBOUT}
#sdclk_pre    2.50000   {0.00000 1.25000}  P,G         {ddrc_sequencer_i/phy_cmd_i/phy_top_i/mmcm_phase_cntr_i/MMCME2_ADV_i/CLKOUT0}
#clk_pre      2.50000   {0.00000 1.25000}  P,G         {ddrc_sequencer_i/phy_cmd_i/phy_top_i/mmcm_phase_cntr_i/MMCME2_ADV_i/CLKOUT1}
#clk_div_pre  5.00000   {0.00000 2.50000}  P,G         {ddrc_sequencer_i/phy_cmd_i/phy_top_i/mmcm_phase_cntr_i/MMCME2_ADV_i/CLKOUT2}
#mclk_pre     5.00000   {1.25000 3.75000}  P,G         {ddrc_sequencer_i/phy_cmd_i/phy_top_i/mmcm_phase_cntr_i/MMCME2_ADV_i/CLKOUT3}
#clkfb_ref    10.00000  {0.00000 5.00000}  P,G         {ddrc_sequencer_i/phy_cmd_i/phy_top_i/pll_base_i/PLLE2_BASE_i/CLKFBOUT}
#clk_ref_pre  3.33333   {0.00000 1.66667}  P,G         {ddrc_sequencer_i/phy_cmd_i/phy_top_i/pll_base_i/PLLE2_BASE_i/CLKOUT0}

create_generated_clock -name ddr3_sdclk [get_nets -hierarchical sdclk_pre]
create_generated_clock -name ddr3_clk [get_nets -hierarchical clk_pre]
create_generated_clock -name ddr3_clk_div [get_nets -hierarchical clk_div_pre]
create_generated_clock -name ddr3_mclk [get_nets -hierarchical mclk_pre]
create_generated_clock -name ddr3_clk_ref [get_nets -hierarchical clk_ref_pre]

# do not check timing between axi_aclk and other clocks. Code should provide correct asynchronous crossing of the clock boundary.
set_clock_groups -name ps_async_clock -asynchronous -group {axi_aclk}