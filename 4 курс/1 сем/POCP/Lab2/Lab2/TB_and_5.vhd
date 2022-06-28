--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:38:02 10/20/2021
-- Design Name:   
-- Module Name:   C:/Users/maksf/Desktop/POCP/Lab2/Lab2/TB_and_5.vhd
-- Project Name:  Lab2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: and_5
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
 
ENTITY TB_and_5 IS
END TB_and_5;
 
ARCHITECTURE behavior OF TB_and_5 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT and_5
    PORT(
         a : IN  std_logic_vector(4 downto 0);
         res : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic_vector(4 downto 0) := (others => '0');
	
	signal res_behavior : std_logic;
   signal res_struct:  std_logic;

	signal err: std_logic;
	
	signal test: std_logic_vector (4 downto 0);
 	--Outputs
   signal res : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant period : time := 10 ns;
 
BEGIN
 
	a<=test;
	-- Instantiate the Unit Under Test (UUT)
   u_behavior: entity work.and_5(behavioral) PORT MAP (
          a => a,
          res => res_behavior
        );
		  
	u_struct: entity work.and_5(struct) PORT MAP (
          a => a,
          res => res_struct
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      for i in 0 to 31 loop
       test <= std_logic_vector(to_unsigned(i, test'length)); 
      wait for period;
   end loop;
  
  report "End of simulation" severity failure;

      wait;
   end process;

	err<=res_behavior xor res_struct;

END;
