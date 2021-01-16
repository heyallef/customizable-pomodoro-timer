library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity clk_vga is
Port ( CLK : in STD_LOGIC;
        clock_480 : out STD_LOGIC;
        clock_centi : out STD_LOGIC;
        clock_vga : out STD_LOGIC);
end clk_vga;

architecture Behavioral of clk_vga is

signal clk1, clk2 : STD_LOGIC;
signal clk3, clk4: std_logic:= '0'; 

begin

clk_480hz : process (CLK) --clock that runs at 480Hz to keep all the leds on

variable count1 : unsigned (18 downto 0):=(others =>'0');

begin

if (rising_edge(CLK)) then

    if count1 = "110010110111001101" then --counting to 208333
        clk1 <= not clk1;
        count1 := (others =>'0');
   
    end if;
    
    count1 := count1 + 1;

end if;
end process;

clk_centi : process (CLK) --clock that runs at 0.5MHz to count in centiseconds

variable count2 : unsigned (18 downto 0):=(others =>'0');

begin

if (rising_edge(CLK)) then

    if count2 = "1111010000100100000" then --counting to 500000
        clk2 <= not clk2;
        count2 := "0000000000000000000";

    end if;

count2 := count2 + 1;

end if;
end process;




clk_vga: process(CLK, clk3) 

begin if rising_edge(CLK) then --50mhz 
clk3<= not clk3; 
end if; 
if rising_edge(clk3) then --25mhz
clk4 <= not clk4; 
end if; 
end process; 
 


clock_480 <= clk1; --7 segment display
clock_centi <= clk2; --real time clock
clock_vga <= clk4; --sync vga

end Behavioral;



 
