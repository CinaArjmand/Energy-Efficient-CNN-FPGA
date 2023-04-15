----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/12/2022 11:31:47 AM
-- Design Name: 
-- Module Name: tb_conv_and_maxpool_top - Behavioral
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

entity tb_conv_and_maxpool_top is
--  Port ( );
end tb_conv_and_maxpool_top;

architecture Behavioral of tb_conv_and_maxpool_top is

component conv_and_maxpool_top is
Port ( 
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        output : out STD_LOGIC
);
end component;


signal clk : STD_LOGIC := '0';
signal rst : STD_LOGIC ;
signal output: STD_LOGIC;
signal count: unsigned(63 downto 0):= (others => '0');


begin

 DUT: conv_and_maxpool_top
    port map (
    clk => clk,
    rst => rst,
    output => output
    );

 clk <= not(clk) after 10ns;
 rst <= '1', '0' after 20ns;
 
 count <= count+1 after 20 ns;



end Behavioral;
