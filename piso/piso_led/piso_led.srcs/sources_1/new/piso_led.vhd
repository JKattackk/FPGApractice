----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/31/2024 06:46:17 PM
-- Design Name: 
-- Module Name: piso_led - Behavioral
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

entity piso_led is
generic
(
bits : integer := 4
);

Port(
--clk : in std_logic;
load : in boolean;
shift_clock : in std_logic;
led_serial_output : out std_logic;
--full_indicator : out std_logic;
--empty_indicator : out std_logic;
sw : in std_logic_vector(3 downto 0)
);

end piso_led;

architecture Behavioral of piso_led is
--signal count_reg : unsigned(bits -1 downto 0) := (others => '0');
signal shift_buff : unsigned(bits -1 downto 0) := "0000";
signal serial_out : std_logic := '0';

begin
led_serial_output <= serial_out;

process (shift_clock, load)
begin
if (load) then
shift_buff <= unsigned(sw);
elsif rising_edge(shift_clock) then
serial_out <= shift_buff(0);
shift_buff <= shift_right(shift_buff, 1);
end if;
end process;

end Behavioral;
