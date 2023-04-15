----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/26/2022 04:08:51 PM
-- Design Name: 
-- Module Name: fc1 - Behavioral
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

entity fc1 is
  Port (   clk : in std_logic;
           rst : in std_logic;
           max_in : in signed(63 downto 0);
           valid_in : in std_logic;
           valid_out : out std_logic;
           fc_out : out std_logic
  );
end fc1;

architecture Behavioral of fc1 is
    signal wt1 : signed(63 downto 0);--:= "0010" & "0010" & "0010" & "0101" & "0011" & "0100" & "0110" & "0101" & "0011" & "0101" & "0011" & "0011" & "0011" & "0100" & "0010" & "0010";
    signal next_wt1 : signed(63 downto 0); 
    signal wt2 : signed(63 downto 0):= "0010" & "1110" & "0010" & "1010" & "1011" & "0001" & "1010" & "1101" & "0000" & "1010" & "1001" & "1011" & "0000" & "1010" & "1010" & "0011";
    signal next_wt2 : signed(63 downto 0);
    signal wt3 : signed(63 downto 0):= "0000" & "0011" & "1001" & "1011" & "0011" & "1100" & "0001" & "1100" & "0000" & "1010" & "1110" & "1011" & "0000" & "1010" & "0001" & "1011";
    signal next_wt3 : signed(63 downto 0);
    signal current_max, next_max : signed(63 downto 0);
    signal count16, next_count16 : unsigned(3 downto 0);
    signal fc_out1, fc_out2, fc_out3 : signed(7 downto 0);
    signal fc1r, fc2r, fc3r : signed (11 downto 0);
    signal fc_reg1, fc_reg2, fc_reg3, next_fc_reg1, next_fc_reg2, next_fc_reg3 : signed(127 downto 0);
    signal sel_wt1, sel_wt2, sel_wt3, sel_max : signed(3 downto 0);
    signal fco : signed(11 downto 0);

    

begin

    valid_out <= '1' when (count16 = "0000") else '0'; -- when equals 0 or when equals 15?


clock: process(clk,rst)
begin

if rising_edge(clk) then
    if(rst = '1') then
        current_max <= (others => '0');
        count16 <= (others => '0');
        wt1 <= "0010001000100101001101000110010100110101001100110011010000100010";
        wt2 <= "0010" & "1010" & "0010" & "1110" & "1101" & "0001" & "1110" & "1011" & "0000" & "1110" & "1111" & "1101" & "0000" & "1110" & "1110" & "0011";
        wt3 <=  "0000" & "0011" & "1111" & "1101" & "0011" & "1000" & "0001" & "1100" & "0000" & "1110" & "1010" & "1101" & "0000" & "1110" & "0001" & "1101";
        fc_reg1 <= (others => '0');
        fc_reg2 <= (others => '0');
        fc_reg3 <= (others => '0');

    else
        current_max <= next_max;
        count16 <= next_count16;   
        wt1 <= next_wt1;
        wt2 <= next_wt2;
        wt3 <= next_wt3;
        fc_reg1 <= next_fc_reg1;
        fc_reg2 <= next_fc_reg2;
        fc_reg3 <= next_fc_reg3;
    end if;
end if;
end process;

count: process(count16, valid_in) 
begin
 --  next_count16 <= count16;

if (valid_in = '1') then

    if (count16 = "1111") then
        next_count16 <= "0000";
    else
        next_count16 <= count16 + 1;
    end if;
else
   next_count16 <= count16;
end if;
end process;

sel_wt1 <= wt1(63 downto 60);
sel_wt2 <= wt2(63 downto 60);
sel_wt3 <= wt3(63 downto 60);

selmax: process (max_in, count16)
begin
case count16 is
    when "0000" =>
        sel_max <= max_in(63 downto 60);
    when "0001" =>
        sel_max <= max_in(59 downto 56);
    when "0010" =>
        sel_max <= max_in(55 downto 52);
    when "0011" =>
        sel_max <= max_in(51 downto 48);
    when "0100" =>
        sel_max <= max_in(47 downto 44);
    when "0101" =>
        sel_max <= max_in(43 downto 40);
    when "0110" =>
        sel_max <= max_in(39 downto 36);
    when "0111" =>
        sel_max <= max_in(35 downto 32);
    when "1000" =>
        sel_max <= max_in(31 downto 28);
    when "1001" =>
        sel_max <= max_in(27 downto 24);
    when "1010" =>
        sel_max <= max_in(23 downto 20);
    when "1011" =>
        sel_max <= max_in(19 downto 16);
    when "1100" =>
        sel_max <= max_in(15 downto 12);
    when "1101" =>
        sel_max <= max_in(11 downto 8);
    when "1110" =>
        sel_max <= max_in(7 downto 4); 
    when "1111" =>
        sel_max <= max_in(3 downto 0);
    when others =>
end case;
end process;

--sel_max <= max_in(63 downto 60);

mult: process(wt1, wt2, wt3, max_in, valid_in, count16, fc_reg1, fc_reg2, fc_reg3)
begin
next_wt1 <= wt1;
next_wt2 <= wt2;
next_wt3 <= wt3;
   
next_fc_reg1 <= fc_reg1;
next_fc_reg2 <= fc_reg2;
next_fc_reg3 <= fc_reg3;

if (valid_in = '1') then
    current_max <= max_in;


if (count16 = "1111") then
    
else
    next_wt1 <= wt1(59 downto 0) & "0000";
    next_wt2 <= wt2(59 downto 0) & "0000";
    next_wt3 <= wt3(59 downto 0) & "0000";
    
    
    next_fc_reg1 <= (sel_wt1 * sel_max) & fc_reg1(127 downto 8);
    next_fc_reg2 <= (sel_wt2 * sel_max) & fc_reg2(127 downto 8);
    next_fc_reg3 <= (sel_wt3 * sel_max) & fc_reg3(127 downto 8);
end if;
end if;
end process;

wt_select: process (fc_reg1, fc_reg2, fc_reg3)
begin

     fc_out1 <= (fc_reg1(127 downto 120)) + ( fc_reg1(119 downto 112)) + (fc_reg1(111 downto 104))
              + (fc_reg1(103 downto 96)) + (fc_reg1(95 downto 88)) + (fc_reg1(87 downto 80)) 
              + (fc_reg1(79 downto 72)) + (fc_reg1(71 downto 64)) + (fc_reg1(63 downto 56))
              + (fc_reg1(55 downto 48)) + (fc_reg1(47 downto 40)) + (fc_reg1(39 downto 32))
              + (fc_reg1(31 downto 24)) + (fc_reg1(23 downto 16)) + (fc_reg1(15 downto 8))
              + (fc_reg1(7 downto 0)) - 12;  
              
     fc_out2 <= (fc_reg2(127 downto 120)) + ( fc_reg2(119 downto 112)) + (fc_reg2(111 downto 104))
              + (fc_reg2(103 downto 96)) + (fc_reg2(95 downto 88)) + (fc_reg2(87 downto 80)) 
              + (fc_reg2(79 downto 72)) + (fc_reg2(71 downto 64)) + (fc_reg2(63 downto 56))
              + (fc_reg2(55 downto 48)) + (fc_reg2(47 downto 40)) + (fc_reg2(39 downto 32))
              + (fc_reg2(31 downto 24)) + (fc_reg2(23 downto 16)) + (fc_reg2(15 downto 8))
              + (fc_reg2(7 downto 0)) + 20;
              
     fc_out3 <= (fc_reg3(127 downto 120)) + ( fc_reg3(119 downto 112)) + (fc_reg3(111 downto 104))
                        + (fc_reg3(103 downto 96)) + (fc_reg3(95 downto 88)) + (fc_reg3(87 downto 80)) 
                        + (fc_reg3(79 downto 72)) + (fc_reg3(71 downto 64)) + (fc_reg3(63 downto 56))
                        + (fc_reg3(55 downto 48)) + (fc_reg3(47 downto 40)) + (fc_reg3(39 downto 32))
                        + (fc_reg3(31 downto 24)) + (fc_reg3(23 downto 16)) + (fc_reg3(15 downto 8))
                        + (fc_reg3(7 downto 0)) + 24;
              

--    fc_out1 <= (fc_reg1(127)& fc_reg1(127 downto 120)) + (fc_reg1(119)& fc_reg1(119 downto 112)) + (fc_reg1(111)& fc_reg1(111 downto 104))
--              + (fc_reg1(103)& fc_reg1(103 downto 96)) + (fc_reg1(95)& fc_reg1(95 downto 88)) + (fc_reg1(87)& fc_reg1(87 downto 80)) 
--              + (fc_reg1(79)& fc_reg1(79 downto 72)) + (fc_reg1(71)& fc_reg1(71 downto 64)) + (fc_reg1(63)& fc_reg1(63 downto 56))
--              + (fc_reg1(55)& fc_reg1(55 downto 48)) + (fc_reg1(47)& fc_reg1(47 downto 40)) + (fc_reg1(39)& fc_reg1(39 downto 32))
--              + (fc_reg1(31)& fc_reg1(31 downto 24)) + (fc_reg1(23)& fc_reg1(23 downto 16)) + (fc_reg1(15)& fc_reg1(15 downto 8))
--              + (fc_reg1(7)& fc_reg1(7 downto 0)) - 12;


              
    --fc_out2 <= (fc_reg2(63)& fc_reg2(63 downto 60)) + (fc_reg2(59)& fc_reg2(59 downto 56)) + (fc_reg2(55)& fc_reg2(55 downto 52))
--                + (fc_reg2(51)& fc_reg2(51 downto 48)) + (fc_reg2(47)& fc_reg2(47 downto 44)) + (fc_reg2(43)& fc_reg2(43 downto 40)) 
--                + (fc_reg2(39)& fc_reg2(39 downto 36)) + (fc_reg2(35)& fc_reg2(35 downto 32)) + (fc_reg2(31)& fc_reg2(31 downto 28))
--                + (fc_reg2(27)& fc_reg2(27 downto 24)) + (fc_reg2(23)& fc_reg2(23 downto 20)) + (fc_reg2(19)& fc_reg2(19 downto 16))
--                + (fc_reg2(15)& fc_reg2(15 downto 12)) + (fc_reg2(11)& fc_reg2(11 downto 8)) + (fc_reg2(7)& fc_reg2(7 downto 4))
--                + (fc_reg2(3)& fc_reg2(3 downto 0)) + 20;
                
   -- fc_out3 <= (fc_reg3(63)& fc_reg3(63 downto 60)) + (fc_reg3(59)& fc_reg3(59 downto 56)) + (fc_reg3(55)& fc_reg3(55 downto 52))
--              + (fc_reg3(51)& fc_reg3(51 downto 48)) + (fc_reg3(47)& fc_reg3(47 downto 44)) + (fc_reg3(43)& fc_reg3(43 downto 40)) 
--              + (fc_reg3(39)& fc_reg3(39 downto 36)) + (fc_reg3(35)& fc_reg3(35 downto 32)) + (fc_reg3(31)& fc_reg3(31 downto 28))
--              + (fc_reg3(27)& fc_reg3(27 downto 24)) + (fc_reg3(23)& fc_reg3(23 downto 20)) + (fc_reg3(19)& fc_reg3(19 downto 16))
--              + (fc_reg3(15)& fc_reg3(15 downto 12)) + (fc_reg3(11)& fc_reg3(11 downto 8)) + (fc_reg3(7)& fc_reg3(7 downto 4))
--              + (fc_reg3(3)& fc_reg3(3 downto 0)) + 24;
              
 
end process;

relu: process(fc_out1, fc_out2, fc_out3)
begin
if (fc_out1(7) = '1') then
    fc1r <= (others => '0');
else
    fc1r<= fc_out1 * "1000";
end if;

if (fc_out2(7) = '1') then
    fc2r  <= (others => '0');
else
    fc2r<= fc_out2 * "0111";
end if;

if (fc_out3(7) = '1') then
    fc3r  <= (others => '0');
else
    fc3r<= fc_out3 * "0111";
end if;
end process;

fco <= fc1r + fc2r + fc3r + 6;
fc_out <= '1' when fco > 0 else '0';

end Behavioral;
