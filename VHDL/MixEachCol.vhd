----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:06:58 02/15/2019 
-- Design Name: 
-- Module Name:    MixEachCol - Behavioral 
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

entity MixEachCol is
    Port ( encode : in   STD_LOGIC;
			  clk    : in   STD_LOGIC;
			  reset  : in   STD_LOGIC;
			  SEL    : in   STD_LOGIC;
			  in0    : in   STD_LOGIC_VECTOR (7 downto 0);
           in1    : in   STD_LOGIC_VECTOR (7 downto 0);
           in2    : in   STD_LOGIC_VECTOR (7 downto 0);
           in3    : in   STD_LOGIC_VECTOR (7 downto 0);
           out0   : out  STD_LOGIC_VECTOR (7 downto 0);
           out1   : out  STD_LOGIC_VECTOR (7 downto 0);
           out2   : out  STD_LOGIC_VECTOR (7 downto 0);
           out3   : out  STD_LOGIC_VECTOR (7 downto 0) 
			  );
end MixEachCol;

architecture Behavioral of MixEachCol is

	-- Compute the constant multiplication of 2
	function f_X2 (X : STD_LOGIC_VECTOR(7 downto 0))
		return STD_LOGIC_VECTOR is 
			variable result   : STD_LOGIC_VECTOR(7 downto 0);
			variable tmp      : STD_LOGIC_VECTOR(8 downto 0);
			variable irr_poly : STD_LOGIC_VECTOR(8 downto 0) := "100011011";
	begin
		
		if X(7) = '1' then
		-- Px has a carry 
			tmp := (X & '0') xor irr_poly;
		else
			tmp := (X & '0');
		end if;
			
		result := tmp(7 downto 0);
		return result;
	end f_X2;
	
	-- Compute the constant multiplication of 4
	function f_X4 (X : STD_LOGIC_VECTOR (7 downto 0))
		return STD_LOGIC_VECTOR is
		variable result   : STD_LOGIC_VECTOR (7 downto 0) := "00000000";
		variable tmp      : STD_LOGIC_VECTOR (7 downto 0);
	begin
		tmp := f_X2(X);
		result := f_X2(tmp);
	return result;
	end f_X4;
	
--	-- Output signals
--	signal out_sig0  : STD_LOGIC_VECTOR (7 downto 0);
--	signal out_sig1  : STD_LOGIC_VECTOR (7 downto 0);
--	signal out_sig2  : STD_LOGIC_VECTOR (7 downto 0);
--	signal out_sig3  : STD_LOGIC_VECTOR (7 downto 0);

	signal reuse_blck0 : STD_LOGIC_VECTOR (7 downto 0);
	signal reuse_blck1 :	STD_LOGIC_VECTOR (7 downto 0);
	signal reuse_blck2 : STD_LOGIC_VECTOR (7 downto 0);
	signal reuse_blck3 : STD_LOGIC_VECTOR (7 downto 0);
	
begin
	
	-- Reusable block from Zhang paper.
	reuse_blck0 <= f_X2(in0 xor in1) xor (in1 xor (in2 xor in3));
	reuse_blck1 <= f_X2(in1 xor in2) xor (in2 xor (in3 xor in0));
 	reuse_blck2 <= f_X2(in2 xor in3) xor (in3 xor (in0 xor in1));
	reuse_blck3 <= f_X2(in3 xor in0) xor (in0 xor (in1 xor in2));
	
	process(clk, reset)
	begin
	-- Reset the module if reset = 1
	if reset = '1' then 
		out0 <= (others => '0');
		out1 <= (others => '0');
		out2 <= (others => '0');
		out3 <= (others => '0');
	
	-- Perform perform mix columns if SEL = 1
	elsif rising_edge(clk) and SEL = '1' then
		-- Encode if encode input = 1
		if encode = '1' then
			-- Encrypt!
			out0(7 downto 0) <= reuse_blck0;
			out1(7 downto 0) <= reuse_blck1;
			out2(7 downto 0) <= reuse_blck2;
			out3(7 downto 0) <= reuse_blck3;
		-- Decode if the encode input = 0
		elsif encode = '0' then
			-- Decrypt
			out0(7 downto 0) <= reuse_blck0 xor ((f_X4(in0 xor in2) xor (f_X2(f_X4(in0 xor in2) xor f_X4(in1 xor in3)))));
			out1(7 downto 0) <= reuse_blck1 xor ((f_X4(in1 xor in3) xor (f_X2(f_X4(in0 xor in2) xor f_X4(in1 xor in3)))));
			out2(7 downto 0) <= reuse_blck2 xor ((f_X4(in0 xor in2) xor (f_X2(f_X4(in0 xor in2) xor f_X4(in1 xor in3)))));
			out3(7 downto 0) <= reuse_blck3 xor ((f_X4(in1 xor in3) xor (f_X2(f_X4(in0 xor in2) xor f_X4(in1 xor in3)))));
		end if;
	-- If SEL ='0', bypass my module
	elsif rising_edge(clk) and SEL = '0' then
		out0 <= in0;
		out1 <= in1;
		out2 <= in2;
		out3 <= in3;
	end if;
   end process;

end Behavioral;

