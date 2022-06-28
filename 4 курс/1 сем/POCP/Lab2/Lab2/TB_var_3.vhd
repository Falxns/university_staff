--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:33:27 10/20/2021
-- Design Name:   
-- Module Name:   C:/Users/maksf/Desktop/POCP/Lab2/Lab2/TB_var_3.vhd
-- Project Name:  Lab2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: var_3
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
 
ENTITY TB_var_3 IS
END TB_var_3;
 
ARCHITECTURE behavior OF TB_var_3 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT var_3
    PORT(
         x : IN  std_logic;
         y : IN  std_logic;
         z : IN  std_logic;
         f : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal x : std_logic := '0';
   signal y : std_logic := '0';
   signal z : std_logic := '0';

	signal f_behavior : std_logic;
   signal f_struct : std_logic;

	signal err: std_logic;
	
	signal test: std_logic_vector (2 downto 0);
	
 	--Outputs
   signal f : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant period : time := 10 ns;
 
BEGIN
	x<=test(0);
	y<=test(1);
	z<=test(2);
 
	-- Instantiate the Unit Under Test (UUT)
   u_behavior: entity work.var_3(behavioral) PORT MAP (
          x => x,
          y => y,
          z => z,
          f => f_behavior
        );
		  
	u_struct: entity work.var_3(struct) PORT MAP (
          x => x,
          y => y,
          z => z,
          f => f_struct
        );

   -- Stimulus process
   stim_proc: process
   begin		
      for i in 0 to 7 loop
			test <= std_logic_vector(to_unsigned(i, test'length)); 
			wait for period;
		end loop;
  
		report "End of simulation" severity failure;

      wait;
   end process;
	
	err<= f_behavior XOR f_struct;

END;
