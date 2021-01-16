
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity timer is

Port (
            clk_timer : in STD_LOGIC;
            up_down_count:in STD_LOGIC;
            min1_in: in STD_LOGIC_VECTOR(3 downto 0); 
            min0_in: in STD_LOGIC_VECTOR(3 downto 0); 
            c_button : in STD_LOGIC;
            RST : in STD_LOGIC;
            CLK : in STD_LOGIC;
            
            min_1,min_0,sec_0,sec_1:out integer;
            en_buzzer:out STD_LOGIC);
            
end timer;

architecture Behavioral of timer is
signal min1:integer;
signal min0:integer;
signal sec1,sec0, x, y : integer:=0; --for the 4 leds(min(1)&min(0)&sec(1)&sec(0)) on the 7seg display-x centisec(1)& y centisec(0) x,y don't display on 7seg


signal PS, NS : STD_LOGIC_VECTOR (1 downto 0):="00"; --present state/next state(used 2 bit binary to present states since cases change according to the up and down counter)
--for instance "11" means 'stop the counter' in down counter part; however, in up counter it means 'continue'.


signal button_s1, button_s2, en_timer : STD_LOGIC:='0';--to stop and reactivate

begin

process(CLK)
begin
if (rising_edge(CLK)) then
    PS <= NS;
end if;
end process;


adding : process (c_button, RST, clk_timer, PS, NS, button_s1, button_s2)


begin



if RST = '1' then 
   
    min1<=0;
    min0<=0;
    sec1 <= 0;
    sec0 <= 0;
    x <= 0;
    y <= 0;
    
    en_buzzer<='0';
    
else

    if (rising_edge(clk_timer)) then --every centisec(100cs=1s)
    
        if c_button = '1' then --to detect rising edge for the center button
            button_s1 <= '1';
            
        elsif c_button = '0' then
            button_s1 <= '0';
        end if;
        
        button_s2 <= button_s1;
    
        if button_s2 = '0' and button_s1 = '1' then
            en_timer <= not en_timer;
        end if;
        
       
       if(up_down_count='1')then  --
           
        case (PS) is
        
        when "00" => -- when the clock is already running
                
                min1<=to_integer(unsigned(min1_in));
                min0<=to_integer(unsigned(min0_in)); 
                NS <= "10";
    
    
         when "10" =>
               if en_timer='1' then 
               en_buzzer<='0';                                       
                if x=0 then 
                    if y=0 then
                        if sec0=0 then 
                            if sec1=0 then
                                if min0=0 then 
                                    if min1=0 then 
                                            en_buzzer<='1';
                                            en_timer <='0';  
                                    
                                    else min1<=min1-1; min0<=9;sec1<=5;sec0<=9;y<=9; x<=9;end if;
                                else min0<=min0-1; sec1<=5; sec0<=9;y<=9; x<=9;end if;
                             else sec1<=sec1-1; sec0<=9;y<=9; x<=9; end if;  
                       else sec0<=sec0-1; y<=9; x<=9;end if;
                   else y<=y-1; x<=9; end if;                   
                 else x<=x-1; end if;      
                elsif en_timer = '0' then
                NS <= "11";
            end if;  
    
        when "11" => --when the timer is stopped
        if en_timer = '0' then
            NS <= "11";
            min1 <= min1;
            min0 <= min0;
            sec1 <= sec1;
            sec0 <= sec0;
            x <= x;
            y <= y;
            
            
        elsif en_timer = '1' then----when the timer is reactivated
            NS <= "10";
        end if;
        
        when others => --should never happen
        NS <= "11";
        min1 <= 0;
        min0 <= 0;
        sec1 <= 0;
        sec0 <= 0;
        x <= 0;
        y <= 0;
      
        end case;
        
        
        
        
        else
        
        case (PS) is
        when "11" => -- when the clock is already running
            if en_timer = '1' then
                NS <= "11";
                en_buzzer<='0';
                                              
                y <= y + 1; --code to have the timer count
                if y = 9 then
                    x <= x + 1;
                    y <= 0;
                    if x = 9 then
                        sec0 <= sec0 + 1;
                        x <= 0;
                        if sec0 = 9 then
                            sec1 <= sec1 + 1;
                            sec0 <= 0;
                            if sec1 = 5 then 
                                sec1 <= 0;
                                min0 <= min0 + 1;
        
                                 if min0 = 9 then
                                    min1 <= min1 + 1;
                                    min0 <=0;
                                    if (min1 = 5) then-- above 59 min, clock will stop
                                        min1<=0;
                                        min0<=0;
                                        sec1<=0;
                                        sec0<=0;
                                        x <= 0;
                                        y <= 0;
        
                                    end if;
                                 end if;
                            end if;
                        end if;
                    end if;
                end if;
                
                if ((min1 = to_integer(unsigned(min1_in))) and (min0 = to_integer(unsigned(min0_in)))) then--at desired time(user can change only minute's value) clock will stop
                    en_buzzer<='1';
                    en_timer <='0';
                    
                end if;
    
            elsif en_timer = '0' then
                NS <= "00";
                
            end if;
        when "00" => --when the timer is stopped
        if en_timer = '0' then
            NS <= "00";
            min1 <= min1;
            min0 <= min0;
            sec1 <= sec1;
            sec0 <= sec0;
            x <= x;
            y <= y;
            
        elsif en_timer = '1' then----when the timer is reactivated
            NS <= "11";
        end if;
        
        when others => --should never happen
        NS <= "00";
        min1 <= 0;
        min0 <= 0;
        sec1 <= 0;
        sec0 <= 0;
        x <= 0;
        y <= 0;
        end case;
    end if;
    end if;
end if;
end process;
min_1 <= min1;
min_0 <= min0;
sec_1 <= sec1;
sec_0 <= sec0;
   
end Behavioral;
