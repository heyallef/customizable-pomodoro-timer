library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity topmodule is
     Port ( counter:in STD_LOGIC;
            CLK: IN std_logic;
            back,up,down: in std_logic;
            min1_in: in STD_LOGIC_VECTOR(3 downto 0); 
            min0_in: in STD_LOGIC_VECTOR(3 downto 0); 
            button : in STD_LOGIC;
            RST : in STD_LOGIC;
            buzzer: out STD_LOGIC;
            anode : out STD_LOGIC_VECTOR (3 downto 0);
            cathode : out STD_LOGIC_VECTOR (7 downto 0); 
            VGA_HS, VGA_VS: Out std_logic;
            VGA_R, VGA_G, VGA_B: Out std_logic_vector( 3 downto 0));
end topmodule;

architecture Behavioral of topmodule is


SIGNAL VGACLK: STD_LOGIC;

signal clk1, clk2 : STD_LOGIC;--to connect clk_480 and clock_centi
signal min11, min00,sec11,sec00: integer;
signal min12, min02,sec12,sec01: integer;
signal randombit: STD_LOGIC;
signal en_random:STD_LOGIC;
signal en_buzzertmp:STD_LOGIC;

component random is Port ( clock : in STD_LOGIC;  
      reset : in STD_LOGIC;    
          con_random: in STD_LOGIC;      
            random_out : out STD_LOGIC);
            end component;


COMPONENT clk_vga is 
    Port (CLK : in STD_LOGIC;
        clock_480 : out STD_LOGIC;
        clock_centi : out STD_LOGIC;
        clock_vga : out STD_LOGIC);
 end COMPONENT;

component vga is
        Port (  CLK: in std_logic;
                min1,min0,sec1,sec0:in integer;  
                back,up,down: in std_logic;
                random: IN STD_LOGIC;
                min0_in,min1_in: in STD_LOGIC_VECTOR ( 3 DOWNTO 0);
                en_buzzer: in STD_LOGIC;
                
                HSYNC, VSYNC: OUT STD_LOGIC;
                R, G, B: OUT STD_LOGIC_VECTOR ( 3 DOWNTO 0); 
                enab_random: out STD_LOGIC);
end component;

component buzzermod is
    Port (clk: in std_logic; 
    en_buzzer: in STD_LOGIC;
           buzzer : out STD_LOGIC);
end component;



component timer

Port ( en_buzzer: out STD_LOGIC;
    
     up_down_count:in STD_LOGIC;
        min1_in: in STD_LOGIC_VECTOR(3 downto 0); 
        min0_in: in STD_LOGIC_VECTOR(3 downto 0); 
        c_button : in STD_LOGIC;
        RST : in STD_LOGIC;
        CLK : in STD_LOGIC;
        min_1,min_0,sec_0,sec_1:out integer;
        clk_timer : in STD_LOGIC
        
        );
end component;


component seg7decoder
Port( anode : out STD_LOGIC_VECTOR (3 downto 0);
    cathode : out STD_LOGIC_VECTOR (7 downto 0);
    clock_480 : in STD_LOGIC;
    min1,min0,sec1,sec0:in integer);
    end component;



BEGIN
buzzers: buzzermod port map (clk=>clk, en_buzzer=>en_buzzertmp, buzzer=>buzzer);
random_generator: random port map(clock=>clk, con_random=>en_random, reset=>rst, random_out=>randombit);

vgacont: vga PORT MAP(CLK=>VGACLK,
                   HSYNC=> VGA_HS,
                   VSYNC=> VGA_VS,
                   R => VGA_R,
                   G => VGA_G,
                   B => VGA_B,
                    min1=>min11,min0=> min00,sec1=>sec11,sec0=>sec00,back=>back, down=>down, up=>up,
                    enab_random=>en_random,
                  random=>randombit,min0_in=>min0_in,min1_in=>min1_in ,en_buzzer=>en_buzzertmp
                  );
 
                           
                           
clkdivider : clk_vga port map (CLK => CLK, clock_480 => clk1, clock_centi => clk2,clock_vga=>VGACLK);

timerT : timer port map (up_down_count=>counter,min1_in=>min1_in,min0_in=>min0_in,CLK => CLK,  
clk_timer => clk2, c_button =>button,RST => RST,min_1=>min11,min_0=> min00,sec_1=>sec11,sec_0=>sec00,en_buzzer=>en_buzzertmp);

seg7: seg7decoder port map (anode => anode, cathode => cathode,
clock_480 => clk1,min1=>min11,min0=> min00,sec1=>sec11,sec0=>sec00);
end Behavioral;

