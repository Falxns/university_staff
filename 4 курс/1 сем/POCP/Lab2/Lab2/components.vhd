----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:33:47 10/18/2021 
-- Design Name: 
-- Module Name:    components - behavioral 
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

entity not_1 is
    Port ( a : in  STD_LOGIC;
           na : out  STD_LOGIC);
end not_1;

architecture behavioral of not_1 is

begin

na<= NOT(a);

end behavioral;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity and_2 is
    Port ( a : in  STD_LOGIC;
			  b: in  STD_LOGIC;
           res : out  STD_LOGIC);
end and_2;

architecture behavioral of and_2 is

begin

res <= a AND b;

end behavioral;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity or_2 is
    Port ( a : in  STD_LOGIC;
			  b: in  STD_LOGIC;
           res : out  STD_LOGIC);
end or_2;

architecture behavioral of or_2 is

begin

res <= a OR b;

end behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity xor_2 is
    Port ( a : in  STD_LOGIC;
			  b: in  STD_LOGIC;
           res : out  STD_LOGIC);
end xor_2;

architecture behavioral of xor_2 is

begin

res <= a XOR b;

end behavioral;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity and_3 is
    Port ( a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           c : in  STD_LOGIC;
           res : out  STD_LOGIC);
end and_3;

architecture behavioral of and_3 is

begin

res<= ((a AND b) AND c);

end behavioral;

architecture struct of and_3 is

component and_2 is
 Port ( a : in  STD_LOGIC;
		  b : in  STD_LOGIC;
		  res : out  STD_LOGIC);
end component;

signal buff: std_logic;

begin

u1: and_2 port map (a, b, buff);
u2: and_2 port map (c, buff, res);

end struct;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity or_3 is
    Port ( a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           c : in  STD_LOGIC;
           res : out  STD_LOGIC);
end or_3;

architecture behavioral of or_3 is

begin

res<= ((a OR b) OR c);

end behavioral;

architecture struct of or_3 is

component or_2 is
 Port ( a : in  STD_LOGIC;
		  b : in  STD_LOGIC;
		  res : out  STD_LOGIC);
end component;

signal buff: STD_LOGIC;

begin

u1: or_2 port map (a, b, buff);
u2: or_2 port map (c, buff, res);

end struct;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sum_1 is
    Port ( a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           p0 : in  STD_LOGIC;
           res : out  STD_LOGIC;
			  p: out STD_LOGIC);
end sum_1;

architecture behavioral of sum_1 is

begin

res<= (a XOR b) XOR p0;
p<= (a AND b) OR (a AND p0) OR (b AND p0);

end behavioral;

architecture struct of sum_1 is

component xor_2 is
 Port (a : in STD_LOGIC;
		 b : in STD_LOGIC;
		 res : out STD_LOGIC);
end component;

component and_2 is
 Port (a : in STD_LOGIC;
		 b : in STD_LOGIC;
		 res : out STD_LOGIC);
end component;

component or_2 is
 Port (a : in STD_LOGIC;
		 b : in STD_LOGIC;
		 res : out STD_LOGIC);
end component;

signal buff_1: STD_LOGIC;
signal buff_2: STD_LOGIC;
signal buff_3: STD_LOGIC;
signal buff_4: STD_LOGIC;
signal buff_5: STD_LOGIC;

begin

u1: xor_2 port map(a, b, buff_1);
u2: xor_2 port map(buff_1, p0, res);
u3: and_2 port map (a, b, buff_2);
u4: and_2 port map (a, p0, buff_3);
u5: and_2 port map (b, p0, buff_4);
u6: or_2 port map (buff_2, buff_3, buff_5);
u7: or_2 port map (buff_5, buff_4, p);

end struct;