----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/31/2024 02:05:21 PM
-- Design Name: 
-- Module Name: main - Behavioral
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

entity main is
generic
(
num_led : integer := 4;
num_sw : integer := 4;
clockrate : integer := 10000000;
blink : integer := 2);
port
(
clk : in std_logic;
led : out std_logic_vector(num_led -1 downto 0);
sw : in std_logic_vector(num_sw -1 downto 0)
);

end main;

architecture Behavioral of main is

constant maxer : integer := clockrate/blink;
constant bit_depth : integer := integer(ceil(log2(real(maxer))));
signal count_reg : unsigned(bit_depth -1 downto 0) := (others => '0');

signal blink_state : std_logic_vector(num_led -1 downto 0) := "0000";
signal led_reg : std_logic_vector(num_led -1 downto 0) := "0000";


begin
led_reg <= blink_state AND sw;
led <= led_reg;

asdf : process(clk)
begin
if (rising_edge(clk)) then
if (count_reg = maxer) then
count_reg <= (others => '0');
else count_reg <= count_reg +1;
end if;
end if;
end process;

awwe : process(clk)
begin
if(rising_edge(clk)) then
if(count_reg = maxer) then
blink_state <= not blink_state;
end if;
end if;
end process;

end Behavioral;



