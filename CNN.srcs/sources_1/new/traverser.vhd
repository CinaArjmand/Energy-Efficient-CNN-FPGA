----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/14/2022 10:47:51 AM
-- Design Name: 
-- Module Name: traverser - Behavioral
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

entity traverser is
    Port (  clk             : in std_logic;
            rst             : in std_logic;
            data_in_1       : in std_logic_vector(63 downto 0);
            data_in_2       : in std_logic_vector(63 downto 0);
            data_in_3       : in std_logic_vector(63 downto 0);
            data_in_4       : in std_logic_vector(63 downto 0);
            data_out_1       : out std_logic_vector(3 downto 0);
            data_out_2       : out std_logic_vector(3 downto 0);
            data_out_3       : out std_logic_vector(3 downto 0);
            data_out_4       : out std_logic_vector(3 downto 0)
            
            
            
             );
end traverser;

architecture Behavioral of traverser is

signal counterbig, next_counterbig : unsigned(6 downto 0);
signal cnt_16, next_cnt_16 : unsigned(3 downto 0);
signal cnt4, nxt_cnt_4 : unsigned(2 downto 0);
signal cnt_61, next_cnt_61 : unsigned(5 downto 0);
--signal cnt2, nxt_cnt2 : std_logic;
signal c1_d1, c2_d1, c1_d2, c2_d2, c1_d3, c2_d3, c1_d4, c2_d4 : std_logic_vector(63 downto 0);
signal next_c1_d1, next_c2_d1, next_c1_d2, next_c2_d2, next_c1_d3, next_c2_d3, next_c1_d4, next_c2_d4 : std_logic_vector(63 downto 0);
signal start_sig, next_start_sig : std_logic;


begin

reg: process(clk, rst)
begin

if rising_edge(clk) then

if rst = '1' then
--    c1_d1 <= (others => '0');
--    c1_d2 <= (others => '0');
--    c1_d3 <= (others => '0');
--    c1_d4 <= (others => '0');
    c2_d1 <= (others => '0');
    c2_d2 <= (others => '0');
    c2_d3 <= (others => '0');
    c2_d4 <= (others => '0');
    start_sig <= '1';
    counterbig <= (others => '1');
    cnt_61 <= (others => '0');
    cnt_16 <= (others => '1');
else
    c1_d1 <= next_c1_d1;
    c1_d2 <= next_c1_d2;
    c1_d3 <= next_c1_d3;
    c1_d4 <= next_c1_d4;
    c2_d1 <= next_c2_d1;
    c2_d2 <= next_c2_d2;
    c2_d3 <= next_c2_d3;
    c2_d4 <= next_c2_d4;
    start_sig <= next_start_sig;
    counterbig <= next_counterbig;
    cnt_61 <= next_cnt_61;
    cnt_16 <= next_cnt_16;


end if;
end if;
    
end process;

 data_out_1 <= c1_d1(63 downto 60) when (cnt_16 < "0011") else c2_d1(63 downto 60);
 data_out_2 <= c1_d2(63 downto 60) when (cnt_16 < "0111") else c2_d2(63 downto 60);
 data_out_3 <= c1_d3(63 downto 60) when (cnt_16 < "1011") else c2_d3(63 downto 60);
 data_out_4 <= c1_d4(63 downto 60);

cos: process(counterbig) 
begin
--räkna upp när data1 byter

--if (counterbig = "0011011") then
if (counterbig = "0001111") then
    next_counterbig <= "0000000";
else
    next_counterbig <= counterbig + 1;
end if;

--if (cnt_64 = "011111") then
--    cnt_64 <= "000000";
--    next_start_sig <= '1';
--else
--    next_cnt_64 <= cnt_64 +1;
--    next_start_sig <= start_sig;
--end if; 
end process;


cnt: process(cnt_16)
begin

if (cnt_16 = "1111") then

    next_cnt_16 <= "0000";
else
    next_cnt_16 <= cnt_16 +1;
end if;
end process;


read: process(data_in_1, data_in_2, data_in_3, data_in_4, c1_d1, c2_d1, c1_d2, c2_d2, c1_d3, c2_d3, c1_d4, c2_d4,
 counterbig, start_sig, cnt_61)
begin
--if (counter = "0000") then 
--    c1_d1 <= data_in_1;
--    c1_d2 <= data_in_2;
--    c1_d3 <= data_in_3;
--    c1_d4 <= data_in_4;'

    next_c2_d1 <= c2_d1;
    next_c2_d2 <= c2_d2;
    next_c2_d3 <= c2_d3;
    next_c2_d4 <= c2_d4;
    next_start_sig <= start_sig;
                next_cnt_61 <= cnt_61;

if (start_sig = '1' and counterbig = "0000000") then 
    next_c1_d1 <= data_in_1;
    next_c1_d2 <= data_in_2;
    next_c1_d3 <= data_in_3;
    next_c1_d4 <= data_in_4;
else   
    next_c1_d1 <= c1_d1;
    next_c1_d2 <= c1_d2;
    next_c1_d3 <= c1_d3;
    next_c1_d4 <= c1_d4;

end if;
case counterbig is
        when "0000011" => --15
--            next_c1_d1 <= c1_d1(62 downto 0) & '0' ;
--            next_c1_d2 <= c1_d2(62 downto 0) & '0' ; 
--            next_c1_d3 <= c1_d3(62 downto 0) & '0' ;    
--            next_c1_d4 <= c1_d4(62 downto 0) & '0' ;

        if (start_sig = '1') then
            next_c2_d1 <= data_in_1;
         else
            next_c2_d1 <= c2_d1;
         end if;
        when "0000111" => --31
        if (start_sig = '1') then
                    next_c2_d2 <= data_in_2;
                 else
            next_c2_d2 <= c2_d2;
            end if;
        when "0001011" => --47
        if (start_sig = '1') then
                    next_c2_d3 <= data_in_3;
                    next_start_sig <= '0';
                 else
            next_c2_d3 <= c2_d3;
            end if; 
            
            
        when "0001111" => --63
            next_c1_d1 <= c1_d1(62 downto 0) & '0' ;
            next_c1_d2 <= c1_d2(62 downto 0) & '0' ; 
            next_c1_d3 <= c1_d3(62 downto 0) & '0' ;    
            next_c1_d4 <= c1_d4(62 downto 0) & '0' ;
            next_c2_d1 <= c2_d1(62 downto 0) & '0' ;
            next_c2_d2 <= c2_d2(62 downto 0) & '0' ;
            next_c2_d3 <= c2_d3(62 downto 0) & '0' ;

           -- next_c1_d4 <= c1_d4(62 downto 0) & '0' ;
              if (cnt_61 = "111011") then
                           next_cnt_61 <= "000000";
                           next_start_sig <= '1';
                       else
                           next_cnt_61 <= cnt_61 +1;
                       end if;
        when others =>
end case;


--case counterbig is
--        when "0000011" => --15
--            next_c1_d1 <= c1_d1(62 downto 0) & '0' ;
--            next_c1_d2 <= c1_d2(62 downto 0) & '0' ; 
--            next_c1_d3 <= c1_d3(62 downto 0) & '0' ;    

--        if (start_sig = '1') then
--            next_c2_d1 <= data_in_1;
--         else
--            next_c2_d1 <= c2_d1;
--         end if;
--        when "0000111" => --31
--        if (start_sig = '1') then
--                    next_c2_d2 <= data_in_2;
--                 else
--            next_c2_d2 <= c2_d2;
--            end if;
--        when "0001011" => --47
--        if (start_sig = '1') then
--                    next_c2_d3 <= data_in_3;
--                    next_start_sig <= '0';
--                 else
--            next_c2_d3 <= c2_d3;
--            end if; 
            
            
--        when "0001111" => --63
--            next_c2_d1 <= c2_d1(62 downto 0) & '0' ;
--            next_c2_d2 <= c2_d2(62 downto 0) & '0' ;
--            next_c2_d3 <= c2_d3(62 downto 0) & '0' ;

--            next_c1_d4 <= c1_d4(62 downto 0) & '0' ;
--               -- next_start_sig <= '1';

--        when "0010011" => --79
--            next_c1_d2 <= c1_d2;
            
--        when "0010111" => --95
--            next_c1_d3 <= c1_d3; 
--       -- when "0011011" => --111
--            if (cnt_61 = "111011") then
--                next_cnt_61 <= "000000";
--                next_start_sig <= '1';
--            else
--                next_cnt_61 <= cnt_61 +1;
--            end if;
--        when others =>
--end case;

--elsif (counter = "0001") then
--    c1_d1 <= data_in_1;
    
    
--case counter is
--        when "00000" => 
        
        
--        when "00011" =>
--        -- if storcounter = 4 läs annars vanligt
--        if(counterbig = "000011") then
--            next_c2_d1 <= data_in_1;
--            data_out_1 <= data_in_1(63 downto 59);
--        else
--            next_c1_d1 <= c1_d1(62 downto 0) & '0' ;
--        end if;
        
--        when "00111" =>
--        if(counterbig = "000111") then
--            next_c2_d2 <= data_in_2;
--            data_out_2 <= data_in_2(63 downto 59);
--        else
--            next_c1_d2 <= c1_d2(62 downto 0) & '0' ;
--        end if;
        
--        when "01011" =>
--        if(counterbig = "000011") then
--                    next_c2_d3 <= data_in_3;
--                    data_out_3 <= data_in_3(63 downto 59);
--                else
--                    next_c1_d3 <= c1_d3(62 downto 0) & '0' ;
--                end if;
                
--        when "01111" =>
--            next_c2_d1 <= c1_d3(62 downto 0) & '0' ;
--            next_c2_d2 <= c1_d3(62 downto 0) & '0' ;
--            next_c2_d3 <= c1_d3(62 downto 0) & '0' ;
--        when "11111" => 
    
    
--end case;

--case counterbig is
--        when "0000011" => --15
--        if (start_sig = '1') then
--            next_c2_d1 <= data_in_1;
--            next_c1_d1 <= c1_d1(62 downto 0) & '0' ;
--         else
--            next_c2_d1 <= c2_d1;
--            next_c1_d1 <= c1_d1(62 downto 0) & '0' ;
--         end if;
--        when "0000111" => --31
--        if (start_sig = '1') then
--                    next_c2_d2 <= data_in_2;
--                    next_c1_d2 <= c1_d2(62 downto 0) & '0' ; 
--                 else
--            next_c2_d2 <= c2_d2;
--            next_c1_d2 <= c1_d2(62 downto 0) & '0' ; 
--            end if;
--        when "0001011" => --47
--        if (start_sig = '1') then
--                    next_c2_d3 <= data_in_3;
--                    next_start_sig <= '0';
--                    next_c1_d3 <= c1_d3(62 downto 0) & '0' ;    
--                 else
--            next_c2_d3 <= c2_d3;
--            next_c1_d3 <= c1_d3(62 downto 0) & '0' ;    
--            end if; 
            
            
--        when "0001111" => --63
--            next_c2_d1 <= c2_d1(62 downto 0) & '0' ;
--            next_c1_d1 <= c1_d1;
--               -- next_start_sig <= '1';

--        when "0010011" => --79
--            next_c2_d2 <= c2_d2(62 downto 0) & '0' ;
--            next_c1_d2 <= c1_d2;
            
--        when "0010111" => --95
--            next_c2_d3 <= c2_d3(62 downto 0) & '0' ;
--            next_c1_d3 <= c1_d3; 
--            next_c1_d4 <= c1_d4(62 downto 0) & '0' ;
--        when "0011011" => --111
--            if (cnt_61 = "111011") then
--                next_cnt_61 <= "000000";
--                next_start_sig <= '1';
--            else
--                next_cnt_61 <= cnt_61 +1;
--            end if;
--        when others =>

--end case;

end process;





--shift1: process(data_in_1, data_in_2, data_in_3, data_in_4, start_sig)
--begin
--if (start_sig = '1') then 
--    next_c1_d1 <= data_in_1;
--    next_c1_d2 <= data_in_2;
--    next_c1_d3 <= data_in_3;
--    next_c1_d4 <= data_in_4;
--else
    
    
--end if;
--end process;


end Behavioral;
