----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/07/2022 03:15:40 PM
-- Design Name: 
-- Module Name: CONVOLUTION - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity convolution_top is
Port ( 
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        sum_out1   : out signed(4 downto 0);
        sum_out2   : out signed(4 downto 0);      
        sum_out3   : out signed(4 downto 0);      
        sum_out4   : out signed(4 downto 0);
        valid_out  : out std_logic
);
end convolution_top;

architecture Behavioral of convolution_top is




component wt_mult_and_store is
 port (  data1_in     : in  std_logic;
         data2_in   : in  std_logic;
         data3_in   : in  std_logic;
         data4_in    : in  std_logic;
         clk        : in std_logic;
         rst        : in std_logic;
         sum_out1   : out signed(4 downto 0);
         sum_out2   : out signed(4 downto 0);      
         sum_out3   : out signed(4 downto 0);      
         sum_out4   : out signed(4 downto 0);
         valid_out  : out std_logic
       );
end component;

component shifter is
    Port (
    clk : in STD_LOGIC;
    rst : in STD_LOGIC;
    data_1out : out STD_LOGIC;
    data_2out : out STD_LOGIC;
    data_3out : out STD_LOGIC;
    data_4out : out STD_LOGIC
    
    );
--  Port ( );
end component;

signal data_1,data_2,data_3,data_4 : std_logic;



begin

wtmult1: wt_mult_and_store
 port map (  
         clk => clk,
         rst => rst,
         data1_in  => data_1,
         data2_in   => data_2,
         data3_in   => data_3,
         data4_in   => data_4,
         sum_out1  =>  sum_out1,
         sum_out2  =>  sum_out2,    
         sum_out3  =>  sum_out3,     
         sum_out4  =>  sum_out4,
         valid_out => valid_out
       );
       
       
 shifter1: shifter
           Port map (
           clk => clk,
           rst => rst,
           data_1out => data_1,
           data_2out => data_2,
           data_3out => data_3,
           data_4out => data_4
           
           );
     

end Behavioral;
