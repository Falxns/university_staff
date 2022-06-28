----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:11:46 10/19/2021 
-- Design Name: 
-- Module Name:    sum_2 - behavioral 
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

entity sum_2 is
    Port ( a0 : in  STD_LOGIC;
           b0 : in  STD_LOGIC;
           a1 : in  STD_LOGIC;
           b1 : in  STD_LOGIC;
			  p0 : in  STD_LOGIC;
           s0 : out  STD_LOGIC;
           s1 : out  STD_LOGIC;
           p : out  STD_LOGIC);
end sum_2;

architecture behavioral of sum_2 is

signal p_buff: STD_LOGIC;

begin

s0<=(a0 XOR b0) XOR p0;
p_buff<= (a0 AND b0) OR (a0 AND p0) OR (b0 AND p0);
s1<=(a1 XOR b1) XOR p_buff;
p<= (a1 AND b1) OR (a1 AND p_buff) OR (b1 AND p_buff);

end behavioral;

architecture struct of sum_2 is

component sum_1 is
 Port ( a : in  STD_LOGIC;
		  b : in  STD_LOGIC;
		  p0 : in STD_LOGIC;
		  res : out  STD_LOGIC;
		  p : out  STD_LOGIC);
end component;

signal p_buff: std_logic;

begin

u1: sum_1 port map (a0, b0, p0, s0, p_buff);
u2: sum_1 port map (a1, b1, p_buff, s1, p);

end struct;

