
set PROJECT_NAME "PS_test"


create_project $PROJECT_NAME . -part xc7z020clg400-1
create_bd_design "PS_system"

# Create Zynq 


startgroup
create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0
endgroup

# Enable UART

set_property -dict [list CONFIG.PCW_UART1_PERIPHERAL_ENABLE {1} CONFIG.PCW_UART1_UART1_IO {MIO 12 .. 13}] [get_bd_cells processing_system7_0]

# Autimate PS

startgroup
apply_bd_automation -rule xilinx.com:bd_rule:processing_system7 -config {make_external "FIXED_IO, DDR" Master "Disable" Slave "Disable" }  [get_bd_cells processing_system7_0]
endgroup
# Connect CLK
connect_bd_net [get_bd_pins processing_system7_0/FCLK_CLK0] [get_bd_pins processing_system7_0/M_AXI_GP0_ACLK]

# SD Card

startgroup
set_property -dict [list CONFIG.PCW_SD0_PERIPHERAL_ENABLE {1} CONFIG.PCW_SD0_SD0_IO {MIO 40 .. 45} CONFIG.PCW_SD0_GRP_CD_ENABLE {1} CONFIG.PCW_SD0_GRP_CD_IO {MIO 47}] [get_bd_cells processing_system7_0]
endgroup

# Ethernet

startgroup
set_property -dict [list CONFIG.PCW_PRESET_BANK1_VOLTAGE {LVCMOS 1.8V} CONFIG.PCW_ENET0_PERIPHERAL_ENABLE {1} CONFIG.PCW_ENET0_ENET0_IO {MIO 16 .. 27} CONFIG.PCW_ENET0_GRP_MDIO_ENABLE {1} CONFIG.PCW_ENET0_GRP_MDIO_IO {MIO 52 .. 53}] [get_bd_cells processing_system7_0]
endgroup

# DDR configuration

startgroup
set_property -dict [list CONFIG.PCW_UIPARAM_DDR_FREQ_MHZ {400} CONFIG.PCW_UIPARAM_DDR_BUS_WIDTH {16 Bit} CONFIG.PCW_UIPARAM_DDR_BL {8} CONFIG.PCW_UIPARAM_DDR_PARTNO {MT41K256M16 RE-125}] [get_bd_cells processing_system7_0]
endgroup

# Validate

validate_bd_design