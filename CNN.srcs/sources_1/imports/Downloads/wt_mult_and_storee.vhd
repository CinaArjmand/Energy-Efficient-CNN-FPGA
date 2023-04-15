----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/07/2022 03:17:16 PM
-- Design Name: 
-- Module Name: wt_mult_and_store - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

---TODO__:::: ADD "VALID OUTPUT" SIGNAL OR SMTHNG TO INDICATE FINISHED SUM

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity wt_mult_and_store is
 port (  clk        : in std_logic;
         rst        : in std_logic;
         data1_in     : in  std_logic;
         data2_in   : in  std_logic;
         data3_in   : in  std_logic;
         data4_in    : in  std_logic;
         sum_out1   : out signed(3 downto 0);
         sum_out2   : out signed(3 downto 0);      
         sum_out3   : out signed(3 downto 0);      
         sum_out4   : out signed(3 downto 0);
         valid_out  : out std_logic
       );
end wt_mult_and_store;

architecture Behavioral of wt_mult_and_store is

--weight matrix is stored as 16 * 4 bit registers
    signal weights_reg : std_logic_vector(63 downto 0):= "1101" & "1111" & "0001" & "1111" & "0010" & "1110" & "0000" & "0000" & "0000" & "0011" & "0000" & "1101" & "1111" & "1110" & "1110" & "0100";
    signal next_weights_reg : std_logic_vector(63 downto 0);
    signal selected_wt : signed(3 downto 0);
    signal reg1, reg2, reg3, reg4, temp_reg1, temp_reg2, temp_reg3, temp_reg4 : signed(63 downto 0);
    signal next_counter, counter_PE : unsigned(3 downto 0);
    signal nxt_cnt_out, cnt_out : unsigned (63 downto 0);

begin


process(clk, rst)
begin

if (rst = '1') then
    reg1 <= (others => '0');
    reg2 <= (others => '0');
    reg3 <= (others => '0');
    reg4 <= (others => '0'); 
--    temp_reg1 <= (others => '0');
--    temp_reg2 <= (others => '0');
--    temp_reg3 <= (others => '0');
--    temp_reg4 <= (others => '0'); 
    weights_reg <= "1101" & "1111" & "0001" & "1111" & "0010" & "1110" & "0000" & "0000" & "0000" & "0011" & "0000" & "1101" & "1111" & "1110" & "1110" & "0100";
    --next_weights_reg <= (others => '0'); 
    --selected_wt <= (others => '0'); 
    counter_PE <= (others => '0');
  --  nxt_cnt_out <= (others => '0');
    cnt_out <= (others => '0');
elsif rising_edge(clk) then
    reg1 <= temp_reg1;
    reg2 <= temp_reg2;
    reg3 <= temp_reg3;
    reg4 <= temp_reg4;
    counter_PE <= next_counter;
    weights_reg <= next_weights_reg;
    cnt_out <= nxt_cnt_out;

end if;
end process;

counter: process (counter_PE)
begin
if (counter_PE = "1111") then
    next_counter <= "0000";
    next_weights_reg <= "1101" & "1111" & "0001" & "1111" & "0010" & "1110" & "0000" & "0000" & "0000" & "0011" & "0000" & "1101" & "1111" & "1110" & "1110" & "0100";
else
    next_counter <= counter_PE + 1;
    next_weights_reg <=  weights_reg (59 downto 0)& "0000";

end if;
end process;


    selected_wt <= signed(weights_reg(63 downto 60));
    
    valid_out <= '1' when (counter_PE = "0000" and rst = '0') else '0';
    
    process(counter_PE)
    begin
    nxt_cnt_out <= cnt_out;
    if (counter_PE = "0000") then
        nxt_cnt_out <= cnt_out +1;
    end if;
    end process;

wt_select: process (counter_PE, reg1, reg2, reg3, reg4)
begin

    sum_out1 <= reg1(63 downto 60) + reg1(59 downto 56) + reg1(55 downto 52)
              + reg1(51 downto 48) + reg1(47 downto 44) + reg1(43 downto 40) 
              + reg1(39 downto 36) + reg1(35 downto 32) + reg1(31 downto 28)
              + reg1(27 downto 24) + reg1(23 downto 20) + reg1(19 downto 16)
              + reg1(15 downto 12) + reg1(11 downto 8) + reg1(7 downto 4)
              + reg1(3 downto 0);
              
    sum_out2 <= reg2(63 downto 60) + reg2(59 downto 56) + reg2(55 downto 52)
                + reg2(51 downto 48) + reg2(47 downto 44) + reg2(43 downto 40) 
                + reg2(39 downto 36) + reg2(35 downto 32) + reg2(31 downto 28)
                + reg2(27 downto 24) + reg2(23 downto 20) + reg2(19 downto 16)
                + reg2(15 downto 12) + reg2(11 downto 8) + reg2(7 downto 4)
                + reg2(3 downto 0);
                
    sum_out3 <= reg3(63 downto 60) + reg3(59 downto 56) + reg3(55 downto 52)
              + reg3(51 downto 48) + reg3(47 downto 44) + reg3(43 downto 40) 
              + reg3(39 downto 36) + reg3(35 downto 32) + reg3(31 downto 28)
              + reg3(27 downto 24) + reg3(23 downto 20) + reg3(19 downto 16)
              + reg3(15 downto 12) + reg3(11 downto 8) + reg3(7 downto 4)
              + reg3(3 downto 0);
              
    sum_out4 <= reg4(63 downto 60) + reg4(59 downto 56) + reg4(55 downto 52)
                + reg4(51 downto 48) + reg4(47 downto 44) + reg4(43 downto 40) 
                + reg4(39 downto 36) + reg4(35 downto 32) + reg4(31 downto 28)
                + reg4(27 downto 24) + reg4(23 downto 20) + reg4(19 downto 16)
                + reg4(15 downto 12) + reg4(11 downto 8) + reg4(7 downto 4)
                + reg4(3 downto 0);
 
--    selected_wt <= signed(weights_reg(63 downto 60));
--    next_weights_reg <= "0000" & weights_reg(59 downto 0);

end process;



wt_mult: process (selected_wt, data1_in, data2_in, data3_in, data4_in, reg1, Reg2, reg3, reg4)
begin
    if (data1_in = '1') then
        temp_reg1 <= reg1(59 downto 0) & selected_wt;
--        temp_reg1 <= reg1;
    else
        temp_reg1 <= reg1(59 downto 0) & "0000";
--        temp_reg1 <= reg1;
    end if;
    
    if (data2_in = '1') then
        temp_reg2 <= reg2(59 downto 0) & selected_wt;
    else
        temp_reg2 <= reg2(59 downto 0) & "0000";
    end if;
    
    if (data3_in = '1') then
        temp_reg3 <= reg3(59 downto 0) & selected_wt;
    else  
        temp_reg3 <= reg3(59 downto 0) & "0000";
    end if;
    
    if (data4_in = '1') then
        temp_reg4 <= reg4(59 downto 0) & selected_wt;
    else
        temp_reg4 <= reg4(59 downto 0) & "0000";
    end if;
    
end process;


end Behavioral;
