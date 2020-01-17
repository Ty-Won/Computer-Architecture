library ieee;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

-- Do not modify the port map of this structure
entity comments_fsm is
port (clk : in std_logic;
      reset : in std_logic;
      input : in std_logic_vector(7 downto 0);
      output : out std_logic
  );
end comments_fsm;

architecture behavioral of comments_fsm is

-- The ASCII value for the '/', '*' and end-of-line characters
constant SLASH_CHARACTER : std_logic_vector(7 downto 0) := "00101111";
constant STAR_CHARACTER : std_logic_vector(7 downto 0) := "00101010";
constant NEW_LINE_CHARACTER : std_logic_vector(7 downto 0) := "00001010";
type state_type is (uncommented, slash, one_line_comment, multi_line_comment, star);
signal state : state_type;


begin
-- Insert your processes here 
process (clk, reset)
begin
    if reset = '1' then
        state <= uncommented;
        output <= 'U';
    elsif rising_edge(clk) then
        case state is
            when uncommented =>
                if input /= SLASH_CHARACTER then
                    output <= '0';
                else
                    state <= slash;
                    output <= '0';
                end if;  
            when slash =>
                if input = SLASH_CHARACTER then
                    output <= '0';
                    state <= one_line_comment; 
                elsif input = STAR_CHARACTER then
                    state <= multi_line_comment;
                    output <= '0';
                else
                    state <= uncommented;
                end if;
            when one_line_comment =>
                if input /= NEW_LINE_CHARACTER then
                    output <= '1';
                    state <= one_line_comment; 
                else
                    state <= uncommented;
                    output <= '1';
                end if;
            when multi_line_comment =>
                if input /= STAR_CHARACTER then
                    output <= '1';
                    state <= multi_line_comment; 
                else
                    state <= star;
                    output <= '1';
                end if;
            when star =>
                if input = STAR_CHARACTER then
                    output <= '1';
                    state <= star; 
                elsif input = SLASH_CHARACTER then
                    state <= uncommented;
                    output <= '1';
                else
                    output <= '1';
                    state <= multi_line_comment;
                end if;
        end case;
    end if;

end process;

end behavioral;