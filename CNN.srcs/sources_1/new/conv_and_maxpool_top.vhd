----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/12/2022 11:02:51 AM
-- Design Name: 
-- Module Name: conv_and_maxpool_top - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity conv_and_maxpool_top is
Port ( 
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;        
        output: out STD_LOGIC
);
end conv_and_maxpool_top;








architecture structural of conv_and_maxpool_top is

component convolution_top is
Port ( 
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        sum_out1   : out signed(4 downto 0);
        sum_out2   : out signed(4 downto 0);      
        sum_out3   : out signed(4 downto 0);  
        valid_out  : out std_logic;    
        sum_out4   : out signed(4 downto 0)

);
end component;



component maxpool is
  port ( 
         rst     : in std_logic;
         clk     : in std_logic;   
         sum1_in : in signed(4 downto 0);
         sum2_in : in signed(4 downto 0);
         sum3_in : in signed(4 downto 0);
         sum4_in : in signed(4 downto 0);
         valid_in: in std_logic;
         valid_out: out std_logic;
         max1_out: out signed(63 downto 0)
  );
end component;

component fc1 is 
Port (   clk : in std_logic;
           rst : in std_logic;
           max_in : in signed(63 downto 0);
           valid_in : in std_logic;
           valid_out : out std_logic;
           fc_out : out std_logic
  );
end component;


signal sum1, sum2, sum3, sum4, max1_out: signed(4 downto 0);
signal valid: std_logic;
signal valid_fc, vo_fc: std_logic;
signal maxp : signed (63 downto 0);

begin

convolution_top1: convolution_top
port map (
            clk => clk,
            rst => rst,
            sum_out1   => sum1,
            sum_out2   => sum2,     
            sum_out3   => sum3,     
            sum_out4   => sum4,
            valid_out => valid
 );
 
 
maxpool1: maxpool
  port map( 
         clk => clk,
         rst => rst,   
         sum1_in => sum1,
         sum2_in => sum2,
         sum3_in => sum3,
         sum4_in => sum4,
         valid_in => valid,
         valid_out => valid_fc,
         max1_out => maxp
  );
 
 fc: fc1
 port map(  
            clk => clk,
            rst => rst,
            max_in =>  maxp, 
            valid_in => valid_fc,
            valid_out => vo_fc,
            fc_out => output
   );




end structural;
