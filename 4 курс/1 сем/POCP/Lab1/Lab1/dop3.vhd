----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:14:33 10/17/2021 
-- Design Name: 
-- Module Name:    dop3 - behavioral 
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
entity dop3SKNF is
    Port ( i1 : in  STD_LOGIC;
           i2 : in  STD_LOGIC;
           i3 : in  STD_LOGIC;
           o1 : out  STD_LOGIC);
end dop3SKNF;

architecture behavioral of dop3SKNF is

begin
o1<= (i1 OR i2 OR i3) AND (i1 OR i2 OR NOT(i3)) AND (i1 OR NOT(i2) OR NOT(i3)) AND (NOT(i1) OR i2 OR i3);

end behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity dop3SDNF is
    Port ( i1 : in  STD_LOGIC;
           i2 : in  STD_LOGIC;
           i3 : in  STD_LOGIC;
           o1 : out  STD_LOGIC);
end dop3SDNF;

architecture behavioral of dop3SDNF is

begin
o1<= (i1 AND i2 AND i3) OR (i1 AND i2 AND NOT(i3)) OR (i1 AND NOT(i2) AND i3) OR (NOT(i1) AND i2 AND NOT(i3));

end behavioral;

