----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/10/2022 09:58:01 AM
-- Design Name: 
-- Module Name: tb_shifter - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_shifter is
    Port(
    count1 : out unsigned(12 downto 0)
    );
--  Port ( );
end tb_shifter;

architecture Behavioral of tb_shifter is

component shifter is
    Port (
    clk : in STD_LOGIC;
    rst : in STD_LOGIC;
    data_1out : out STD_LOGIC;
    data_2out : out STD_LOGIC;
    data_3out : out STD_LOGIC;
    data_4out : out STD_LOGIC
    
    );
end component;

signal clk : STD_LOGIC := '0';
signal rst : STD_LOGIC;
--signal start_in : STD_LOGIC;
signal data_1out : STD_LOGIC;
signal data_2out : STD_LOGIC;
signal data_3out : STD_LOGIC;
signal data_4out : STD_LOGIC;
signal counter : unsigned(12 downto 0):= "0000000000000";



begin
    
    DUT: shifter
    port map (
    clk => clk,
    rst => rst,
    --start_in => clk,
    data_1out => data_1out,
    data_2out => data_2out,
    data_3out => data_3out,
    data_4out => data_4out
    
    );



    clk <= not(clk) after 10ns;
    rst <= '1', '0' after 20ns;
    counter <= counter + 1 after 20ns;
    count1 <= counter;
    

end Behavioral;
