
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.my.all;--
use work.menu.all;
use work.down.all;--
use work.colon.all;
use work.setwork.all;--
use work.quot_2.all;
use work.quot_1.all;
use work.fint.all;--
use work.take_break.all;

entity vga is
        Port ( CLK: in STD_LOGIC;
               min0_in,min1_in: in STD_LOGIC_VECTOR ( 3 DOWNTO 0);
               en_buzzer: in STD_LOGIC;
               min1,min0,sec1,sec0:in integer;
               back,up,down: in STD_LOGIC;
               random:in STD_LOGIC;
               
               enab_random: out STD_LOGIC;
               HSYNC, VSYNC: out STD_LOGIC;
               R, G, B: OUT STD_LOGIC_VECTOR ( 3 DOWNTO 0));
end vga;

architecture MAIN of vga is
SIGNAL RGB: STD_LOGIC_VECTOR(3 DOWNTO 0);

SIGNAL DRAW1,DRAW2,DRAW3,DRAW4,DRAW5,DRAW6,DRAW7: STD_LOGIC;--minute(1)
SIGNAL DRAW8,DRAW9,DRAW10,DRAW11,DRAW12,DRAW13,DRAW14: STD_LOGIC;--minute(0)
SIGNAL DRAW15,DRAW16,DRAW17,DRAW18,DRAW19,DRAW20,DRAW21: STD_LOGIC;--second(1)
SIGNAL DRAW22,DRAW23,DRAW24,DRAW25,DRAW26,DRAW27,DRAW28: STD_LOGIC;--second(0)

SIGNAL w_quo2,w_quo1,drawset,drawtake_b:STD_LOGIC;
SIGNAL DRAWd,drawa,drawco1,drawco2,drawfin: STD_LOGIC;



--positions of images
    
    --colon to separate min and sec
SIGNAL col2x,col1x: INTEGER RANGE 0 TO 800:=455;
SIGNAL col2y: INTEGER RANGE 0 TO 800:=320;
    --arrows
SIGNAL downax: INTEGER RANGE 0 TO 800:=175;
SIGNAL downay: INTEGER RANGE 0 TO 800:=290;
    
SIGNAL SQ_X1: INTEGER RANGE 0 TO 800:=150;
SIGNAL SQ_Y1: INTEGER RANGE 0 TO 800:=50;
SIGNAL TU_X: INTEGER RANGE 0 TO 800:=220;

    --rectangulars named as segments
SIGNAL G1_X,A1_X,D1_X: INTEGER RANGE 0 TO 800:=240;
SIGNAL F1_Y,E1_Y,col1y: INTEGER RANGE 0 TO 800:=230;
SIGNAL G1_Y,G2_Y,G3_Y,G4_Y: INTEGER RANGE 0 TO 800:=270;
SIGNAL F1_X,B1_X,F2_X,B2_X,F3_X,B3_X,F4_X,B4_X: INTEGER RANGE 0 TO 800:=180;
SIGNAL A1_Y,A2_Y,A3_Y,A4_Y:INTEGER RANGE 0 TO 800:=150;
SIGNAL E1_X,C1_X,E2_X,C2_X,E3_X,C3_X,E4_X,C4_X:INTEGER RANGE 0 TO 800:=300;
SIGNAL B1_Y,C1_Y:INTEGER RANGE 0 TO 800:=310;
SIGNAL D1_Y,D2_Y,D3_Y,D4_Y:INTEGER RANGE 0 TO 800:=390;
SIGNAL G2_X,A2_X,D2_X: INTEGER RANGE 0 TO 800:=350;
SIGNAL F2_Y,E2_Y: INTEGER RANGE 0 TO 800:=340;
SIGNAL B2_Y,C2_Y:INTEGER RANGE 0 TO 800:=420;
SIGNAL G3_X,A3_X,D3_X: INTEGER RANGE 0 TO 800:=500;
SIGNAL F3_Y,E3_Y: INTEGER RANGE 0 TO 800:=490;
SIGNAL B3_Y,C3_Y:INTEGER RANGE 0 TO 800:=570;
SIGNAL G4_X,A4_X,D4_X: INTEGER RANGE 0 TO 800:=610;
SIGNAL F4_Y,E4_Y: INTEGER RANGE 0 TO 800:=600;
SIGNAL B4_Y,C4_Y:INTEGER RANGE 0 TO 800:=680;

  
signal color:integer;

--calculated HPOS and VPOS      
SIGNAL HPOS: INTEGER RANGE 0 TO 800:=0; --Horizontal Display(640) + Horizontal Front Porch(16) + Horizontal Snyc Pulse(96) + Horizontal Back Porch(48); --800
SIGNAL VPOS: INTEGER RANGE 0 TO 525:=0;-- Vertical Display(480) + Vertical Front Porch(10) + Vertical Snyc Pulse(2) + Vertical Back Porch(33); --525 

---FSM 
type state_type is(menu, timer, work,break,time_up);
signal state :state_type;

begin

Mmenu(HPOS,VPOS,SQ_X1,SQ_Y1,RGB,DRAWa);

dwn(HPOS,VPOS,downax,downay,RGB,DRAWd);

col(HPOS,VPOS,col1x,col1y,RGB,DRAWco1);
col(HPOS,VPOS,col2x,col2y,RGB,DRAWco2);

rec(HPOS,VPOS,A1_X,A1_Y,RGB,DRAW1);
rec(VPOS,HPOS,B1_X,B1_Y,RGB,DRAW2);--to create vertical rect, the position of hpos and vpos is changed
rec(VPOS,HPOS,C1_X,C1_Y,RGB,DRAW3);
rec(HPOS,VPOS,D1_X,D1_Y,RGB,DRAW4);
rec(VPOS,HPOS,E1_X,E1_Y,RGB,DRAW5);
rec(VPOS,HPOS,F1_X,F1_Y,RGB,DRAW6);
rec(HPOS,VPOS,G1_X,G1_Y,RGB,DRAW7);

rec(HPOS,VPOS,A2_X,A2_Y,RGB,DRAW8);
rec(VPOS,HPOS,B2_X,B2_Y,RGB,DRAW9);
rec(VPOS,HPOS,C2_X,C2_Y,RGB,DRAW10);
rec(HPOS,VPOS,D2_X,D2_Y,RGB,DRAW11);
rec(VPOS,HPOS,E2_X,E2_Y,RGB,DRAW12);
rec(VPOS,HPOS,F2_X,F2_Y,RGB,DRAW13);
rec(HPOS,VPOS,G2_X,G2_Y,RGB,DRAW14);

rec(HPOS,VPOS,A3_X,A3_Y,RGB,DRAW15);
rec(VPOS,HPOS,B3_X,B3_Y,RGB,DRAW16);
rec(VPOS,HPOS,C3_X,C3_Y,RGB,DRAW17);
rec(HPOS,VPOS,D3_X,D3_Y,RGB,DRAW18);
rec(VPOS,HPOS,E3_X,E3_Y,RGB,DRAW19);
rec(VPOS,HPOS,F3_X,F3_Y,RGB,DRAW20);
rec(HPOS,VPOS,G3_X,G3_Y,RGB,DRAW21);

rec(HPOS,VPOS,A4_X,A4_Y,RGB,DRAW22);
rec(VPOS,HPOS,B4_X,B4_Y,RGB,DRAW23);
rec(VPOS,HPOS,C4_X,C4_Y,RGB,DRAW24);
rec(HPOS,VPOS,D4_X,D4_Y,RGB,DRAW25);
rec(VPOS,HPOS,E4_X,E4_Y,RGB,DRAW26);
rec(VPOS,HPOS,F4_X,F4_Y,RGB,DRAW27);
rec(HPOS,VPOS,G4_X,G4_Y,RGB,DRAW28);

quot1(HPOS,VPOS,SQ_X1,A1_Y,RGB,w_quo1);
quot2(HPOS,VPOS,SQ_X1,A1_Y,RGB,w_quo2);
set(HPOS,VPOS,SQ_X1,downay,RGB,DRAWset);
fin(HPOS,VPOS,TU_X,A1_Y,RGB,drawfin);
take_b(HPOS,VPOS,TU_X,A1_Y,RGB,drawtake_b);




    PROCESS(CLK)
    
     BEGIN
     IF (CLK'EVENT AND CLK='1') THEN
     case state is
     
     when menu=>
               IF (DRAWa='1') THEN color<=1;end if;
               IF (DRAWd='1') THEN color<=4; END IF;
               if DRAWa='0' and DRAWd='0'then color<=0; end if;
               
               enab_random<='1';
                if up='1' then state<=work;
                 elsif down='1' then state<=break;
                
                else state<=menu; end if;
                
    when break=> 
                if drawset='1' then color<=1;end if;
                if drawtake_b='1' then color<=3;end if;
                IF ( DRAWset='0' and drawtake_b='0') THEN  color<=0;END IF; 
        
           if min1_in /="0000" or min0_in /="0000" then state<=timer; else state<=break; end if;
                
    when work=>
               enab_random<='0';
               
                if drawset='1' then color<=1;end if;
                if random='1' and w_quo1='1' then color<=3; end if;
                if random='0' and w_quo2='1' then color<=3; end if; 
                IF (  random='1' and DRAWset='0' and w_quo1='0') THEN color<=0; END IF;
                IF ( DRAWset='0' and w_quo2='0'and random='0') THEN color<=0;END IF;
               
           if min1_in /="0000" or min0_in /="0000" then state<=timer; else state<=work; end if;
           
                
                
    when timer=>
                if DRAWco1='1' THEN color<=4;   END IF;
                if DRAWco2='1' THEN color<=4;  END IF;
        
                
        case (min1) is --like seven segment decoder 
        when 0 =>
                if DRAW1='1' THEN color<=3;   END IF;
                if DRAW2='1' THEN color<=3;  END IF;
                if DRAW3='1' THEN color<=3;   END IF;
                if DRAW4='1' THEN color<=3;   END IF;
                if DRAW5='1' THEN color<=3;   END IF;
                if DRAW6='1' THEN color<=3;   END IF;
        when 1 =>
                if DRAW2='1' THEN color<=3;  END IF;
                if DRAW3='1' THEN color<=3;   END IF;
        when 2 =>
                if DRAW1='1' THEN color<=3;   END IF;
                if DRAW2='1' THEN color<=3;   END IF;
                if DRAW4='1' THEN color<=3;   END IF;
                if DRAW5='1' THEN color<=3;   END IF;
                if DRAW7='1' THEN color<=3;   END IF;
        when 3 =>
                if DRAW1='1' THEN color<=3;   END IF;
                if DRAW2='1' THEN color<=3;   END IF;
                if DRAW7='1' THEN color<=3;   END IF;
                if DRAW4='1' THEN color<=3;   END IF;
                if DRAW3='1' THEN color<=3;   END IF;
        when 4 =>
                if DRAW2='1' THEN color<=3;   END IF;
                if DRAW7='1' THEN color<=3;   END IF;
                if DRAW6='1' THEN color<=3;   END IF;
                if DRAW3='1' THEN color<=3;   END IF;
        when 5 =>
                if DRAW1='1' THEN color<=3;   END IF;
                if DRAW6='1' THEN color<=3;   END IF;
                if DRAW4='1' THEN color<=3;   END IF;
                if DRAW3='1' THEN color<=3;   END IF;
                if DRAW7='1' THEN color<=3;   END IF;
        when 6 =>
                if DRAW1='1' THEN color<=3;   END IF;
                if DRAW6='1' THEN color<=3;   END IF;
                if DRAW4='1' THEN color<=3;   END IF;
                if DRAW3='1' THEN color<=3;   END IF;
                if DRAW7='1' THEN color<=3;   END IF;
                if DRAW5='1' THEN color<=3;   END IF;
        when 7 =>
                if DRAW1='1' THEN color<=3;   END IF;
                if DRAW2='1' THEN color<=3;   END IF;
                if DRAW3='1' THEN color<=3;   END IF;
        when 8 =>
                if DRAW1='1' THEN color<=3;   END IF;
                if DRAW6='1' THEN color<=3;   END IF;
                if DRAW4='1' THEN color<=3;   END IF;
                if DRAW3='1' THEN color<=3;   END IF;
                if DRAW7='1' THEN color<=3;   END IF;
                if DRAW5='1' THEN color<=3;   END IF;
                if DRAW2='1' THEN color<=3;   END IF;
        when 9 =>
                if DRAW1='1' THEN color<=3;   END IF;
                if DRAW6='1' THEN color<=3;  END IF;
                if DRAW4='1' THEN color<=3;   END IF;
                if DRAW3='1' THEN color<=3;   END IF;
                if DRAW7='1' THEN color<=3;   END IF;
                if DRAW2='1' THEN color<=3;   END IF;
        when others =>
                if DRAW3='1' THEN color<=3;   END IF;
                if DRAW7='1' THEN color<=3;   END IF;
                if DRAW2='1' THEN color<=3;   END IF;
        end case;
        
        
        case (min0) is
        when 0 =>
                if DRAW8='1' THEN color<=3;   END IF;
                if DRAW9='1' THEN color<=3;   END IF;
                if DRAW10='1' THEN color<=3;   END IF;
                if DRAW11='1' THEN color<=3;   END IF;
                if DRAW12='1' THEN color<=3;   END IF;
                if DRAW13='1' THEN color<=3;   END IF;
        when 1 =>
                if DRAW9='1' THEN color<=3;   END IF;
                if DRAW10='1' THEN color<=3;   END IF;
        when 2 =>
                if DRAW8='1' THEN color<=3;   END IF;
                if DRAW9='1' THEN color<=3;   END IF;
                if DRAW14='1' THEN color<=3;   END IF;
                if DRAW11='1' THEN color<=3;   END IF;
                if DRAW12='1' THEN color<=3;   END IF;
        when 3 =>
                if DRAW8='1' THEN color<=3;   END IF;
                if DRAW9='1' THEN color<=3;   END IF;
                if DRAW14='1' THEN color<=3;   END IF;
                if DRAW11='1' THEN color<=3;   END IF;
                if DRAW10='1' THEN color<=3;   END IF;
        when 4 =>
                if DRAW9='1' THEN color<=3;   END IF;
                if DRAW14='1' THEN color<=3;   END IF;
                if DRAW13='1' THEN color<=3;   END IF;
                if DRAW10='1' THEN color<=3;   END IF;
        when 5 =>
                if DRAW8='1' THEN color<=3;   END IF;
                if DRAW13='1' THEN color<=3;   END IF;
                if DRAW11='1' THEN color<=3;   END IF;
                if DRAW10='1' THEN color<=3;   END IF;
                if DRAW14='1' THEN color<=3;   END IF;
        when 6 =>
                if DRAW8='1' THEN color<=3;   END IF;
                if DRAW13='1' THEN color<=3;   END IF;
                if DRAW11='1' THEN color<=3;   END IF;
                if DRAW10='1' THEN color<=3;   END IF;
                if DRAW14='1' THEN color<=3;   END IF;
                if DRAW12='1' THEN color<=3;   END IF;
        when 7 =>
                if DRAW8='1' THEN color<=3;   END IF;
                if DRAW9='1' THEN color<=3;   END IF;
                if DRAW10='1' THEN color<=3;   END IF;
        when 8 =>
                if DRAW8='1' THEN color<=3;   END IF;
                if DRAW13='1' THEN color<=3;   END IF;
                if DRAW11='1' THEN color<=3;   END IF;
                if DRAW10='1' THEN color<=3;   END IF;
                if DRAW14='1' THEN color<=3;   END IF;
                if DRAW12='1' THEN color<=3;   END IF;
                if DRAW9='1' THEN color<=3;   END IF;
        when 9 =>
                if DRAW8='1' THEN color<=3;   END IF;
                if DRAW13='1' THEN color<=3;   END IF;
                if DRAW11='1' THEN color<=3;   END IF;
                if DRAW10='1' THEN color<=3;   END IF;
                if DRAW14='1' THEN color<=3;   END IF;
                if DRAW9='1' THEN color<=3;   END IF;
        when others =>
                if DRAW10='1' THEN color<=3;   END IF;
                if DRAW14='1' THEN color<=3;   END IF;
                if DRAW9='1' THEN color<=3;   END IF;
        end case;
        
        
        case (sec1) is 
        
        when 0 =>
                if DRAW15='1' THEN color<=3;   END IF;
                if DRAW16='1' THEN color<=3;   END IF;
                if DRAW17='1' THEN color<=3;   END IF;
                if DRAW18='1' THEN color<=3;   END IF;
                if DRAW19='1' THEN color<=3;   END IF;
                if DRAW20='1' THEN color<=3;   END IF;
        when 1 =>
                if DRAW16='1' THEN color<=3;   END IF;
                if DRAW17='1' THEN color<=3;   END IF;
        when 2 =>
                if DRAW15='1' THEN color<=3;   END IF;
                if DRAW16='1' THEN color<=3;   END IF;
                if DRAW21='1' THEN color<=3;   END IF;
                if DRAW18='1' THEN color<=3;   END IF;
                if DRAW19='1' THEN color<=3;   END IF;
        when 3 =>
                if DRAW15='1' THEN color<=3;   END IF;
                if DRAW16='1' THEN color<=3;   END IF;
                if DRAW21='1' THEN color<=3;   END IF;
                if DRAW18='1' THEN color<=3;   END IF;
                if DRAW17='1' THEN color<=3;   END IF;
        when 4 =>
                if DRAW16='1' THEN color<=3;   END IF;
                if DRAW21='1' THEN color<=3;   END IF;
                if DRAW20='1' THEN color<=3;   END IF;
                if DRAW17='1' THEN color<=3;   END IF;
        when 5 =>
                if DRAW15='1' THEN color<=3;   END IF;
                if DRAW20='1' THEN color<=3;   END IF;
                if DRAW18='1' THEN color<=3;   END IF;
                if DRAW17='1' THEN color<=3;   END IF;
                if DRAW21='1' THEN color<=3;   END IF;
        when 6 =>
                if DRAW15='1' THEN color<=3;   END IF;
                if DRAW20='1' THEN color<=3;   END IF;
                if DRAW18='1' THEN color<=3;   END IF;
                if DRAW17='1' THEN color<=3;   END IF;
                if DRAW21='1' THEN color<=3;   END IF;
                if DRAW19='1' THEN color<=3;   END IF;
        when 7 =>
                if DRAW15='1' THEN color<=3;   END IF;
                if DRAW16='1' THEN color<=3;   END IF;
                if DRAW17='1' THEN color<=3;   END IF;
        when 8 =>
                if DRAW15='1' THEN color<=3;   END IF;
                if DRAW20='1' THEN color<=3;   END IF;
                if DRAW18='1' THEN color<=3;   END IF;
                if DRAW17='1' THEN color<=3;   END IF;
                if DRAW21='1' THEN color<=3;   END IF;
                if DRAW19='1' THEN color<=3;   END IF;
                if DRAW16='1' THEN color<=3;   END IF;
        when 9 =>
                if DRAW15='1' THEN color<=3;   END IF;
                if DRAW20='1' THEN color<=3;   END IF;
                if DRAW18='1' THEN color<=3;   END IF;
                if DRAW17='1' THEN color<=3;   END IF;
                if DRAW21='1' THEN color<=3;   END IF;
                if DRAW16='1' THEN color<=3;   END IF;
        when others =>
                if DRAW17='1' THEN color<=3;   END IF;
                if DRAW21='1' THEN color<=3;   END IF;
                if DRAW16='1' THEN color<=3;   END IF;
        end case;
        
        case (sec0) is
        when 0 =>
                if DRAW22='1' THEN color<=3;   END IF;
                if DRAW23='1' THEN color<=3;   END IF;
                if DRAW24='1' THEN color<=3;   END IF;
                if DRAW25='1' THEN color<=3;   END IF;
                if DRAW26='1' THEN color<=3;   END IF;
                if DRAW27='1' THEN color<=3;   END IF;
        when 1 =>
                if DRAW23='1' THEN color<=3;   END IF;
                if DRAW24='1' THEN color<=3;   END IF;
        when 2 =>
                if DRAW22='1' THEN color<=3;   END IF;
                if DRAW23='1' THEN color<=3;   END IF;
                if DRAW28='1' THEN color<=3;   END IF;
                if DRAW25='1' THEN color<=3;   END IF;
                if DRAW26='1' THEN color<=3;   END IF;
        when 3 =>
                if DRAW22='1' THEN color<=3;   END IF;
                if DRAW23='1' THEN color<=3;   END IF;
                if DRAW28='1' THEN color<=3;   END IF;
                if DRAW25='1' THEN color<=3;   END IF;
                if DRAW24='1' THEN color<=3;   END IF;
        when 4 =>
                if DRAW23='1' THEN color<=3;   END IF;
                if DRAW28='1' THEN color<=3;   END IF;
                if DRAW27='1' THEN color<=3;   END IF;
                if DRAW24='1' THEN color<=3;   END IF;
        when 5 =>
                if DRAW22='1' THEN color<=3;   END IF;
                if DRAW27='1' THEN color<=3;   END IF;
                if DRAW25='1' THEN color<=3;   END IF;
                if DRAW24='1' THEN color<=3;   END IF;
                if DRAW28='1' THEN color<=3;   END IF;
        when 6 =>
                if DRAW22='1' THEN color<=3;   END IF;
                if DRAW27='1' THEN color<=3;   END IF;
                if DRAW25='1' THEN color<=3;   END IF;
                if DRAW24='1' THEN color<=3;   END IF;
                if DRAW28='1' THEN color<=3;   END IF;
                if DRAW26='1' THEN color<=3;   END IF;
        when 7 =>
                if DRAW22='1' THEN color<=3;   END IF;
                if DRAW23='1' THEN color<=3;   END IF;
                if DRAW24='1' THEN color<=3;   END IF;
        when 8 =>
                if DRAW22='1' THEN color<=3;   END IF;
                if DRAW27='1' THEN color<=3;   END IF;
                if DRAW25='1' THEN color<=3;   END IF;
                if DRAW24='1' THEN color<=3;   END IF;
                if DRAW28='1' THEN color<=3;   END IF;
                if DRAW26='1' THEN color<=3;   END IF;
                if DRAW23='1' THEN color<=3;   END IF;
        when 9 =>
                if DRAW22='1' THEN color<=3;   END IF;
                if DRAW27='1' THEN color<=3;   END IF;
                if DRAW25='1' THEN color<=3;   END IF;
                if DRAW24='1' THEN color<=3;   END IF;
                if DRAW28='1' THEN color<=3;   END IF;
                if DRAW23='1' THEN color<=3;   END IF;
        when others =>
                if DRAW24='1' THEN color<=3;   END IF;
                if DRAW28='1' THEN color<=3;   END IF;
                if DRAW23='1' THEN color<=3;   END IF;
        end case;
        IF (DRAW1='0' AND DRAW2='0' and DRAW3='0' AND DRAW4='0' and DRAW5='0' AND DRAW6='0' and DRAW7='0'and
                DRAW8='0' AND DRAW9='0' and DRAW10='0' AND DRAW11='0' and DRAW12='0' AND DRAW13='0' and DRAW14='0'and
                DRAW15='0' AND DRAW16='0' and DRAW17='0' AND DRAW18='0' and DRAW19='0' AND DRAW20='0' and DRAW21='0'and
                DRAW22='0' AND DRAW23='0' and DRAW24='0' AND DRAW25='0' and DRAW26='0' AND DRAW27='0' and DRAW28='0' and DRAWco1='0' and DRAWco2='0') THEN
                  color<=0;
                END IF;
                
         if en_buzzer='1' then state <=time_up; elsif back='1' then state<=menu;else state<=timer; end if;
        
   when time_up=> 
                if drawfin='1' then color<=1; end if;
                if drawfin='0' then color<=0; end if;
              
              if back='1' then state<=menu;else state<=time_up; end if;
              
  when others=>
             color<=0;
             
  end case;  
        
                  IF (DRAW1='0' AND DRAW2='0' and DRAW3='0' AND DRAW4='0' and DRAW5='0' AND DRAW6='0' and DRAW7='0'and
                DRAW8='0' AND DRAW9='0' and DRAW10='0' AND DRAW11='0' and DRAW12='0' AND DRAW13='0' and DRAW14='0'and
                DRAW15='0' AND DRAW16='0' and DRAW17='0' AND DRAW18='0' and DRAW19='0' AND DRAW20='0' and DRAW21='0'
                and DRAWco1='0' and DRAWco2='0' and drawtake_b='0' and
                DRAW22='0' AND drawfin='0' and DRAW23='0' and DRAW24='0' AND DRAW25='0' and DRAW26='0' AND DRAW27='0' 
                and DRAW28='0' and drawd='0' and drawa='0' and DRAWset='0' and w_quo2='0'and w_quo1='0') THEN
                  color<=0;
                END IF;
                
        
        







    IF (HPOS<800)THEN
        HPOS <= HPOS +1;--change row
    ELSE
        HPOS <= 0;
        IF(VPOS<525) THEN--change column
            VPOS<= VPOS+ 1;
        ELSE 
            VPOS<=0;
        END IF;
    END IF;
        
    IF (HPOS> 16 AND HPOS< 112) THEN
        HSYNC <= '0';
    ELSE
        HSYNC <= '1';
    END IF;
    
    IF (VPOS> 0 AND VPOS< 12) THEN
        VSYNC <= '0';
    ELSE
        VSYNC <= '1';
    END IF;
    
    IF ((HPOS>0 AND HPOS< 160)OR (VPOS>0 AND VPOS<45)) THEN
        color<=0;
    END IF;
 END IF;
 END PROCESS;   
 
Colors_Numbers: process(color) begin
    case color is
        when 0 => -- black
            R <= "0000";
            G <= "0000";
            B <= "0000";
        when 1 => -- white
            R <= "1111";
            G <= "1111";
            B <= "1111";
            when 2 => -- red
            R <= "1111";
            G <= "0000";
            B <= "0000";
            
            when 3 => -- cyan
            R <= "0000";
            G <= "1111";
            B <= "1111";
            
            when 4 => -- magenta
            R <= "1111";
            G <= "1111";
            B <= "0000";
            
            when others => -- black
            R <= (OTHERS =>'0');
            G <= (OTHERS =>'0');
            B <= (OTHERS =>'0');
            
     end case;end process;
end MAIN;