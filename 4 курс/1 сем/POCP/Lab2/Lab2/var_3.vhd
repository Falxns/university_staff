----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:44:51 10/18/2021 
-- Design Name: 
-- Module Name:    var_3 - behavioral 
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

entity var_3 is
    Port ( x : in  STD_LOGIC;
           y : in  STD_LOGIC;
           z : in  STD_LOGIC;
           f : out  STD_LOGIC);
end var_3;

architecture behavioral of var_3 is

begin

f<= (x OR (NOT(y)) OR (NOT(z))) AND (NOT(x) OR z) AND (y OR z);

end behavioral;

architecture struct of var_3 is

component and_3 is
 Port ( a : in  STD_LOGIC;
		  b : in  STD_LOGIC;
		  c : in  STD_LOGIC;
		  res : out  STD_LOGIC);
end component;

component or_3 is
 Port ( a : in  STD_LOGIC;
		  b : in  STD_LOGIC;
		  c : in  STD_LOGIC;
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

signal nx: std_logic;
signal ny: std_logic;
signal nz: std_logic;
signal buff_1: std_logic;
signal buff_2: std_logic;
signal buff_3: std_logic;

begin
u1: not_1 port map (x, nx);
u2: not_1 port map (y, ny);
u3: not_1 port map (z, nz);
u4: or_3 port map (x, ny, nz, buff_1);
u5: or_2 port map (nx, z, buff_2);
u6: or_2 port map (y, z, buff_3);
u7: and_3 port map (buff_1, buff_2, buff_3, f);

end Struct;

