----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/04/2024 04:46:26 PM
-- Design Name: 
-- Module Name: timer - Behavioral
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

entity timer is
    Port ( 
    s_clock_out : in std_logic;
    sw : in std_logic_vector(3 downto 0);
    reset_timer : in std_logic;
    start : in std_logic;
    alarm_led : out std_logic
    );
end timer;

architecture Behavioral of timer is
constant second_counter_max : integer := 60;
signal minute_counter_max : unsigned(3 downto 0) := (others => '0');
signal second_counter : unsigned(5 downto 0) := (others => '0');
signal minute_counter : unsigned(3 downto 0) := (others => '0');
signal alarm_buff : std_logic := '0';
signal timer_state : std_logic_vector(1 downto 0) := (others => '0');
--waiting, active, paused, finished (00 01 10 11)
signal time_set_buffer : std_logic_vector(3 downto 1) := (others => '0');

begin

timer : process(s_clock_out)
begin
if timer_state = "00" or timer_state = "11" then
second_counter <= (others => '0');
minute_counter <= (others => '0');
end if;

if timer_state = "01" then
if rising_edge(s_clock_out) then
if second_counter = second_counter_max then
second_counter <= (others => '0');
if minute_counter = minute_counter_max then
minute_counter <= (others => '0');
end if;
end if;
end if;
end process;


states : process(start, reset_timer)
begin
if timer_state = "01" and minute_counter = minute_counter_max then
timer_state <= "11";
end if;

if rising_edge(reset_timer) then
timer_state <= "00";
end if;
if rising_edge(start) then
if timer_state = "00" then
timer_state <= "01";
elsif timer_state = "01" then
timer_state <= "10";
elsif timer_state = "10" then
timer_state <= "01";
else
timer_state <= "10";
end if;
end if;
end process;

end Behavioral;
