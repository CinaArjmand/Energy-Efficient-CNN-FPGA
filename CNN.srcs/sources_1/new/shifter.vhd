----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Fabian Eklund Sigleifs
-- 
-- Create Date: 10/07/2022 03:27:39 PM
-- Design Name: 
-- Module Name: shifter - Behavioral
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
-- FIX FIRST OUTPUT NOT DONE!!!!!!
entity shifter is
    Port (
    clk : in STD_LOGIC;
    rst : in STD_LOGIC;
    data_1out : out STD_LOGIC;
    data_2out : out STD_LOGIC;
    data_3out : out STD_LOGIC;
    data_4out : out STD_LOGIC
    );
--  Port ( );
end shifter;

architecture Behavioral of shifter is


component RAM_IP_TOP is
    Port (
            clk         : in std_logic;
            data_1      : in std_logic_vector(63 downto 0);
            data_2      : in std_logic_vector(63 downto 0);
            data_3      : in std_logic_vector(63 downto 0);
            data_4      : in std_logic_vector(63 downto 0);
            address_1   : in std_logic_vector(3 downto 0);
            address_2   : in std_logic_vector(3 downto 0);
            address_3   : in std_logic_vector(3 downto 0);
            address_4   : in std_logic_vector(3 downto 0);
            wen_1       : in std_logic;
            wen_2       : in std_logic;
            wen_3       : in std_logic;
            wen_4       : in std_logic;
            count_def   : in unsigned(1 downto 0);
            data_out_1  : out std_logic_vector(63 downto 0);
            data_out_2  : out std_logic_vector(63 downto 0);
            data_out_3  : out std_logic_vector(63 downto 0);
            data_out_4  : out std_logic_vector(63 downto 0)
                );
end component;

component traverser is
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
end component;

signal current_data_counter, next_data_counter : unsigned (5 downto 0);
signal current_address_counter1, next_address_counter1,current_address_counter2, next_address_counter2,current_address_counter3, 
next_address_counter3,current_address_counter4, next_address_counter4 : unsigned (3 downto 0);
signal data0: std_logic_vector(63 downto 0);
signal we_disable: std_logic;
signal address_1, address_2, address_3, address_4: std_logic_vector(3 downto 0);
signal current_count_def, next_count_def: unsigned(1 downto 0);
signal out_data_1, out_data_2,out_data_3,out_data_4: std_logic_vector(3 downto 0);
signal data_1, data_2,data_3,data_4: std_logic_vector(63 downto 0);
signal current_count_to_4, next_count_to_4 : unsigned(1 downto 0);
signal current_count_to_4a, next_count_to_4a : unsigned(1 downto 0);
signal current_data_1, current_data_2,current_data_3,current_data_4, next_data_1, next_data_2,next_data_3,next_data_4: std_logic_vector(3 downto 0);
signal current_count_to_16, next_count_to_16: unsigned(3 downto 0);
signal next_count_to_7168 ,current_count_to_7168: unsigned(12 downto 0);
type state_type is (s_0, s_1, s_2, s_3);
signal current_state, next_state: state_type;



begin

RAM_IP_TOP1: RAM_IP_TOP
    port map (
            clk        => clk,
            data_1     => data0,
            data_2      => data0,
            data_3      => data0,
            data_4      => data0,
            address_1   => address_1,
            address_2   => address_2,
            address_3   => address_3,
            address_4   => address_4,    
            wen_1       => we_disable,
            wen_2       => we_disable,
            wen_3       => we_disable,
            wen_4       => we_disable,
            count_def   => current_count_def,
            data_out_1  => data_1,
            data_out_2  => data_2,
            data_out_3  => data_3,
            data_out_4  => data_4
                );


trav1: traverser
port map(   clk  => clk,
            rst  => rst,
            data_in_1  => data_1,
            data_in_2  => data_2,
            data_in_3  => data_3,
            data_in_4   => data_4,
            data_out_1     => out_data_1,
            data_out_2       => out_data_2,
            data_out_3     => out_data_3,
            data_out_4      => out_data_4
);







process(clk, rst)
begin
    
    if rising_edge(clk) then
    if rst = '1' then
        current_data_counter <= (others => '0');
        current_address_counter1 <= (others => '0');
        current_address_counter2 <= (others => '0');
        current_address_counter3 <= (others => '0');
        current_address_counter4 <= (others => '0');
        current_count_def <= (others => '0');
        current_count_to_4 <= (others => '0');
        current_count_to_4a <= (others => '0');
        current_count_to_16 <= (others => '0');
        current_count_to_7168 <= "0000000000010";
--        current_data_1 <=  (others => '0');
--        current_data_2 <=  (others => '0');
--        current_data_3 <= (others => '0');
--        current_data_4 <=  (others => '0'); 
        --next_count_def <= (others => '0');
        --next_data_counter <= (others => '0');
       -- next_address_counter <= (others => '0');
       current_state <= s_0;


    else
        current_data_counter <= next_data_counter;
        current_address_counter1 <= next_address_counter1;
        current_address_counter2 <= next_address_counter2;
        current_address_counter3 <= next_address_counter3;
        current_address_counter4 <= next_address_counter4;
        
        current_data_1 <=  next_data_1;
        current_data_2 <=  next_data_2;
        current_data_3 <=  next_data_3;
        current_data_4 <=  next_data_4;
        current_count_def <= next_count_def;
        current_count_to_4 <= next_count_to_4;
        current_count_to_4a <= next_count_to_4a;
        current_count_to_16 <= next_count_to_16;
        current_count_to_7168 <= next_count_to_7168;
        current_state <= next_state;

    end if;
    end if;
    
end process;


we_disable <= '0';
data0 <= (others => '0');
--next_count_to_16 <= current_count_to_16 +1;
--count_to_16 <= current_count_to_16;

states: process(current_count_to_16, current_state)
begin
next_state <= current_state;

    if (current_count_to_16 = "11") then
        next_state <= s_1;
    end if;
    
    if (current_count_to_16 = "111") then
        next_state <= s_2;
    end if;
    
     if (current_count_to_16 = "1011") then
        next_state <= s_3;
    end if;  
             
    if (current_count_to_16 = "1111") then
        next_state <= s_0;
    end if;   
end process;


process (current_data_counter, current_address_counter1, current_count_def, out_data_1,out_data_2,
out_data_3,out_data_4,current_data_1,current_data_2,current_data_3,current_data_4, current_count_to_4,
current_address_counter2, current_address_counter3, current_address_counter4, current_count_to_16, current_count_to_7168, current_state, current_count_to_4)

    begin
    next_address_counter1 <= current_address_counter1; 
    next_address_counter2 <= current_address_counter2; 
    next_address_counter3 <= current_address_counter3; 
    next_address_counter4 <= current_address_counter4; 
    next_count_to_4a <= current_count_to_4a;
    next_count_to_4 <= current_count_to_4;
    next_count_to_16 <= current_count_to_16;
        --next_count_to_7168 <= current_count_to_7168;


    next_data_counter <= current_data_counter; 
    address_1 <= std_logic_vector(current_address_counter1);
    address_2 <= std_logic_vector(current_address_counter2);
    address_3 <= std_logic_vector(current_address_counter3);
    address_4 <= std_logic_vector(current_address_counter4);
    
    if (out_data_4 /= "UUUU") then
        next_count_to_4 <= current_count_to_4  + 1;
        next_count_to_16 <= current_count_to_16 + 1;
     --   if (current_count_to_7168 = "1101010101111") then
--       if (current_count_to_7168 = "11010001111") then
       if (current_count_to_7168 = "1110111111") then
            next_count_to_7168 <= (others => '0');
        else
            next_count_to_7168 <= current_count_to_7168 + 1;
        end if;
    else
     next_count_to_7168 <= current_count_to_7168;
    end if;
    
--    if(current_data_counter = "111111" and current_address_counter4= "1111") then
--        next_data_counter <= current_data_counter;  
----        data_1out   <= '1';
----        data_2out   <= '1';
----        data_3out   <= '1';
----        data_4out   <= '1';
--    else
    --end if;
            next_count_def <= current_count_def;


        if(current_count_to_4 = "11") then
            next_count_def <= current_count_def +1;
            next_data_counter <= current_data_counter +1;
            
            
            
             
        end if;
        
--        if (current_count_to_7168 = "11010001111") then
       if (current_count_to_7168 = "1110111111") then

--            next_address_counter1 <= current_address_counter1 + 1;
--            next_address_counter2 <= current_address_counter2 + 1;
--            next_address_counter3 <= current_address_counter3 + 1;
            next_address_counter4 <= current_address_counter4 + 1;
        end if;
        
        
        
        if (current_count_to_7168 = "11") then
           -- if (current_count_to_4a = "00") then
                next_address_counter1 <= current_address_counter1 + 1;
                next_count_to_4a <= current_count_to_4a + 1;
            end if;
            
            if (current_count_to_7168 = "111") then
                next_address_counter2 <= current_address_counter2 + 1;
                next_count_to_4a <= current_count_to_4a + 1;
            end if;
            
             if (current_count_to_7168 = "1011") then
                next_address_counter3 <= current_address_counter3 + 1;
                next_count_to_4a <= current_count_to_4a + 1;
            end if;  
                     
--            if (current_count_to_7168 = "1111") then
--                next_address_counter4 <= current_address_counter4 + 1;
--                next_count_to_4a <= current_count_to_4a + 1;
--                next_state <= s_0;
--            end if;            
            
--             if (current_count_to_7168 = "10011") then
--                  -- if (current_count_to_4a = "00") then
--                       next_address_counter1 <= current_address_counter1 + 1;
--                       next_count_to_4a <= current_count_to_4a + 1;
--                       next_state <= s_1;
--                   end if;
                   
--                   if (current_count_to_7168 = "10111") then
--                       next_address_counter2 <= current_address_counter2 + 1;
--                       next_count_to_4a <= current_count_to_4a + 1;
--                       next_state <= s_2;
--                   end if;
                   
--                    if (current_count_to_7168 = "11011") then
--                       next_address_counter3 <= current_address_counter3 + 1;
--                       next_count_to_4a <= current_count_to_4a + 1;
--                       next_state <= s_3;
--                   end if;  
                            
--                   if (current_count_to_7168 = "11111") then
--                       next_address_counter4 <= current_address_counter4 + 1;
--                       next_count_to_4a <= current_count_to_4a + 1;
--                       next_state <= s_0;
--                   end if;            
                       
           -- end if;
   -- end if;
    
    
    --end if;
--      if(current_count_to_4 = "11") then
--        next_data_1 <=  out_data_1(2 downto 0) & '0';
--        next_data_2 <=  out_data_2(2 downto 0) & '0';
--        next_data_3 <=  out_data_3(2 downto 0) & '0';
--        next_data_4 <=  out_data_4(2 downto 0) & '0';
--        data_1out   <= out_data_1(3);
--        data_2out   <= out_data_2(3);
--        data_3out   <= out_data_3(3);
--        data_4out   <= out_data_4(3);
--    else
--        next_data_1 <= current_data_1(2 downto 0) & '0';
--        next_data_2 <= current_data_2(2 downto 0) & '0';
--        next_data_3 <= current_data_3(2 downto 0) & '0';
--        next_data_4 <= current_data_4(2 downto 0) & '0';     
--        data_1out   <= current_data_1(3);
--        data_2out   <= current_data_2(3);
--        data_3out   <= current_data_3(3);
--        data_4out   <= current_data_4(3);
--    end if;

if(current_count_to_4 = "00") then 
--if(current_count_to_16 = "0000") then --should be 16?
        case current_state is 
            when s_0 =>
                next_data_1 <= out_data_1(2 downto 0) & '0';
                next_data_2 <= out_data_2(2 downto 0) & '0';
                next_data_3 <= out_data_3(2 downto 0) & '0';
                next_data_4 <= out_data_4(2 downto 0) & '0';
                data_1out   <= out_data_1(3);
                data_2out   <= out_data_2(3);
                data_3out   <= out_data_3(3);
                data_4out   <= out_data_4(3);
            when s_1 =>
                next_data_1 <= out_data_2(2 downto 0) & '0';
                next_data_2 <= out_data_3(2 downto 0) & '0';
                next_data_3 <= out_data_4(2 downto 0) & '0';
                next_data_4 <= out_data_1(2 downto 0) & '0';
                data_1out   <= out_data_2(3);
                data_2out   <= out_data_3(3);
                data_3out   <= out_data_4(3);
                data_4out   <= out_data_1(3);
            when s_2 =>
                 next_data_1 <= out_data_3(2 downto 0) & '0';
                 next_data_2 <= out_data_4(2 downto 0) & '0';
                 next_data_3 <= out_data_1(2 downto 0) & '0';
                 next_data_4 <= out_data_2(2 downto 0) & '0';
                 data_1out   <= out_data_3(3);
                 data_2out   <= out_data_4(3);
                 data_3out   <= out_data_1(3);
                 data_4out   <= out_data_2(3);
            when s_3 =>
                 next_data_1 <= out_data_4(2 downto 0) & '0';
                 next_data_2 <= out_data_1(2 downto 0) & '0';
                 next_data_3 <= out_data_2(2 downto 0) & '0';
                 next_data_4 <= out_data_3(2 downto 0) & '0';
                 data_1out   <= out_data_4(3);
                 data_2out   <= out_data_1(3);
                 data_3out   <= out_data_2(3);
                 data_4out   <= out_data_3(3);     
             when others => 
                 next_data_1 <= (others => 'X');
                 next_data_2 <= (others => 'U');
                 next_data_3 <= (others => 'X');
                 next_data_4 <= (others => 'X');
                 data_1out   <= 'X';
                 data_2out   <= 'X';
                 data_3out   <= 'X';
                 data_4out   <= 'X';
        end case;
    else
            next_data_1 <= current_data_1(2 downto 0) & '0';
            next_data_2 <= current_data_2(2 downto 0) & '0';
            next_data_3 <= current_data_3(2 downto 0) & '0';
            next_data_4 <= current_data_4(2 downto 0) & '0';     
            data_1out   <= current_data_1(3);
            data_2out   <= current_data_2(3);
            data_3out   <= current_data_3(3);
            data_4out   <= current_data_4(3);
--        case current_state is 
--         when s_0 =>
--             next_data_1 <= current_data_1(2 downto 0) & '0';
--             next_data_2 <= current_data_2(2 downto 0) & '0';
--             next_data_3 <= current_data_3(2 downto 0) & '0';
--             next_data_4 <= current_data_4(2 downto 0) & '0';
--             data_1out   <= current_data_1(3);
--             data_2out   <= current_data_2(3);
--             data_3out   <= current_data_3(3);
--             data_4out   <= current_data_4(3);
--         when s_1 =>
--             next_data_1 <= current_data_2(2 downto 0) & '0';
--             next_data_2 <= current_data_3(2 downto 0) & '0';
--             next_data_3 <= current_data_4(2 downto 0) & '0';
--             next_data_4 <= current_data_1(2 downto 0) & '0';
--             data_1out   <= current_data_2(3);
--             data_2out   <= current_data_3(3);
--             data_3out   <= current_data_4(3);
--             data_4out   <= current_data_1(3);
--         when s_2 =>
--              next_data_1 <= current_data_3(2 downto 0) & '0';
--              next_data_2 <= current_data_4(2 downto 0) & '0';
--              next_data_3 <= current_data_1(2 downto 0) & '0';
--              next_data_4 <= current_data_2(2 downto 0) & '0';
--              data_1out   <= current_data_3(3);
--              data_2out   <= current_data_4(3);
--              data_3out   <= current_data_1(3);
--              data_4out   <= current_data_2(3);
--         when s_3 =>
--              next_data_1 <= current_data_4(2 downto 0) & '0';
--              next_data_2 <= current_data_1(2 downto 0) & '0';
--              next_data_3 <= current_data_2(2 downto 0) & '0';
--              next_data_4 <= current_data_3(2 downto 0) & '0';
--              data_1out   <= current_data_4(3);
--              data_2out   <= current_data_1(3);
--              data_3out   <= current_data_2(3);
--              data_4out   <= current_data_3(3);     
--          when others => 
--              next_data_1 <= (others => 'X');
--              next_data_2 <= (others => 'U');
--              next_data_3 <= (others => 'X');
--              next_data_4 <= (others => 'X');
--              data_1out   <= 'X';
--              data_2out   <= 'X';
--              data_3out   <= 'X';
--              data_4out   <= 'X';
--     end case;         
    end if;

end process;

end Behavioral;
