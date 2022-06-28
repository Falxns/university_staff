--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:37:12 10/20/2021
-- Design Name:   
-- Module Name:   C:/Users/maksf/Desktop/POCP/Lab2/Lab2/TB_decoder.vhd
-- Project Name:  Lab2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: decoder
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
 
ENTITY TB_decoder IS
END TB_decoder;
 
ARCHITECTURE behavior OF TB_decoder IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT decoder
    PORT(
         a1 : IN  std_logic;
         a2 : IN  std_logic;
         x : IN  std_logic;
         o1 : OUT  std_logic;
         o2 : OUT  std_logic;
         o3 : OUT  std_logic;
         o4 : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal a1 : std_logic := '0';
   signal a2 : std_logic := '0';
   signal x : std_logic := '0';
	
	signal o1_behavior : std_logic;
	signal o2_behavior : std_logic;
	signal o3_behavior : std_logic;
	signal o4_behavior : std_logic;
   signal o1_struct : std_logic;
	signal o2_struct : std_logic;
	signal o3_struct : std_logic;
	signal o4_struct : std_logic;
	
	signal err: std_logic;
	
	signal test: std_logic_vector (2 downto 0);

 	--Outputs
   signal o1 : std_logic;
   signal o2 : std_logic;
   signal o3 : std_logic;
   signal o4 : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant period : time := 10 ns;
 
BEGIN

	a1<=test(0);
	a2<=test(1);
	x<=test(2);
 
	-- Instantiate the Unit Under Test (UUT)
   u_behavior: entity  work.decoder(behavioral) PORT MAP (
          a1 => a1,
          a2 => a2,
          x => x,
          o1 => o1_behavior,
          o2 => o2_behavior,
          o3 => o3_behavior,
          o4 => o4_behavior
        );
		  
	u_struct: entity  work.decoder(struct) PORT MAP (
          a1 => a1,
          a2 => a2,
          x => x,
          o1 => o1_struct,
          o2 => o2_struct,
          o3 => o3_struct,
          o4 => o4_struct
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

	err<= (o1_behavior XOR o1_struct) OR (o2_behavior XOR o2_struct) OR (o3_behavior XOR o3_struct) OR (o4_behavior XOR o4_struct);

END;
