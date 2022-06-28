----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:49:32 10/19/2021 
-- Design Name: 
-- Module Name:    demux_1x4 - behavioral 
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

entity demux_1x4 is
    Port ( f1 : in  STD_LOGIC;
           f2 : in  STD_LOGIC;
           inp : in  STD_LOGIC;
           o1 : out  STD_LOGIC;
           o2 : out  STD_LOGIC;
           o3 : out  STD_LOGIC;
           o4 : out  STD_LOGIC);
end demux_1x4;

architecture behavioral of demux_1x4 is

begin

o1<= NOT(f1) AND NOT(f2) AND inp;
o2<= f1 AND NOT(f2) AND inp;
o3<= NOT(f1) AND f2 AND inp;
o4<= f1 AND f2 AND inp;

end behavioral;

architecture struct of demux_1x4 is
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

signal nf1: std_logic;
signal nf2: std_logic;

begin

u1: not_1 port map (f1, nf1);
u2: not_1 port map (f2, nf2);
u3: and_3 port map (nf1, nf2, inp, o1);
u4: and_3 port map (f1, nf2, inp, o2);
u5: and_3 port map (nf1, f2, inp, o3);
u6: and_3 port map (f1, f2, inp, o4);

end struct;