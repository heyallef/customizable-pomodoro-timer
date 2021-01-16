
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity buzzermod is
    Port (clk: in std_logic; 
          en_buzzer: in STD_LOGIC;
           buzzer : out STD_LOGIC);
end buzzermod;

architecture Behavioral of buzzermod is

begin


process (clk) 
variable i : integer :=0;
begin

 if rising_edge(clk) then
 if en_buzzer='1' then
  
 if i<=500000 then
 i:=i+1;
 buzzer<='1';
 
elsif i>500000 and i< 1000000 then 
i:= i+1 ;

buzzer<='0';
elsif i =1000000 then
i:=0;


end if ; end if; end if;
end process ;

 



end Behavioral;