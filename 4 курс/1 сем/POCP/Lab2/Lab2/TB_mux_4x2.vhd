--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:48:10 10/20/2021
-- Design Name:   
-- Module Name:   C:/Users/maksf/Desktop/POCP/Lab2/Lab2/TB_mux_4x2.vhd
-- Project Name:  Lab2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: mux_4x2
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
 
ENTITY TB_mux_4x2 IS
END TB_mux_4x2;
 
ARCHITECTURE behavior OF TB_mux_4x2 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT mux_4x2
    PORT(
         a : IN  std_logic;
         b : IN  std_logic;
         a1 : IN  std_logic;
         b1 : IN  std_logic;
         s : IN  std_logic;
         z : OUT  std_logic;
         z1 : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic := '0';
   signal b : std_logic := '0';
   signal a1 : std_logic := '0';
   signal b1 : std_logic := '0';
   signal s : std_logic := '0';
	
	signal z_behavior : std_logic;
	signal z1_behavior : std_logic;
   signal z_struct : std_logic;
   signal z1_struct : std_logic;

	signal err: std_logic;
	
	signal test: std_logic_vector (4 downto 0);

 	--Outputs
   signal z : std_logic;
   signal z1 : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant period : time := 10 ns;
 
BEGIN
	a<=test(0);
	b<=test(1);
	a1<=test(2);
	b1<=test(3);
	s<=test(4);
 
	-- Instantiate the Unit Under Test (UUT)
   u_behavior: entity work.mux_4x2(behavioral) PORT MAP (
          a => a,
          b => b,
          a1 => a1,
          b1 => b1,
          s => s,
          z => z_behavior,
          z1 => z1_behavior
        );
		  
	u_struct: entity work.mux_4x2(struct) PORT MAP (
          a => a,
          b => b,
          a1 => a1,
          b1 => b1,
          s => s,
          z => z_struct,
          z1 => z1_struct
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
	
	err<= (z_behavior XOR z_struct) OR (z1_behavior XOR z1_struct);

END;
