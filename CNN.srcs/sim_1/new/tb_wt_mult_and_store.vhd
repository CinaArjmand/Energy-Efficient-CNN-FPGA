----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/10/2022 09:07:58 AM
-- Design Name: 
-- Module Name: tb_wt_mult_and_store - Behavioral
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity tb_wt_mult_and_store is
--  Port ( );
end tb_wt_mult_and_store;

architecture structural of tb_wt_mult_and_store is

    component wt_mult_and_store
    port (  data1_in    : in  std_logic;
            data2_in    : in  std_logic;
            data3_in    : in  std_logic;
            data4_in    : in  std_logic;
            counter_PE  : in unsigned(3 downto 0)
          );
    end component;


      signal data1_in    : std_logic;
      signal data2_in    : std_logic;
      signal data3_in    : std_logic;
      signal data4_in    : std_logic;
      signal counter_PE  : unsigned(3 downto 0);
      
      constant period   : time := 2500 ns;

begin

    DUT: wt_mult_and_store
    port map (  data1_in => data1_in,
                data2_in => data2_in,
                data3_in => data3_in,
                data4_in => data4_in,
                counter_PE => counter_PE
              );
              
              
    data1_in <=    '0',                    
                   '0' after 1 * period,   
                   '0' after 2 * period,   
                   '0' after 3 * period,   
                   '0' after 4 * period,   
                   '0' after 5 * period,   
                   '0' after 6 * period,   
                   '0' after 7 * period,   
                   '0' after 8 * period,   
                   '0' after 9 * period,   
                   '0' after 10 * period,
                   '0' after 11 * period,
                   '0' after 12 * period,
                   '0' after 13 * period,
                   '0' after 14 * period,
                   '0' after 15 * period,
                   '0' after 16 * period;   
    
    data2_in <=   '1',                    
                  '1' after 1 * period,   
                  '1' after 2 * period,   
                  '1' after 3 * period,   
                  '1' after 4 * period,   
                  '1' after 5 * period,   
                  '1' after 6 * period,   
                  '1' after 7 * period,   
                  '1' after 8 * period,   
                  '0' after 9 * period,   
                  '0' after 10 * period,
                  '0' after 11 * period,
                  '0' after 12 * period,
                  '0' after 13 * period,
                  '0' after 14 * period,
                  '0' after 15 * period,
                  '0' after 16 * period;   
                  
                  
   data3_in <=   '0',                    
                 '0' after 1 * period,   
                 '0' after 2 * period,   
                 '0' after 3 * period,   
                 '0' after 4 * period,   
                 '0' after 5 * period,   
                 '0' after 6 * period,   
                 '0' after 7 * period,   
                 '0' after 8 * period,   
                 '1' after 9 * period,   
                 '1' after 10 * period,
                 '1' after 11 * period,
                 '1' after 12 * period,
                 '1' after 13 * period,
                 '1' after 14 * period,
                 '1' after 15 * period,
                 '1' after 16 * period; 
                 
                   
  data4_in <=   '1',                    
                '1' after 1 * period,   
                '1' after 2 * period,   
                '1' after 3 * period,   
                '1' after 4 * period,   
                '1' after 5 * period,   
                '1' after 6 * period,   
                '1' after 7 * period,   
                '1' after 8 * period,   
                '1' after 9 * period,   
                '1' after 10 * period,
                '1' after 11 * period,
                '1' after 12 * period,
                '1' after 13 * period,
                '1' after 14 * period,
                '1' after 15 * period,
                '1' after 16 * period;   
                
                
    counter_PE <=  "0000",                    
                   "0001" after 1 * period,   
                   "0010" after 2 * period,   
                   "0011" after 3 * period,   
                   "0100" after 4 * period,   
                   "0101" after 5 * period,   
                   "0110" after 6 * period,   
                   "0111" after 7 * period,   
                   "1000" after 8 * period,   
                   "1001" after 9 * period,   
                   "1010" after 10 * period,
                   "1011" after 11 * period,
                   "1100" after 12 * period,
                   "1101" after 13 * period,
                   "1110" after 14 * period,
                   "1111" after 15 * period,
                   "0000" after 16 * period;   
                
                                                 

end structural;
