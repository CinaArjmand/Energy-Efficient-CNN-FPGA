----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/10/2022 04:32:14 PM
-- Design Name: 
-- Module Name: tb_convolution - Behavioral
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


-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_convolution is
--  Port ( );
end tb_convolution;

architecture Behavioral of tb_convolution is

component convolution_top is
Port ( 
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        sum_out1   : out signed(3 downto 0);
        sum_out2   : out signed(3 downto 0);      
        sum_out3   : out signed(3 downto 0);
        valid_out  : out std_logic;      
        sum_out4   : out signed(3 downto 0)
);
end component;

signal clk : STD_LOGIC := '0';
signal rst : STD_LOGIC ;

begin

 DUT: convolution_top
    port map (
    clk => clk,
    rst => rst
    );

clk <= not(clk) after 10ns;
 rst <= '1', '0' after 20ns;







end Behavioral;
