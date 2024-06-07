----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/01/2024 01:05:42 PM
-- Design Name: 
-- Module Name: s_clock - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity s_clock is
port(
clk : in std_logic;
timer_led : out std_logic
);
end s_clock;

architecture Behavioral of s_clock is
constant timer_max : integer := 50000000;
signal timer_count : unsigned(26 downto 0) := (others => '0');
signal led_buff : std_logic := '0';

begin
timer_led <= led_buff;
--s_clock_out <= led_buff;

asdf : process(clk)
begin
if (rising_edge(clk)) then
if(timer_count = timer_max) then
timer_count <= (others => '0');
else
timer_count <= timer_count + 1;
end if;
end if;
end process;

awwe : process(clk)
begin
if(rising_edge(clk)) then
if(timer_count = timer_max) then
led_buff <= not led_buff;
end if;
end if;
end process;

end Behavioral;