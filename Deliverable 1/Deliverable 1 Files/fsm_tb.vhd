LIBRARY ieee;
USE ieee.STD_LOGIC_1164.all;

ENTITY fsm_tb IS
END fsm_tb;

ARCHITECTURE behaviour OF fsm_tb IS

COMPONENT comments_fsm IS
PORT (clk : in std_logic;
      reset : in std_logic;
      input : in std_logic_vector(7 downto 0);
      output : out std_logic
  );
END COMPONENT;

--The input signals with their initial values
SIGNAL clk, s_reset, s_output: STD_LOGIC := '0';
SIGNAL s_input: std_logic_vector(7 downto 0) := (others => '0');

CONSTANT clk_period : time := 1 ns;
CONSTANT SLASH_CHARACTER : std_logic_vector(7 downto 0) := "00101111";
CONSTANT STAR_CHARACTER : std_logic_vector(7 downto 0) := "00101010";
CONSTANT NEW_LINE_CHARACTER : std_logic_vector(7 downto 0) := "00001010";

BEGIN
dut: comments_fsm
PORT MAP(clk, s_reset, s_input, s_output);


 --clock process
clk_process : PROCESS
BEGIN
	clk <= '0';
	WAIT FOR clk_period/2;
	clk <= '1';
	WAIT FOR clk_period/2;
END PROCESS;
 
--TODO: Thoroughly test your FSM
stim_process: PROCESS
BEGIN    
	REPORT "Example case, reading a meaningless character";
	s_input <= "01011000";
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '0') REPORT "When reading a meaningless character, the output should be '0'" SEVERITY ERROR;
	REPORT "_______________________";


-- ~~~~~~~~~~~~~~~~~~~~~~~Potential loop to iterate through a string? ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--function test_string(str: string) return std_logic_vector is
--	variable ret : std_logic_vector(a'length*8-1 downto 0);
--begin
--	for ind in str'range loop
--		ret(ind*8+7 downto str*8) := std_logic_vector(to_unsigned(character'pos(str(i)),8));
--	end loop;
--	return ret;
--end function string_to_std_logic_vector;
	



	
	REPORT "___________Single Line Tests___________";
	
	REPORT "test 1: //c\n c";
	s_reset <= '1';
	WAIT FOR 1 * clk_period;
	s_reset <= '0';
	WAIT FOR 1 * clk_period;

	--/
	s_input <= SLASH_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '0') REPORT "When reading a SLASH_CHARACTER character, the output should be '0'" SEVERITY ERROR;
	
	-- /
	s_input <= SLASH_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '0') REPORT "When reading a SLASH_CHARACTER character, the output should be '0'" SEVERITY ERROR;

	-- c
	s_input <= "01100011";
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "When reading a C character, the output should be '1'" SEVERITY ERROR;


	-- \n
	s_input <= NEW_LINE_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "When reading a \n character, the output should be '1'" SEVERITY ERROR;


	-- space
	s_input <= "00100000";
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '0') REPORT "When reading a space character, the output should be '0'" SEVERITY ERROR;


	-- c
	s_input <= "01100011";
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '0') REPORT "When reading a c character, the output should be '0'" SEVERITY ERROR;



	REPORT "test 2: ///c\n c";
	s_reset <= '1';
	WAIT FOR 1 * clk_period;
	s_reset <= '0';
	WAIT FOR 1 * clk_period;

	--/
	s_input <= SLASH_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '0') REPORT "When reading a SLASH_CHARACTER character, the output should be '0'" SEVERITY ERROR;
	
	-- /
	s_input <= SLASH_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '0') REPORT "When reading a SLASH_CHARACTER character, the output should be '0'" SEVERITY ERROR;

	-- /
	s_input <= SLASH_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "When reading a SLASH_CHARACTER character, the output should be '1'" SEVERITY ERROR;


	-- c
	s_input <= "01100011";
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "When reading a c character, the output should be '1'" SEVERITY ERROR;

	-- \n
	s_input <= NEW_LINE_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "When reading a \n character, the output should be '1'" SEVERITY ERROR;

	-- space
	s_input <= "00100000";
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '0') REPORT "When reading a space character, the output should be '0'" SEVERITY ERROR;

	-- c
	s_input <= "01100011";
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '0') REPORT "When reading a c character, the output should be '0'" SEVERITY ERROR;




	REPORT "test 3: //**/c\n c";
	s_reset <= '1';
	WAIT FOR 1 * clk_period;
	s_reset <= '0';
	WAIT FOR 1 * clk_period;

		--/
	s_input <= SLASH_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '0') REPORT "When reading a SLASH_CHARACTER character, the output should be '0'" SEVERITY ERROR;
	
	-- /
	s_input <= SLASH_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '0') REPORT "When reading a SLASH_CHARACTER character, the output should be '0'" SEVERITY ERROR;


	-- *
	s_input <= STAR_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "When reading a * character, the output should be '1'" SEVERITY ERROR;

	-- *
	s_input <= STAR_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "When reading a * character, the output should be '1'" SEVERITY ERROR;

	-- /
	s_input <= SLASH_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "When reading a SLASH_CHARACTER character, the output should be '1'" SEVERITY ERROR;

	-- c
	s_input <= "01100011";
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "When reading a c character, the output should be '1'" SEVERITY ERROR;


	-- \n
	s_input <= NEW_LINE_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "When reading a \n character, the output should be '1'" SEVERITY ERROR;

	-- space
	s_input <= "00100000";
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '0') REPORT "When reading a space character, the output should be '0'" SEVERITY ERROR;

	-- c
	s_input <= "01100011";
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '0') REPORT "When reading a c character, the output should be '0'" SEVERITY ERROR;





	--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	REPORT "___________Multi - line Tests___________";

		
	REPORT "test 1: /*c*/c";
	s_reset <= '1';
	WAIT FOR 1 * clk_period;
	s_reset <= '0';
	WAIT FOR 1 * clk_period;
	-- /
	s_input <= SLASH_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '0') REPORT "When reading a SLASH_CHARACTER character, the output should be '0'" SEVERITY ERROR;

	-- *
	s_input <= STAR_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '0') REPORT "When reading a * character, the output should be '0'" SEVERITY ERROR;

	-- c
	s_input <= "01100011";
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "When reading a c character, the output should be '1'" SEVERITY ERROR;

	-- *
	s_input <= STAR_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "When reading a * character, the output should be '1'" SEVERITY ERROR;

	-- /
	s_input <= SLASH_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "When reading a SLASH_CHARACTER character, the output should be '1'" SEVERITY ERROR;


	-- c
	s_input <= "01100011";
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '0') REPORT "When reading a c character, the output should be '0'" SEVERITY ERROR;

	REPORT "test 2: /*\n c*/c";
	s_reset <= '1';
	WAIT FOR 1 * clk_period;
	s_reset <= '0';
	WAIT FOR 1 * clk_period;

	-- /
	s_input <= SLASH_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '0') REPORT "When reading a SLASH_CHARACTER character, the output should be '0'" SEVERITY ERROR;

	-- *
	s_input <= STAR_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '0') REPORT "When reading a * character, the output should be '0'" SEVERITY ERROR;

	-- \n
	s_input <= NEW_LINE_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "When reading a \n character, the output should be '1'" SEVERITY ERROR;

	-- space
	s_input <= "00100000";
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "When reading a space character, the output should be '1'" SEVERITY ERROR;

	-- c
	s_input <= "01100011";
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "When reading a c character, the output should be '1'" SEVERITY ERROR;

	-- *
	s_input <= STAR_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "When reading a * character, the output should be '1'" SEVERITY ERROR;

	-- /
	s_input <= SLASH_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "When reading a SLASH_CHARACTER character, the output should be '1'" SEVERITY ERROR;

	-- c
	s_input <= "01100011";
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '0') REPORT "When reading a c character, the output should be '0'" SEVERITY ERROR;



	
	REPORT "test 3: /*\n c//**/c";
	s_reset <= '1';
	WAIT FOR 1 * clk_period;
	s_reset <= '0';
	WAIT FOR 1 * clk_period;

	-- /
	s_input <= SLASH_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '0') REPORT "When reading a SLASH_CHARACTER character, the output should be '0'" SEVERITY ERROR;

	-- *
	s_input <= STAR_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '0') REPORT "When reading a * character, the output should be '0'" SEVERITY ERROR;

	-- \n
	s_input <= NEW_LINE_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "When reading a \n character, the output should be '1'" SEVERITY ERROR;

	-- space
	s_input <= "00100000";
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "When reading a space character, the output should be '1'" SEVERITY ERROR;

	-- c
	s_input <= "01100011";
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "When reading a c character, the output should be '1'" SEVERITY ERROR;

	-- /
	s_input <= SLASH_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "When reading a SLASH_CHARACTER character, the output should be '1'" SEVERITY ERROR;

	-- /
	s_input <= SLASH_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "When reading a SLASH_CHARACTER character, the output should be '1'" SEVERITY ERROR;

	-- *
	s_input <= STAR_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "When reading a * character, the output should be '1'" SEVERITY ERROR;

	-- /
	s_input <= SLASH_CHARACTER;
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '1') REPORT "When reading a SLASH_CHARACTER character, the output should be '1'" SEVERITY ERROR;

	-- c
	s_input <= "01100011";
	WAIT FOR 1 * clk_period;
	ASSERT (s_output = '0') REPORT "When reading a c character, the output should be '0'" SEVERITY ERROR;


	WAIT;
END PROCESS stim_process;
END;
