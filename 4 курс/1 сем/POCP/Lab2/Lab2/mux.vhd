----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:15:13 10/18/2021 
-- Design Name: 
-- Module Name:    mux - behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux is
    Port ( a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           s : in  STD_LOGIC;
           z : out  STD_LOGIC);
end mux;

architecture behavioral of mux is

begin
z<= a when s='0' else b;

end behavioral;

architecture struct of mux is
component and_2 is
 Port ( a : in  STD_LOGIC;
		  b : in  STD_LOGIC;
		  res : out  STD_LOGIC);
end component;

component or_2 is
 Port ( a : in  STD_LOGIC;
		  b : in  STD_LOGIC;
		  res : out  STD_LOGIC);
end component;

component not_1 is
 Port ( a : in  STD_LOGIC;
		  na : out  STD_LOGIC);
end component;

signal x: std_logic;
signal y: std_logic;
signal n: std_logic;

begin
u1: not_1 port map (s, n);
u2: and_2 port map (a, n, x);
u3: and_2 port map (b, s, y);
u4: or_2 port map (x, y, z);

end struct;


