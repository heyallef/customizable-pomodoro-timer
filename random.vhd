library IEEE; use IEEE.STD_LOGIC_1164.ALL; 
 
entity random is Port ( clock : in STD_LOGIC;  
      reset : in STD_LOGIC;    
          con_random : in STD_LOGIC;      
            random_out : out STD_LOGIC);
              end random; 
             
 
architecture Behavioral of random is 
 
signal temp: STD_LOGIC_VECTOR(15 downto 0) := "1010110011100001";  -- Fibonacci's linear feedback shift register
 
begin 
 
PROCESS(clock)
 variable load : STD_LOGIC := '0'; BEGIN 
 
IF rising_edge(clock) THEN   
 IF (reset='1') THEN       
 temp <= "1010110011100001";    
 ELSIF con_random = '1' THEN      
   load := temp(5) XOR temp(3) XOR temp(2) XOR temp(0);      
    temp <= load & temp(15 downto 1); 
 else    
    temp<=temp;
    END IF; 
 
END IF; END PROCESS; 
 
 random_out<= temp(5); 
 
 
end Behavioral; 


