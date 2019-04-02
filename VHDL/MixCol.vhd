----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:09:25 02/14/2019 
-- Design Name: 
-- Module Name:    MixCol - Behavioral 
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

entity MixCol is
    Port ( in_data      : in  STD_LOGIC_VECTOR (127 downto 0);
           out_data     : out STD_LOGIC_VECTOR (127 downto 0);
			  SEL          : in  STD_LOGIC;
           encode       : in  STD_LOGIC;
           clk          : in  STD_LOGIC;
           reset        : in  STD_LOGIC);
end MixCol;

architecture Behavioral of MixCol is

--component XTime is
--    Port ( input  : in  STD_LOGIC_VECTOR (7 downto 0);
--           output : in  STD_LOGIC_VECTOR (7 downto 0));
--end component;
component MixEachCol 
	port (encode, clk, reset     : in STD_LOGIC;
			SEL                    : in STD_LOGIC := '1';
			in0, in1, in2, in3     : in STD_LOGIC_VECTOR(7 downto 0);
			out0, out1, out2, out3 : out STD_LOGIC_VECTOR(7 downto 0));
end component;

	-- Block Arrangement
	-- byte0  byte1  byte2  byte3
	-- byte4  byte5  byte6  byte7
	-- byte8	 byte9  byte10 byte11
	-- byte12 byte13 byte14 byte15
	
	-- byte0  byte4  byte8  byte12
	-- byte1	 byte5  byte9  byte13
	-- byte2  byte6  byte10 byte14
	-- byte3  byte7  byte11 byte15
	
	
	-- All input bytes of the message 
	signal in_byte0  : STD_LOGIC_VECTOR (7 downto 0);
	signal in_byte1  : STD_LOGIC_VECTOR (7 downto 0);
	signal in_byte2  : STD_LOGIC_VECTOR (7 downto 0);
	signal in_byte3  : STD_LOGIC_VECTOR (7 downto 0);
	signal in_byte4  : STD_LOGIC_VECTOR (7 downto 0);
	signal in_byte5  : STD_LOGIC_VECTOR (7 downto 0);
	signal in_byte6  : STD_LOGIC_VECTOR (7 downto 0);
	signal in_byte7  : STD_LOGIC_VECTOR (7 downto 0);
	signal in_byte8  : STD_LOGIC_VECTOR (7 downto 0);
	signal in_byte9  : STD_LOGIC_VECTOR (7 downto 0);
	signal in_byte10 : STD_LOGIC_VECTOR (7 downto 0);
	signal in_byte11 : STD_LOGIC_VECTOR (7 downto 0);
	signal in_byte12 : STD_LOGIC_VECTOR (7 downto 0);
	signal in_byte13 : STD_LOGIC_VECTOR (7 downto 0);
	signal in_byte14 : STD_LOGIC_VECTOR (7 downto 0);
	signal in_byte15 : STD_LOGIC_VECTOR (7 downto 0);

	-- All out bytes of the message 
	signal out_byte0  : STD_LOGIC_VECTOR (7 downto 0);
	signal out_byte1  : STD_LOGIC_VECTOR (7 downto 0);
	signal out_byte2  : STD_LOGIC_VECTOR (7 downto 0);
	signal out_byte3  : STD_LOGIC_VECTOR (7 downto 0);
	signal out_byte4  : STD_LOGIC_VECTOR (7 downto 0);
	signal out_byte5  : STD_LOGIC_VECTOR (7 downto 0);
	signal out_byte6  : STD_LOGIC_VECTOR (7 downto 0);
	signal out_byte7  : STD_LOGIC_VECTOR (7 downto 0);
	signal out_byte8  : STD_LOGIC_VECTOR (7 downto 0);
	signal out_byte9  : STD_LOGIC_VECTOR (7 downto 0);
	signal out_byte10 : STD_LOGIC_VECTOR (7 downto 0);
	signal out_byte11 : STD_LOGIC_VECTOR (7 downto 0);
	signal out_byte12 : STD_LOGIC_VECTOR (7 downto 0);
	signal out_byte13 : STD_LOGIC_VECTOR (7 downto 0);
	signal out_byte14 : STD_LOGIC_VECTOR (7 downto 0);
	signal out_byte15 : STD_LOGIC_VECTOR (7 downto 0);
	
begin
	
	-- Assign input bus into separate bytes
	in_byte15 <= in_data(7 downto 0);
	in_byte14 <= in_data(15 downto 8);
	in_byte13 <= in_data(23 downto 16);
	in_byte12 <= in_data(31 downto 24);
	in_byte11 <= in_data(39 downto 32);
	in_byte10 <= in_data(47 downto 40);
	in_byte9 <= in_data(55 downto 48);
	in_byte8 <= in_data(63 downto 56);
	in_byte7 <= in_data(71 downto 64);
	in_byte6 <= in_data(79 downto 72);
	in_byte5 <= in_data(87 downto 80);
	in_byte4 <= in_data(95 downto 88);
	in_byte3 <= in_data(103 downto 96);
	in_byte2 <= in_data(111 downto 104);
	in_byte1 <= in_data(119 downto 112);
	in_byte0 <= in_data(127 downto 120); 
	
	-- Assign input bus into separate bytes
	out_data(7 downto 0) <= out_byte15(7 downto 0);
	out_data(15 downto 8) <= out_byte14(7 downto 0);
	out_data(23 downto 16) <= out_byte13(7 downto 0);
	out_data(31 downto 24) <= out_byte12(7 downto 0);
	out_data(39 downto 32) <= out_byte11(7 downto 0);
	out_data(47 downto 40) <= out_byte10(7 downto 0);
	out_data(55 downto 48) <= out_byte9(7 downto 0);
	out_data(63 downto 56) <= out_byte8(7 downto 0);
	out_data(71 downto 64) <= out_byte7(7 downto 0);
	out_data(79 downto 72) <= out_byte6(7 downto 0);
	out_data(87 downto 80) <= out_byte5(7 downto 0);
	out_data(95 downto 88) <= out_byte4(7 downto 0);
	out_data(103 downto 96) <= out_byte3(7 downto 0);
	out_data(111 downto 104) <= out_byte2(7 downto 0);
	out_data(119 downto 112) <= out_byte1(7 downto 0);
	out_data(127 downto 120) <= out_byte0(7 downto 0);
	

	col1: MixEachCol port map (encode, clk, reset, SEL, in_byte0, in_byte1, in_byte2, in_byte3, out_byte0, out_byte1, out_byte2, out_byte3);
	col2: MixEachCol port map (encode, clk, reset, SEL, in_byte4, in_byte5, in_byte6, in_byte7, out_byte4, out_byte5, out_byte6, out_byte7);
	col3: MixEachCol port map (encode, clk, reset, SEL, in_byte8, in_byte9, in_byte10, in_byte11, out_byte8, out_byte9, out_byte10, out_byte11);
	col4: MixEachCol port map (encode, clk, reset, SEL, in_byte12, in_byte13, in_byte14, in_byte15, out_byte12, out_byte13, out_byte14, out_byte15);

--	process(reset)
--	begin
--		if reset = '0' then
--		-- Reset the output data.
--			out_data <= (others => '0');
--		end if;
--	end process;

end Behavioral;

