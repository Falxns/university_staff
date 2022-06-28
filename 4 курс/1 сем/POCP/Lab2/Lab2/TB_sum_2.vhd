--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:49:26 10/20/2021
-- Design Name:   
-- Module Name:   C:/Users/maksf/Desktop/POCP/Lab2/Lab2/TB_sum_2.vhd
-- Project Name:  Lab2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: sum_2
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
 
ENTITY TB_sum_2 IS
END TB_sum_2;
 
ARCHITECTURE behavior OF TB_sum_2 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT sum_2
    PORT(
         a0 : IN  std_logic;
         b0 : IN  std_logic;
         a1 : IN  std_logic;
         b1 : IN  std_logic;
         p0 : IN  std_logic;
         s0 : OUT  std_logic;
         s1 : OUT  std_logic;
         p : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal a0 : std_logic := '0';
   signal b0 : std_logic := '0';
   signal a1 : std_logic := '0';
   signal b1 : std_logic := '0';
   signal p0 : std_logic := '0';
	
	signal s0_behavior : std_logic;
	signal s1_behavior : std_logic;
	signal p_behavior : std_logic;
   signal s0_struct:  std_logic;
	signal s1_struct : std_logic;
	signal p_struct : std_logic;

	signal err: std_logic;
	
	signal test: std_logic_vector (4 downto 0);

 	--Outputs
   signal s0 : std_logic;
   signal s1 : std_logic;
   signal p : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant period : time := 10 ns;
 
BEGIN
 
	a0<=test(0);
	b0<=test(1);
	a1<=test(2);
	b1<=test(3);
	p0<=test(4);
	-- Instantiate the Unit Under Test (UUT)
   u_behavior: entity work.sum_2(behavioral)PORT MAP (
          a0 => a0,
          b0 => b0,
          a1 => a1,
          b1 => b1,
          p0 => p0,
          s0 => s0_behavior,
          s1 => s1_behavior,
          p => p_behavior
        );
		  
	u_struct: entity work.sum_2(struct)PORT MAP (
          a0 => a0,
          b0 => b0,
          a1 => a1,
          b1 => b1,
          p0 => p0,
          s0 => s0_struct,
          s1 => s1_struct,
          p => p_struct
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

	err<= (s0_behavior xor s0_struct) OR (s1_behavior xor s1_struct) OR (p_behavior xor p_struct);

END;
