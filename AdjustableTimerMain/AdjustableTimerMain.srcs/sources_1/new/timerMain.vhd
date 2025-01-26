----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/25/2025 10:56:01 AM
-- Design Name: 
-- Module Name: timerMain - Behavioral
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
use ieee.math_real.all;
----------------------------------------------------------------------------------

entity timerMain is
  Port (clk : in STD_LOGIC;
           --clockTest : out std_logic;
           sw : in std_logic_vector(3 downto 0);
           resettimer : in std_logic;
           start : in std_logic; 
           led : out std_logic_vector( 3 downto 0);
           stateLED : out std_logic_vector( 1 downto 0)
           );
end timerMain;

architecture Behavioral of timerMain is
signal timer_state : std_logic_vector(1 downto 0) := (others => '0');

constant timer_max : integer := 25000000 -1;

signal timer_count : unsigned(26 downto 0) := (others => '0');
signal second_count : unsigned(5 downto 0) := (others => '0');
signal minute_count : std_logic_vector(3 downto 0) := (others => '0');

signal s_clockBuf : std_logic := '0';
signal m_clockBuf : std_logic := '0';
signal led_buf : std_logic := '0';
signal max_time : std_logic_vector( 3 downto 0) := (others => '0');
signal alarm : std_logic := '0';

--signal clockEN : std_logic;
--signal clockCL : std_logic;

begin


states : process(start, resettimer, alarm)
begin
stateLED <= timer_state;
--clockEN <= timer_state(0) and (not timer_state(1));
--clockCL <= (not timer_state(0)) and (not timer_state(1));

--clockTest <= led_buf;

if resettimer = '1' then                                            
    timer_state <= "00";
elsif alarm = '1' then
    timer_state <= "11";
else
    if rising_edge(start) then
        case timer_state is            
            when "00" =>
                timer_state <= "01";
            when "01" =>
                timer_state <= "10";
            when "10" =>
                timer_state <= "01";
            when "11" =>
                timer_state <= "00";
            when others =>
                timer_state <= "00";
        end case;
    end if;
end if;
end process;

----------------------------------------------------------------------------------

counter : process(clk, timer_state)
begin
if (timer_state = "01") then
    if (rising_edge(clk)) then
        if(timer_count = timer_max) then
            timer_count <= (others => '0');
        else
            timer_count <= timer_count + 1;
        end if;
    end if;
elsif (timer_state = "00") then
    timer_count <= (others => '0');
end if;
end process;

s_output : process(clk)
begin
if( timer_state = "00") then
    s_clockBuf <= '0';
    elsif (timer_state = "01" ) then
        if(rising_edge(clk)) then
            if(timer_count = timer_max) then
                s_clockBuf <= not s_clockBuf;
        end if;
    end if;
end if;
end process;

----------------------------------------------------------------------------------

timer : process(timer_state)
begin
led <= max_time;

if( timer_state = "00") then
    max_time <= sw;
end if;

end process;

minuteClock : process(s_clockBuf)
begin
if( timer_state = "00") then
    second_count <= (others => '0');
elsif (timer_state = "01" ) then
    if (falling_edge(s_clockBuf)) then
        if(second_count = 59) then
            second_count <= (others => '0');
        else
            second_count <= second_count + 1;
        end if;
    end if;
end if;
end process;

m_output : process(s_clockBuf)
begin
if( timer_state = "00") then
    m_clockBuf <= '0';
elsif (timer_state = "01" ) then
    if(falling_edge(s_clockBuf)) then
        if(second_count = 59) then
            m_clockBuf <= not m_clockBuf;
        end if;
    end if;
end if;
end process;

minuteCount : process(m_clockBuf)
begin


if( timer_state = "00") then
    minute_count <= (others => '0');
    alarm <= '0';
elsif( timer_state = "01" ) then
    if (falling_edge(m_clockBuf)) then
        if (minute_count = std_logic_vector(unsigned(max_time)-1)) then
            alarm <= '1';
        else
            minute_count <= std_logic_vector(unsigned(minute_count) + 1);
        end if;
    end if;
end if;
end process;


end Behavioral;
