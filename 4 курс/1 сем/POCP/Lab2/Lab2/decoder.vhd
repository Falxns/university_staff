----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:08:44 10/20/2021 
-- Design Name: 
-- Module Name:    decoder - behavioral 
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

entity decoder is
    Port ( a1 : in  STD_LOGIC;
           a2 : in  STD_LOGIC;
           x : in  STD_LOGIC;
           o1 : out  STD_LOGIC;
           o2 : out  STD_LOGIC;
           o3 : out  STD_LOGIC;
           o4 : out  STD_LOGIC);
end decoder;

architecture behavioral of decoder is

begin

o1<= NOT(NOT(a1) AND NOT(a2) AND NOT(x));
o2<= NOT(NOT(a1) AND a2 AND NOT(x));
o3<= NOT(a1 AND NOT(a2) AND NOT(x));
o4<= NOT(a1 AND a2 AND NOT(x));

end behavioral;

architecture struct of decoder is

component and_3 is
 Port ( a : in  STD_LOGIC;
		  b : in  STD_LOGIC;
		  c : in  STD_LOGIC;
		  res : out  STD_LOGIC);
end component;

component not_1 is
 Port ( a : in  STD_LOGIC;
		  na : out  STD_LOGIC);
end component;

signal na1: std_logic;
signal na2: std_logic;
signal nx: std_logic;
signal no1: std_logic;
signal no2: std_logic;
signal no3: std_logic;
signal no4: std_logic;

begin

u1: not_1 port map (a1, na1); 
u2: not_1 port map (a2, na2);
u3: not_1 port map (x, nx);
u4: and_3 port map (na1, na2, nx, no1);
u5: not_1 port map (no1, o1);
u6: and_3 port map (na1, a2, nx, no2);
u7: not_1 port map (no2, o2);
u8: and_3 port map (a1, na2, nx, no3);
u9: not_1 port map (no3, o3);
u10: and_3 port map (a1, a2, nx, no4);
u11: not_1 port map (no4, o4);

end struct;

