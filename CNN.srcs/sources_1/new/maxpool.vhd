----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/10/2022 11:22:28 AM
-- Design Name: 
-- Module Name: maxpool - Behavioral
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
-- hur ska man göra utan att det blir en miljon if satser! vi kör en halv miljon case och en halv miljon if!
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity maxpool is
  port ( 
         rst     : in std_logic;
         clk     : in std_logic;   
         sum1_in : in signed(3 downto 0);
         sum2_in : in signed(3 downto 0);
         sum3_in : in signed(3 downto 0);
         sum4_in : in signed(3 downto 0);
         valid_in: in std_logic;
         max1_out: out signed(3 downto 0)
  );
end maxpool;

architecture Behavioral of maxpool is

    signal sum1, sum2, sum3, sum4 : signed(3 downto 0);
    signal next_max, current_max : signed(5 downto 0);
    signal max_in, max12, max34: signed(3 downto 0);
    signal count_15_height, count_15_length, next_count_15_height, next_count_15_length, current_square : unsigned(3 downto 0);
    signal count_4_height, count_4_length, next_count_4_height, next_count_4_length : unsigned(2 downto 0);
    signal mo1, mo2, mo3, mo4, mo5, mo6, mo7, mo8, mo9, mo10, mo11, mo12, mo13, mo14, mo15, mo16 : signed(3 downto 0);
    signal next_mo1, next_mo2, next_mo3, next_mo4, next_mo5, next_mo6, next_mo7, next_mo8, next_mo9, next_mo10, 
    next_mo11, next_mo12, next_mo13, next_mo14, next_mo15, next_mo16 : signed(3 downto 0);
    signal count_rows, count_cols, next_count_rows, next_count_cols  : unsigned(5 downto 0);
    
begin

clock: process(clk,rst)
begin

if rising_edge(clk) then
    if(rst = '1') then
        current_max     <= "00";
        count_4_height  <= (others => '0');
        count_4_length  <= (others => '0');
        count_15_height <= (others => '0');
        count_15_length <= (others => '0');
    
    else
        current_max <= next_max;
        mo1 <= next_mo1;
        mo2 <= next_mo2;
        mo3 <= next_mo3;
        mo4 <= next_mo4;
        mo5 <= next_mo5;
        mo6 <= next_mo6;
        mo7 <= next_mo7;
        mo8 <= next_mo8;
        mo9 <= next_mo9;
        mo10 <= next_mo10;
        mo11 <= next_mo11;
        mo12 <= next_mo12;
        mo13 <= next_mo13;
        mo14 <= next_mo14;
        mo15 <= next_mo15;
        mo16 <= next_mo16;
        count_rows <= next_count_rows;
        count_cols <= next_count_cols;
        count_4_height <= next_count_4_height;
        count_4_length <= next_count_4_length;
        count_15_length <= next_count_15_length;
        count_15_height <= next_count_15_height;
    end if;
end if;
end process;

counting: process (valid_in, count_4_height, count_4_length, count_15_height, count_15_length, count_rows, count_cols)
begin
if (count_cols = "111011") then --59?
    next_count_cols <= "00000";
    next_count_rows <= count_rows + 1;
    if (count_15_height = "1111") then
        next_count_15_height <= "0000";
        if (count_4_height = "111") then
            next_count_4_height <= "000";
        else 
            next_count_4_height <=  count_4_height + 1;
        end if;
    else
        next_count_15_height <= count_15_height +1;
    end if;
else
    next_count_cols <= count_cols + 1;
    next_count_rows <= count_rows;
end if;

if (count_15_length = "1111") then --15
    next_count_15_length <= "0000";
    if (count_4_length = "111") then
        next_count_4_length <= "000";
    else 
        next_count_4_length <=  count_4_length + 1;
    end if;
else
    next_count_15_length <= count_15_length + 1;

end if;

end process;



ReLu: process(sum1_in, sum2_in, sum3_in, sum4_in, valid_in)
begin


if valid_in = '1' then

    if (sum1_in(3) = '1') then
        sum1 <= "0000";
    else 
        sum1 <= sum1_in;
    end if;
    
    if (sum2_in(3) = '1') then
        sum2 <= "0000";
    else 
        sum2 <= sum2_in;
    end if;
    
    if (sum3_in(3) = '1') then
        sum3 <= "0000";
    else 
        sum3 <= sum3_in;
    end if;
    
    if (sum4_in(3) = '1') then
        sum4 <= "0000";
    else 
        sum4 <= sum4_in;
    end if;
    
end if;



end process; 


read: process(sum1, sum2, sum3, sum4, current_square, valid_in, mo4, mo5, mo6)
begin

--max1_out <= current_max;
--when count = 16, max_out = max_temp
if (valid_in = '1') then
case count_rows is
    when "001011" => -- when 11
        if(sum1 > sum2) then
            max12 <= sum1; -- dess måste göras till next_maxXX, annars blire dubbelt körande av processen pga maxXX är i sensitivity list, maxXX ska uppdateras med clk
        else
            max12 <= sum2;
        end if;
        
        max34 <= sum3;
        
        if (current_square = "000001") then
            next_mo5 <= sum4;
            next_mo6 <= mo6;
            next_mo7 <= mo7;
            next_mo8 <= mo8;
        elsif (current_square = "000010") then
            next_mo5 <= mo5;
            next_mo6 <= sum4;
            next_mo7 <= mo7;
            next_mo8 <= mo8;
        elsif (current_square = "000011") then
            next_mo5 <= mo5;
            next_mo6 <= mo6;
            next_mo7 <= sum4;
            next_mo8 <= mo8;
        elsif (current_square = "000100") then
            next_mo5 <= mo5;
            next_mo6 <= mo6;
            next_mo7 <= mo7;
            next_mo8 <= sum4;
        else
            next_mo5 <= mo5;
            next_mo6 <= mo6;
            next_mo7 <= mo7;
            next_mo8 <= mo8;
        end if;
        
    when "011011" => --when 27
        if(sum1 > sum2) then
            max12 <= sum1;
        else
            max12 <= sum2;
        end if;
        
        max34 <= "0000";   
        
        
        if (current_square = "000101") then
            if (sum4 > sum3) then
                next_mo9 <= sum4;
            else
                next_mo9 <= sum3;
            end if;
            next_mo10 <= mo10;
            next_mo11 <= mo11;
            next_mo12 <= mo12;
        elsif (current_square = "000110") then
            if (sum4 > sum3) then
                next_mo10 <= sum4;
            else
                next_mo10 <= sum3;
            end if;
            next_mo9 <= mo9;
            next_mo11 <= mo11;
            next_mo12 <= mo12;
        elsif (current_square = "000111") then
            if (sum4 > sum3) then
                next_mo11 <= sum4;
            else
                next_mo11 <= sum3;
            end if;
            next_mo9 <= mo9;
            next_mo10 <= mo10;
            next_mo12 <= mo12;
        elsif (current_square = "001000") then
            if (sum4 > sum3) then
                next_mo12 <= sum4;
            else
                next_mo12 <= sum3;
            end if;
            next_mo9 <= mo9;
            next_mo10 <= mo10;
            next_mo11 <= mo11;
        else
            next_mo7 <= mo7;
            next_mo8 <= mo8;
            next_mo9 <= mo9;
        end if;
        
    when "101011" => --when 43
        max12 <= sum1;
        max34 <= "0000"; 
        
         if (current_square = "001001") then
            if (sum4 > sum3) then
                if (sum2 > sum4) then
                    next_mo13 <= sum2;
                else
                    next_mo13 <= sum4;
                end if;
            else
                if (sum2 > sum3) then
                    next_mo13 <= sum2;
                else
                    next_mo13 <= sum3;
                end if;
            end if;
            next_mo14 <= mo14;
            next_mo15 <= mo15;
            next_mo16 <= mo16;
        elsif (current_square = "001010") then
             if (sum4 > sum3) then
                if (sum2 > sum4) then
                    next_mo14 <= sum2;
                else
                    next_mo14 <= sum4;
                end if;
            else
                if (sum2 > sum3) then
                    next_mo14 <= sum2;
                else
                    next_mo14 <= sum3;
                end if;
            end if;
            next_mo13 <= mo13;
            next_mo15 <= mo15;
            next_mo16 <= mo16;
        elsif (current_square = "001011") then
            if (sum4 > sum3) then
                if (sum2 > sum4) then
                    next_mo15 <= sum2;
                else
                    next_mo15 <= sum4;
                end if;
            else
                if (sum2 > sum3) then
                    next_mo15 <= sum2;
                else
                    next_mo15 <= sum3;
                end if;
            end if;
            next_mo13 <= mo13;
            next_mo14 <= mo14;
            next_mo16 <= mo16;
        elsif (current_square = "001100") then
            if (sum4 > sum3) then
                if (sum2 > sum4) then
                    next_mo16 <= sum2;
                else
                    next_mo16 <= sum4;
                end if;
            else
                if (sum2 > sum3) then
                    next_mo16 <= sum2;
                else
                    next_mo16 <= sum3;
                end if;
            end if;
            next_mo13 <= mo13;
            next_mo14 <= mo14;
            next_mo15 <= mo15;
    
    when others =>
        if(sum1 > sum2) then
            max12 <= sum1;
        else
            max12 <= sum2;
        end if;
        
        if(sum3 > sum4) then
            max34 <= sum3;
        else
            max34 <= sum4;
        end if;


end case;
else

end if;

end process;


maxin: process(max12, max34)
begin
 if (max34 > max12) then
           max_in <= max34;
       else
           max_in <= max12;
       end if;    
end process;



current_square <= count_4_height * count_4_length;



mo: process(max_in)
begin
next_mo1 <= mo1;
next_mo2 <= mo2;
next_mo3 <= mo3;
next_mo4 <= mo4;
next_mo5 <= mo5;
next_mo6 <= mo6;
next_mo7 <= mo7;
next_mo8 <= mo8;
next_mo9 <= mo9;
next_mo10 <= mo10;
next_mo11 <= mo11;
next_mo12 <= mo12;
next_mo13 <= mo13;
next_mo14 <= mo14;
next_mo15 <= mo15;
next_mo16 <= mo16;

case current_square is
    when "0000" =>
        if (max_in > mo1) then
            next_mo1 <= max_in;
        end if;
    when "0001" =>
        if (max_in > mo2) then
            next_mo2 <= max_in;
        end if;
    when "0010" =>
        if (max_in > mo3) then
            next_mo3 <= max_in;
        end if;
    when "0011" =>
        if (max_in > mo4) then
            next_mo4 <= max_in;
        end if;
    when "0100" =>
        if (max_in > mo5) then
            next_mo5 <= max_in;
        end if;                    
     when "0101" =>
        if (max_in > mo6) then
            next_mo6 <= max_in;
        end if;                                                                                                                                                                                                 
     when "0110" =>
        if (max_in > mo7) then
            next_mo7 <= max_in;
        end if;                                                                                                                                                                                                 
     when "0111" =>
        if (max_in > mo8) then
            next_mo8 <= max_in;
        end if;                                                                                                                                                                                                 
     when "1000" =>
        if (max_in > mo9) then
            next_mo9 <= max_in;
        end if;                                                                                                                                                                                                 
     when "1001" =>
        if (max_in > mo10) then
            next_mo10 <= max_in;
        end if;                                                                                                                                                                                                 
     when "1010" =>
        if (max_in > mo11) then
            next_mo11 <= max_in;
        end if;                                                                                                                                                                                                 
     when "1011" =>
        if (max_in > mo12) then
            next_mo12 <= max_in;
        end if;                                                                                                                                                                                                 
     when "1100" =>
        if (max_in > mo13) then
            next_mo13 <= max_in;
        end if;                                                                                                                                                                                                 
     when "1101" =>
        if (max_in > mo14) then
            next_mo14 <= max_in;
        end if;                                                                                                                                                                                                 
     when "1110" =>
        if (max_in > mo15) then
            next_mo15 <= max_in;
        end if;                                                                                                                                                                                                 
     when "1111" =>
        if (max_in > mo16) then
            next_mo16 <= max_in;
        end if;                                                                                                                                                                                                 
                    
                    
                    
                    
end case;

end process;

end Behavioral;
