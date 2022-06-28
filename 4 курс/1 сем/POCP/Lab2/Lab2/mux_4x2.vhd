----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:19:15 10/18/2021 
-- Design Name: 
-- Module Name:    mux_4x2 - behavioral 
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

entity mux_4x2 is
    Port ( a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           a1 : in  STD_LOGIC;
           b1 : in  STD_LOGIC;
           s : in  STD_LOGIC;
           z : out  STD_LOGIC;
           z1 : out  STD_LOGIC);
end mux_4x2;

architecture behavioral of mux_4x2 is

begin

z<= a when s='0' else b;
z1<= a1 when s='0' else b1;

end behavioral;

architecture struct of mux_4x2 is
component mux is
 Port ( a : in  STD_LOGIC;
		  b : in  STD_LOGIC;
		  s : in  STD_LOGIC;
		  z : out  STD_LOGIC);
end component;

begin
u1: mux port map (a, b, s, z);
u2: mux port map (a1, b1, s, z1);

end struct;

