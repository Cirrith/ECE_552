library verilog;
use verilog.vl_types.all;
entity extra_logic2 is
    port(
        halt_dec        : in     vl_logic;
        halt_exe        : in     vl_logic;
        halt_mem        : in     vl_logic;
        halt_wb         : in     vl_logic;
        pc_sel          : in     vl_logic;
        reg_write_exe   : in     vl_logic;
        reg_write_mem   : in     vl_logic;
        reg_write_wb    : in     vl_logic;
        reg_1_src_dec   : in     vl_logic_vector(2 downto 0);
        reg_1_src_exe   : in     vl_logic_vector(2 downto 0);
        reg_2_src_dec   : in     vl_logic_vector(2 downto 0);
        reg_2_src_exe   : in     vl_logic_vector(2 downto 0);
        write_reg_exe   : in     vl_logic_vector(2 downto 0);
        write_reg_mem   : in     vl_logic_vector(2 downto 0);
        write_reg_wb    : in     vl_logic_vector(2 downto 0);
        alu_result_mem  : in     vl_logic_vector(15 downto 0);
        mem_data_mem    : in     vl_logic_vector(15 downto 0);
        wb              : in     vl_logic_vector(15 downto 0);
        mem_read_exe    : in     vl_logic;
        mem_read_mem    : in     vl_logic;
        pc_code         : in     vl_logic_vector(1 downto 0);
        check_a_dec     : in     vl_logic;
        check_b_dec     : in     vl_logic;
        check_a_exe     : in     vl_logic;
        check_b_exe     : in     vl_logic;
        mem_stall       : in     vl_logic;
        fet_stall       : in     vl_logic;
        a_forward       : out    vl_logic;
        a_forward_data  : out    vl_logic_vector(15 downto 0);
        b_forward       : out    vl_logic;
        b_forward_data  : out    vl_logic_vector(15 downto 0);
        pc_det_forward  : out    vl_logic;
        pc_det_forward_data: out    vl_logic_vector(15 downto 0);
        stall_fetch     : out    vl_logic;
        stall_ifde      : out    vl_logic;
        stall_deex      : out    vl_logic;
        stall_exme      : out    vl_logic;
        stall_mewb      : out    vl_logic;
        flush_ifde      : out    vl_logic;
        flush_deex      : out    vl_logic;
        flush_exme      : out    vl_logic;
        flush_mewb      : out    vl_logic
    );
end extra_logic2;
