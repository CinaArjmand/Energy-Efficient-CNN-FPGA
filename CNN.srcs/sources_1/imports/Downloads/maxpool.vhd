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
         sum1_in : in signed(4 downto 0);
         sum2_in : in signed(4 downto 0);
         sum3_in : in signed(4 downto 0);
         sum4_in : in signed(4 downto 0);
         valid_in: in std_logic;
         valid_out: out std_logic;
         max1_out: out signed(63 downto 0)
  );
end maxpool;

architecture Behavioral of maxpool is

    signal sum1, sum2, sum3, sum4 : signed(3 downto 0);
    signal max_in, max12, max34: signed(3 downto 0);
    signal count_60_height, next_count_60_height, count_60_length, next_count_60_length : unsigned(5 downto 0); 
    signal current_square, cs, next_cs : unsigned(3 downto 0);
    signal count_4_height, count_4_length, next_count_4_height, next_count_4_length : unsigned(2 downto 0);
    signal mo1, mo2, mo3, mo4, mo5, mo6, mo7, mo8, mo9, mo10, mo11, mo12, mo13, mo14, mo15, mo16 : signed(3 downto 0);
    signal next_mo1, next_mo2, next_mo3, next_mo4, next_mo5, next_mo6, next_mo7, next_mo8, next_mo9, next_mo10, 
    next_mo11, next_mo12, next_mo13, next_mo14, next_mo15, next_mo16 : signed(3 downto 0);
    signal current_squareT  : unsigned(5 downto 0);
    signal count_rows   : unsigned(5 downto 0);
    signal sr5, sr6, sr7, sr8, sr9, sr10, sr11, sr12, sr13, sr14, sr15, sr16 : signed(3 downto 0); --special register
    signal next_sr5, next_sr6, next_sr7, next_sr8, next_sr9, next_sr10, next_sr11, next_sr12, next_sr13, next_sr14, next_sr15, next_sr16 : signed(3 downto 0); 
    signal width : unsigned(5 downto 0);
    signal height : unsigned(2 downto 0);
    signal cnt_vo, nxt_cnt_vo: unsigned(3 downto 0);
    
    
begin

clock: process(clk,rst)
begin

if rising_edge(clk) then
    if(rst = '1') then
        mo1 <= (others => '0');
        mo2 <= (others => '0');
        mo3 <= (others => '0');
        mo4 <= (others => '0');
        mo5 <= (others => '0');
        mo6 <= (others => '0');
        mo7 <= (others => '0');
        mo8 <= (others => '0');
        mo9 <= (others => '0');
        mo10 <= (others => '0');
        mo11 <= (others => '0');
        mo12 <= (others => '0');
        mo13 <= (others => '0');
        mo14 <= (others => '0');
        mo15 <= (others => '0');
        mo16 <= (others => '0');
        sr5 <= (others => '0');
        sr6 <= (others => '0');
        sr7 <= (others => '0');
        sr8 <= (others => '0');
        sr9 <= (others => '0');
        sr10 <= (others => '0');
        sr11 <= (others => '0');
        sr12 <= (others => '0');
        sr13 <= (others => '0');
        sr14 <= (others => '0');
        sr15 <= (others => '0');
        sr16 <= (others => '0');
        count_4_height <= "000";
        count_4_length <= "000";
        count_60_length <= (others => '1');
        count_60_height <= (others => '0');
        cs <= "0000";
        cnt_vo <= "0000";
    else
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
        sr5 <= next_sr5;
        sr6 <= next_sr6;
        sr7 <= next_sr7;
        sr8 <= next_sr8;
        sr9 <= next_sr9;
        sr10 <= next_sr10;
        sr11 <= next_sr11;
        sr12 <= next_sr12;
        sr13 <= next_sr13;
        sr14 <= next_sr14;
        sr15 <= next_sr15;
        sr16 <= next_sr16;
        count_4_height <= next_count_4_height;
        count_4_length <= next_count_4_length;
        count_60_length <= next_count_60_length;
        count_60_height <= next_count_60_height;
        cs <= next_cs;
        cnt_vo <= nxt_cnt_vo;
    end if;
end if;
end process;

max1_out <= mo1 & mo2 & mo3 & mo4 & mo5 & mo6 & mo7 & mo8 & mo9 & mo10 & mo11 & mo12 & mo13 & mo14 & mo15 & mo16;


counting: process (valid_in, count_4_height, count_4_length, count_60_height, count_60_length)
begin
next_count_4_length <= count_4_length;
next_count_4_height <= count_4_height;
next_count_60_length <= count_60_length;
next_count_60_height <= count_60_height;

if (valid_in = '1') then
--if (count_4_length = "11") then 
    if (count_60_length = "111011") then 
        next_count_60_length <= "000000";
    else
        next_count_60_length <=  count_60_length + 1;
    end if;
   next_count_4_length <= "000";

    if (count_60_height = "111000" and count_60_length = "111011") then --HEIGHT ONLY 56 NOT 59!!! because only 58 steps are made down
        next_count_60_height <= "000000";
        next_count_4_height <= count_4_height + 1;
    elsif (count_60_length = "111011") then
        next_count_60_height <=  count_60_height + 4;
       -- next_count_4_height <= count_4_height;
    end if;   

--else
--if (count_15_length = "1111") then --15
--    next_count_15_length <= "0000";
--    next_count_4_length <=  count_4_length + 1;
--else
--    next_count_15_length <=  count_15_length + 1;

--end if;
  -- next_count_4_length <=  count_4_length + 1;
end if;
--end if;


end process;



ReLu: process(sum1_in, sum2_in, sum3_in, sum4_in, valid_in)
begin


if valid_in = '1' then

    if (sum1_in(4) = '1') then
        sum1 <= "0000";
    else 
        sum1 <= sum1_in(3 downto 0);
    end if;
    
    if (sum2_in(4) = '1') then
        sum2 <= "0000";
    else 
        sum2 <= sum2_in(3 downto 0);
    end if;
    
    if (sum3_in(4) = '1') then
        sum3 <= "0000";
    else 
        sum3 <= sum3_in(3 downto 0);
    end if;
    
    if (sum4_in(4) = '1') then
        sum4 <= "0000";
    else 
        sum4 <= sum4_in(3 downto 0);
    end if;
    
    else
    
    sum1 <= "0000";
    sum2 <= "0000";
    sum3 <= "0000";
    sum4 <= "0000";
end if;



end process; 


--count_rows <= (count_4_height+1) * (count_15_height+3);
count_rows <= count_60_height;

read: process(sum1, sum2, sum3, sum4, current_square, valid_in, mo5, mo6, mo7, mo8, mo9, mo10,
 mo11, mo12, mo13, mo14, mo15, mo16, sr5, sr6, sr7, sr8, sr9, sr10, sr11, sr12, sr13, sr14, sr15, sr16)

begin

next_sr5 <= sr5;
next_sr6 <= sr6;
next_sr7 <= sr7;
next_sr8 <= sr8;
next_sr9 <= sr9;
next_sr10 <= sr10;
next_sr11 <= sr11;
next_sr12 <= sr12;
next_sr13 <= sr13;
next_sr14 <= sr14;
next_sr15 <= sr15;
next_sr16 <= sr16;

if (valid_in = '1') then
--case count_rows is
--    when "001100" => -- when 12
--        if(sum1 > sum2) then
--            max12 <= sum1; 
--        else
--            max12 <= sum2;
--        end if;
        
--        max34 <= sum3;
        
--        if (current_square = "000001") then
--            if (sum4 > sr5) then
--                next_sr5 <= sum4;
--            end if;
--        elsif (current_square = "000010") then
--            if (sum4 > sr6) then
--                next_sr6 <= sum4;
--            end if;
--        elsif (current_square = "000011") then
--            if (sum4 > sr7) then
--                next_sr7 <= sum4;
--            end if;
--        elsif (current_square = "000100") then
--            if (sum4 > sr8) then
--                next_sr8 <= sum4;
--            end if;
--        end if;
        
--    when "011000" => --when 24
--        if(sum1 > sum2) then
--            max12 <= sum1;
--        else
--            max12 <= sum2;
--        end if;
        
--        max34 <= "0000";   
        
        
--        if (current_square = "000101") then
--            if (sum4 > sum3 and sum4 > sr9) then
--                next_sr9 <= sum4;
--            elsif (sum3 > sr9) then
--                next_sr9 <= sum3;
--            end if;
--        elsif (current_square = "000110") then
--            if (sum4 > sum3 and sum4 > sr10) then
--                next_sr10 <= sum4;
--            elsif (sum4 > sr10) then
--                next_sr10 <= sum3;
--            end if;
--        elsif (current_square = "000111") then
--            if (sum4 > sum3 and sum4 > sr11) then
--                next_sr11 <= sum4;
--            elsif (sum4 > sr11) then
--                next_sr11 <= sum3;
--            end if;
--        elsif (current_square = "001000") then
--            if (sum4 > sum3 and sum4 > sr12) then
--                next_sr12 <= sum4;
--            elsif (sum4 > sr12) then
--                next_sr12 <= sum3;
--            end if;
--        end if;
        
--    when "100100" => --when 36
--        max12 <= sum1;
--        max34 <= "0000"; 
        
--         if (current_square = "001001") then
--            if (sum4 > sum3) then
--                if (sum2 > sum4 and sum2 > sr13) then
--                    next_sr13 <= sum2;
--                elsif (sum4 > sr13) then
--                    next_sr13 <= sum4;
--                end if;
--            else
--                if (sum2 > sum3 and sum2 > sr13) then
--                    next_sr13 <= sum2;
--                elsif (sum3 > sr13) then
--                    next_sr13 <= sum3;
--                end if;
--            end if;
--        elsif (current_square = "001010") then
--             if (sum4 > sum3) then
--                if (sum2 > sum4 and sum2 > sr14) then
--                    next_sr14 <= sum2;
--                elsif (sum4 > sr14) then
--                    next_sr14 <= sum4;
--                end if;
--            else
--                if (sum2 > sum3 and sum2 > sr14) then
--                    next_sr14 <= sum2;
--                elsif (sum3 > sr14) then
--                    next_sr14 <= sum3;
--                end if;
--            end if;
--        elsif (current_square = "001011") then
--            if (sum4 > sum3) then
--                if (sum2 > sum4 and sum2 > sr15) then
--                    next_sr15 <= sum2;
--                elsif (sum4 > sr15) then
--                    next_sr15 <= sum4;
--                end if;
--            else
--                if (sum2 > sum3 and sum2 > sr15) then
--                    next_sr15 <= sum2;
--                elsif (sum3 > sr15) then
--                    next_sr15 <= sum3;
--                end if;
--            end if;
--        elsif (current_square = "001100") then
--            if (sum4 > sum3) then
--                if (sum2 > sum4 and sum2 > sr16) then
--                    next_sr16 <= sum2;
--                elsif (sum4 > sr16) then
--                    next_sr16 <= sum4;
--                end if;
--            else
--                if (sum2 > sum3 and sum2 > sr16) then
--                    next_sr16 <= sum2;
--                elsif (sum3 > sr16) then
--                    next_sr16 <= sum3;
--                end if;
--            end if;
--        end if;
        
--    when others =>
--        if(sum1 > sum2) then
--            max12 <= sum1;
--        else
--            max12 <= sum2;
--        end if;
        
--        if(sum3 > sum4) then
--            max34 <= sum3;
--        else
--            max34 <= sum4;
--        end if;


--end case;
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


csp: process(count_60_length, count_60_height)
begin
--    if (count_60_length <= "001110") then
--        width <= "000000";
--    elsif (count_60_length <= "011110") then
--        width <= "000001";
--    elsif (count_60_length <= "101101") then
--        width <= "000010";
--    elsif (count_60_length <= "111100") then
--        width <= "000011";
--    else 
--        width <= "UUUUUU";
--    end if;
    
--    if (count_60_height <= "001111") then
--        height <= "000";
--    elsif (count_60_height <= "011110") then
--        height <= "001";
--    elsif (count_60_height <= "101101") then
--        height <= "010";
--    elsif (count_60_height <= "111100") then
--        height <= "011";
--    else 
--        height <= "UUU";
--    end if;
 if (count_60_length < "001110") then
    width <= "000000";
elsif (count_60_length <= "011110") then
    width <= "000001";
elsif (count_60_length <= "101101") then
    width <= "000010";
elsif (count_60_length <= "111100") then
    width <= "000011";
else 
    width <= "UUUUUU";
end if;

if (count_60_height <= "001111") then
    height <= "000";
elsif (count_60_height <= "011110") then
    height <= "001";
elsif (count_60_height <= "101101") then
    height <= "010";
elsif (count_60_height <= "111100") then
    height <= "011";
else 
    height <= "UUU";
end if;
    
end process;

current_squareT <= (4*(height)) + (width);
current_square <= current_squareT(3 downto 0);


mo: process(current_square, mo1, mo2, mo3, mo4, mo5, mo6, mo7, mo8, mo9, mo10, mo11, mo12, mo13, mo14, mo15, mo16, max_in,
sr5, sr6, sr7, sr8, sr9, sr10, sr11, sr12, sr13, sr14, sr15, sr16)
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
            if (max_in > sr5) then
                next_mo5 <= max_in;
            else
                next_mo5 <= sr5;
            end if;
        end if;                    
     when "0101" =>
        if (max_in > mo6) then
            if (max_in > sr6) then
                next_mo6 <= max_in;
            else
                next_mo6 <= sr6;
            end if;        
        end if;                                                                                                                                                                                                 
     when "0110" =>
        if (max_in > mo7) then
            if (max_in > sr7) then
                next_mo7 <= max_in;
            else
                next_mo7 <= sr7;
            end if;
        end if;                                                                                                                                                                                                 
     when "0111" =>
        if (max_in > mo8) then
            if (max_in > sr8) then
                next_mo8 <= max_in;
            else
                next_mo8 <= sr8;
            end if;        
        end if;                                                                                                                                                                                                 
     when "1000" =>
        if (max_in > mo9) then
            if (max_in > sr9) then
                next_mo9 <= max_in;
            else
                next_mo9 <= sr9;
            end if;
        end if;                                                                                                                                                                                                 
     when "1001" =>
        if (max_in > mo10) then
            if (max_in > sr10) then
                next_mo10 <= max_in;
            else
                next_mo10 <= sr10;
            end if;        
        end if;                                                                                                                                                                                                 
     when "1010" =>
        if (max_in > mo11) then
            if (max_in > sr11) then
                next_mo11 <= max_in;
            else
                next_mo11 <= sr11;
            end if;        
        end if;                                                                                                                                                                                                 
     when "1011" =>
        if (max_in > mo12) then
            if (max_in > sr12) then
                next_mo12 <= max_in;
            else
                next_mo12 <= sr12;
            end if;        
        end if;                                                                                                                                                                                                 
     when "1100" =>
        if (max_in > mo13) then
            if (max_in > sr13) then
                next_mo13 <= max_in;
            else
                next_mo13 <= sr13;
            end if;               
        end if;
     when "1101" =>
        if (max_in > mo14) then
            if (max_in > sr14) then
                next_mo14 <= max_in;
            else
                next_mo14 <= sr14;
            end if;        
        end if;                                                                                                                                                                                                 
     when "1110" =>
        if (max_in > mo15) then
            if (max_in > sr15) then
                next_mo15 <= max_in;
            else
                next_mo15 <= sr15;
            end if;        
        end if;                                                                                                                                                                                                 
     when "1111" =>
        if (max_in > mo16) then
            if (max_in > sr16) then
--                next_mo9 <= max_in;
               next_mo16 <= max_in;
            else
                next_mo16 <= sr16;
            end if;        
        end if;                                                                                                                                                                                                 
     when others =>
     
     

                    
end case;

end process;

vo: process(current_square, cs, cnt_vo)
begin

--if (current_square = "0000") then
-- cs = "0000";
--end if;
        valid_out <= '0';

next_cs <= cs;
nxt_cnt_vo <= cnt_vo;
if (current_square /= cs) then
    --valid_out <= '1';
    if (cnt_vo = "0011") then
        nxt_cnt_vo <= "0000";
        valid_out <= '1';
    else
        nxt_cnt_vo <= cnt_vo +1;
    end if;
    next_cs <= current_square;
--else
--    valid_out <= '0';
end if;
end process;
          
     
end Behavioral;
