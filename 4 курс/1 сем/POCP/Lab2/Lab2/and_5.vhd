----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:15:11 10/19/2021 
-- Design Name: 
-- Module Name:    and_5 - behavioral 
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

entity and_5 is
    Port ( a : in  STD_LOGIC_VECTOR(4 downto 0);
           res : out  STD_LOGIC);
end and_5;

architecture behavioral of and_5 is

begin

res<= a(0) AND a(1) AND a(2) AND a(3) AND a(4);

end behavioral;

architecture struct of and_5 is
component and_2 is
	 Port ( a : in  STD_LOGIC;
			  b : in  STD_LOGIC;
			  res : out  STD_LOGIC);
end component;
	
signal z: STD_LOGIC_VECTOR(3 downto 0);
	
begin

u1: and_2 port map (a(0), a(1), z(0));
generator:
for i in 0 to 2 generate
	u2: and_2 port map (a(i + 2), z(i), z(i+1));
end generate generator;

res<=z(3);

end struct;



