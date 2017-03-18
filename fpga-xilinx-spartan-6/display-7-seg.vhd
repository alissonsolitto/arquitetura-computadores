library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity segmento is
port(
     CLK  : IN STD_LOGIC;	  
	  seg  : OUT STD_LOGIC_VECTOR(0 TO 7);
	  sw   : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
     an   : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
end segmento;

architecture Behavioral of segmento is
SIGNAL CONT: INTEGER RANGE 0 TO 100000001;
SIGNAL CONTDISPLAY: INTEGER RANGE 0 TO 15;
SIGNAL CONTDISPLAY1: INTEGER RANGE 0 TO 15;
SIGNAL CONTDISPLAY2: INTEGER RANGE 0 TO 15;
SIGNAL CONTDISPLAY3: INTEGER RANGE 0 TO 15;
begin
an <= "0000";
	PROCESS(CLK)
	BEGIN
	  IF CLK'EVENT AND CLK='1' THEN
	  
	    CONT <= CONT + 1;
		 
		 IF(CONT = 100000000) THEN
  		   CONTDISPLAY <= CONTDISPLAY + 1;
			
		 ELSIF (CONT = 50000000) THEN	
		 CONTDISPLAY1 <= CONTDISPLAY1 + 1;
		 
		 ELSIF (CONT = 5000000) THEN	
		 CONTDISPLAY2 <= CONTDISPLAY2 + 1;
		 
		 ELSIF (CONT = 500000) THEN	
		 CONTDISPLAY3 <=CONTDISPLAY3 + 1;
				 
	    END IF;		
	    
		  CASE CONTDISPLAY IS
			 WHEN 0 => seg <= "00000011"; an <= "0111"; -- '0'
			 WHEN 1 =>seg <= "10011111"; an <= "0111"; -- '1'
			 WHEN 2 =>seg <= "00100101"; an <= "0111"; -- '2'
			 WHEN 3 =>seg <= "00001101"; an <= "0111"; -- '3'
			 WHEN 4 =>seg <= "10011001"; an <= "0111"; -- '4'
			 WHEN 5 =>seg <= "01001001"; an <= "0111"; -- '5'
			 WHEN 6 =>seg <= "01000001"; an <= "0111"; -- '6'
			 WHEN 7 =>seg <= "00011111"; an <= "0111"; -- '7'
			 WHEN 8 =>seg <= "00000001"; an <= "0111"; -- '8'
			 WHEN 9 =>seg <= "00001001"; an <= "0111"; -- '9'
			 WHEN 10 =>seg <= "00010001"; an <= "0111"; -- 'A'
			 WHEN 11 =>seg <= "11000001"; an <= "0111"; -- 'B'
		 	 WHEN 12 =>seg <= "01100011"; an <= "0111"; -- 'C'
	 		 WHEN 13 =>seg <= "10000101"; an <= "0111";  -- 'D'
			 WHEN 14 =>seg <= "01100001"; an <= "0111"; -- 'E'
			 WHEN 15 =>seg <= "01110001"; an <= "0111"; -- 'F'
			 WHEN OTHERS => seg <= "11111111"; an <= "0111";
		 END CASE;	 
			 
		  CASE CONTDISPLAY1 IS
			 WHEN 0 => seg <= "00000011"; an <= "1011"; -- '0'
			 WHEN 1 =>seg <= "10011111"; an <= "1011"; -- '1'
			 WHEN 2 =>seg <= "00100101"; an <= "1011"; -- '2'
			 WHEN 3 =>seg <= "00001101"; an <= "1011"; -- '3'
			 WHEN 4 =>seg <= "10011001"; an <= "1011"; -- '4'
			 WHEN 5 =>seg <= "01001001"; an <= "1011"; -- '5'
			 WHEN 6 =>seg <= "01000001"; an <= "1011"; -- '6'
			 WHEN 7 =>seg <= "00011111"; an <= "1011"; -- '7'
			 WHEN 8 =>seg <= "00000001"; an <= "1011"; -- '8'
			 WHEN 9 =>seg <= "00001001"; an <= "1011"; -- '9'
			 WHEN 10 =>seg <= "00010001"; an <= "1011"; -- 'A'
			 WHEN 11 =>seg <= "11000001"; an <= "1011"; -- 'B'
		 	 WHEN 12 =>seg <= "01100011"; an <= "1011"; -- 'C'
	 		 WHEN 13 =>seg <= "10000101"; an <= "1011";  -- 'D'
			 WHEN 14 =>seg <= "01100001"; an <= "1011"; -- 'E'
			 WHEN 15 =>seg <= "01110001"; an <= "1011"; -- 'F'
			 WHEN OTHERS => seg <= "11111111"; an <= "1011";	
			 END CASE;

			CASE CONTDISPLAY2 IS
			 WHEN 0 => seg <= "00000011"; an <= "1101"; -- '0'
			 WHEN 1 =>seg <= "10011111"; an <= "1101"; -- '1'
			 WHEN 2 =>seg <= "00100101"; an <= "1101"; -- '2'
			 WHEN 3 =>seg <= "00001101"; an <= "1101"; -- '3'
			 WHEN 4 =>seg <= "10011001"; an <= "1101"; -- '4'
			 WHEN 5 =>seg <= "01001001"; an <= "1101"; -- '5'
			 WHEN 6 =>seg <= "01000001"; an <= "1101"; -- '6'
			 WHEN 7 =>seg <= "00011111"; an <= "1101"; -- '7'
			 WHEN 8 =>seg <= "00000001"; an <= "1101"; -- '8'
			 WHEN 9 =>seg <= "00001001"; an <= "1101"; -- '9'
			 WHEN 10 =>seg <= "00010001"; an <= "1101"; -- 'A'
			 WHEN 11 =>seg <= "11000001"; an <= "1101"; -- 'B'
		 	 WHEN 12 =>seg <= "01100011"; an <= "1101"; -- 'C'
	 		 WHEN 13 =>seg <= "10000101"; an <= "1101";  -- 'D'
			 WHEN 14 =>seg <= "01100001"; an <= "1101"; -- 'E'
			 WHEN 15 =>seg <= "01110001"; an <= "1101"; -- 'F'
			 WHEN OTHERS => seg <= "11111111"; an <= "1101";
END CASE;			 
			 
		  CASE CONTDISPLAY3 IS
			 WHEN 0 => seg <= "00000011"; an <= "1110"; -- '0'
			 WHEN 1 =>seg <= "10011111"; an <= "1110"; -- '1'
			 WHEN 2 =>seg <= "00100101"; an <= "1110"; -- '2'
			 WHEN 3 =>seg <= "00001101"; an <= "1110"; -- '3'
			 WHEN 4 =>seg <= "10011001"; an <= "1110"; -- '4'
			 WHEN 5 =>seg <= "01001001"; an <= "1110"; -- '5'
			 WHEN 6 =>seg <= "01000001"; an <= "1110"; -- '6'
			 WHEN 7 =>seg <= "00011111"; an <= "1110"; -- '7'
			 WHEN 8 =>seg <= "00000001"; an <= "1110"; -- '8'
			 WHEN 9 =>seg <= "00001001"; an <= "1110"; -- '9'
			 WHEN 10 =>seg <= "00010001"; an <= "1110"; -- 'A'
			 WHEN 11 =>seg <= "11000001"; an <= "1110"; -- 'B'
		 	 WHEN 12 =>seg <= "01100011"; an <= "1110"; -- 'C'
	 		 WHEN 13 =>seg <= "10000101"; an <= "1110";  -- 'D'
			 WHEN 14 =>seg <= "01100001"; an <= "1110"; -- 'E'
			 WHEN 15 =>seg <= "01110001"; an <= "1110"; -- 'F'
			 WHEN OTHERS => seg <= "11111111"; an <= "1110";				 
			 
		  END CASE;
		  
		  an <= "0000";
		  
	  END IF;	
	END PROCESS;
	

end Behavioral;