--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:57:57 10/20/2021
-- Design Name:   
-- Module Name:   C:/Users/maksf/Desktop/POCP/Lab2/Lab2/TB_sum_1.vhd
-- Project Name:  Lab2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: sum_1
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
 
ENTITY TB_sum_1 IS
END TB_sum_1;
 
ARCHITECTURE behavior OF TB_sum_1 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT sum_1
    PORT(
         a : IN  std_logic;
         b : IN  std_logic;
         p0 : IN  std_logic;
         res : OUT  std_logic;
         p : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic := '0';
   signal b : std_logic := '0';
   signal p0 : std_logic := '0';

	signal res_behavior : std_logic;
	signal p_behavior : std_logic;
   signal res_struct : std_logic;
   signal p_struct : std_logic;

	signal err: std_logic;
	
	signal test: std_logic_vector (2 downto 0);
	
 	--Outputs
   signal res : std_logic;
   signal p : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant period : time := 10 ns;
 
BEGIN
	a<=test(0);
	b<=test(1);
	p0<=test(2);
 
	-- Instantiate the Unit Under Test (UUT)
   u_behavior: entity work.sum_1(behavioral) PORT MAP (
          a => a,
          b => b,
          p0 => p0,
          res => res_behavior,
          p => p_behavior
        );
		  
	u_struct: entity work.sum_1(struct) PORT MAP (
          a => a,
          b => b,
          p0 => p0,
          res => res_struct,
          p => p_struct
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
	
	err<= (res_behavior XOR res_struct) OR (p_behavior XOR p_struct);

END;
