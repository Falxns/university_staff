--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:13:12 10/20/2021
-- Design Name:   
-- Module Name:   TB_mux.vhd
-- Project Name:  Lab2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: mux
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
 
ENTITY TB_mux IS
END TB_mux;
 
ARCHITECTURE behavior OF TB_mux IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT mux
    PORT(
         a : IN  std_logic;
         b : IN  std_logic;
         s : IN  std_logic;
         z : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic := '0';
   signal b : std_logic := '0';
   signal s : std_logic := '0';

	signal z_behavior : std_logic;
   signal z_struct:  std_logic;
	
	signal err: std_logic;
	
	signal test: std_logic_vector (2 downto 0);
	
 	--Outputs
   signal z : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant period : time := 10 ns;
 
BEGIN
 
	a<=test(0);
	b<=test(1);
	s<=test(2);
	
   u_behavior: entity work.mux(behavioral) PORT MAP (
          a => a,
          b => b,
          s => s,
          z => z_behavior
        );
 
	u_struct: entity work.mux(struct) PORT MAP (
          a => a,
          b => b,
          s => s,
          z => z_struct
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

	err<=z_behavior xor z_struct;
END;
