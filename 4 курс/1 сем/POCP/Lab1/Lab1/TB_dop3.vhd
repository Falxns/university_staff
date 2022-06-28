--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:31:41 10/17/2021
-- Design Name:   
-- Module Name:   C:/Users/maksf/Desktop/POCP/Lab1/Lab1/TB_dop3.vhd
-- Project Name:  Lab1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: dop3
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model. 
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY TB_dop3 IS
END TB_dop3;
 
ARCHITECTURE behavioral OF TB_dop3 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT dop3SKNF
    PORT(
         i1 : IN  std_logic;
         i2 : IN  std_logic;
         i3 : IN  std_logic;
         o1 : OUT  std_logic
        );
    END COMPONENT;
	 
	 COMPONENT dop3SDNF
    PORT(
         i1 : IN  std_logic;
         i2 : IN  std_logic;
         i3 : IN  std_logic;
         o1 : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal i1 : std_logic := '0';
   signal i2 : std_logic := '0';
   signal i3 : std_logic := '0';
	
	signal o1_SKNF : std_logic;
   signal o1_SDNF:  std_logic;
	
	signal err: std_logic;
	signal test_vector: std_logic_vector (2 downto 0);

 	--Outputs
   signal o1 : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
	
	constant period : time := 10 ns;
	
BEGIN
 
	i1<=test_vector(0);
	i2<=test_vector(1);
	i3<=test_vector(2);
	-- Instantiate the Unit Under Test (UUT)
   uut1: dop3SKNF PORT MAP (
          i1 => i1,
          i2 => i2,
          i3 => i3,
          o1 => o1_SKNF
        );
		  
	uut2: dop3SDNF PORT MAP (
          i1 => i1,
          i2 => i2,
          i3 => i3,
          o1 => o1_SDNF
        );

   -- Clock process definitions

   -- Stimulus process
   stim_proc: process
   begin		
      for i in 0 to 7 loop
       test_vector <= std_logic_vector(to_unsigned(i, test_vector'length)); 
      wait for period;
		end loop;
	  
	  report "End of simulation" severity failure;
   end process;

	err<=o1_SKNF xor o1_SDNF;
END;
