
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity seg7decoder is
Port ( clock_480 : in STD_LOGIC;
    min1,min0,sec1,sec0:in integer;
    anode : out STD_LOGIC_VECTOR (3 downto 0);
    cathode : out STD_LOGIC_VECTOR (7 downto 0)
    );

 

end seg7decoder;
architecture Behavioral of seg7decoder is
begin


led : process (clock_480) --tells leds when to turn on
variable digit1, digit2 : unsigned (1 downto 0):="00";
begin
if (rising_edge(clock_480)) then
case (digit1) is
when "00" =>
anode <= "0111";
when "01" =>
anode <= "1011";
when "10" =>
anode <= "1101";
when "11" =>
anode <= "1110";
end case;

case (digit2) is
when "00" =>
case (min1) is
when 0 =>
cathode <= "00000011";
when 1 =>
cathode <= "10011111";
when 2 =>
cathode <= "00100101";
when 3 =>
cathode <= "00001101";
when 4 =>
cathode <= "10011001";
when 5 =>
cathode <= "01001001";
when 6 =>
cathode <= "01000001";
when 7 =>
cathode <= "00011111";
when 8 =>
cathode <= "00000001";
when 9 =>
cathode <= "00011001";
when others =>
cathode <= "11111111";
end case;
when "01" =>
case (min0) is
when 0 =>
cathode <= "00000010";
when 1 =>
cathode <= "10011110";
when 2 =>
cathode <= "00100100";
when 3 =>
cathode <= "00001100";
when 4 =>
cathode <= "10011000";
when 5 =>
cathode <= "01001000";
when 6 =>
cathode <= "01000000";
when 7 =>
cathode <= "00011110";
when 8 =>
cathode <= "00000000";
when 9 =>
cathode <= "00011000";
when others =>
cathode <= "11111110";
end case;

when "10" =>
case (sec1) is
when 0 =>
cathode <= "00000011";
when 1 =>
cathode <= "10011111";
when 2 =>
cathode <= "00100101";
when 3 =>
cathode <= "00001101";
when 4 =>
cathode <= "10011001";
when 5 =>
cathode <= "01001001";
when 6 =>
cathode <= "01000001";
when 7 =>
cathode <= "00011111";
when 8 =>
cathode <= "00000001";
when 9 =>
cathode <= "00011001";
when others =>
cathode <= "11111111";
end case;

when "11" =>
case (sec0) is
when 0 =>
cathode <= "00000011";
when 1 =>
cathode <= "10011111";
when 2 =>
cathode <= "00100101";
when 3 =>
cathode <= "00001101";
when 4 =>
cathode <= "10011001";
when 5 =>
cathode <= "01001001";
when 6 =>
cathode <= "01000001";
when 7 =>
cathode <= "00011111";
when 8 =>
cathode <= "00000001";
when 9 =>
cathode <= "00011001";
when others =>
cathode <= "11111111";
end case;

end case;

digit1 := digit1 + 1;
digit2 := digit2 + 1;
end if;
end process;

end Behavioral;

