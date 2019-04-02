--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:09:40 02/18/2019
-- Design Name:   
-- Module Name:   U:/EEE6225_System_Design/MixCols/MixCol_tb.vhd
-- Project Name:  MixCols
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MixCol
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY MixCol_tb IS
END MixCol_tb;
 
ARCHITECTURE behavior OF MixCol_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MixCol
    PORT(
         in_data     : IN  std_logic_vector(127 downto 0);
         out_data    : OUT  std_logic_vector(127 downto 0);
         encode      : IN  std_logic;
         clk         : IN  std_logic;
         reset       : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal in_data    : std_logic_vector(127 downto 0) := (others => '0');
   signal encode     : std_logic := '0';
   signal clk        : std_logic := '0';
   signal reset      : std_logic := '0';

 	--Outputs
   signal out_data   : std_logic_vector(127 downto 0) := (others => '0');

   -- Clock period definitions
   constant clk_period : time := 15 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MixCol PORT MAP (
          in_data => in_data,
          out_data => out_data,
          encode => encode,
          clk => clk,
          reset => reset
        );
		  
	clk_stimulus: process
	begin
		clk <= '1';
		wait for clk_period/2;
		clk <= '0';
		wait for clk_period/2;
		
	end process clk_stimulus;

	data_stimulus: process
	begin
		wait for 10*clk_period;
		wait for 10*(clk_period - 2 ns);
		encode <= '1';
		in_data <= (x"1729D62A89602E24E3CE5A64889F9461");
		
		wait for 10*(clk_period - 2 ns);
		encode <= '0';
		in_data <= (x"A90EF792A31FD986AAEE3562446B874A");
		
	end process data_stimulus;
END;

-- Encrypt message
-- 17  89  E3  88
-- 29  60  CE  9F
-- D6  2E  5A  94
-- 2A  24  64  61

-- Decrypt message 
-- A9  A3  AA  44
-- 0E  1F  EE  6B
-- F7  D9  35  87
-- 92  86  62  4A 