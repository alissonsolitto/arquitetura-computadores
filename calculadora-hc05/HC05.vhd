LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY HC05 IS
    PORT ( CLK  : IN  STD_LOGIC;
           RST  : IN  STD_LOGIC;		   
           ENTER: IN STD_LOGIC;           
           OPER : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
           NUM  : IN STD_LOGIC_VECTOR (3 DOWNTO 0);           
           DOUT : IN  STD_LOGIC_VECTOR (7 DOWNTO 0);		   
           ADDR : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
           RW   : OUT STD_LOGIC;
           DIN  : OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
		   AN   : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
		   SEG  : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
           LED  : OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
END HC05;

ARCHITECTURE BEHAVIORAL OF HC05 IS
--MAQUINA DE ESTADO
SIGNAL ESTADO: STD_LOGIC_VECTOR (2 DOWNTO 0);


--ESTADOS - CONSTANTES
SIGNAL RESET1    : STD_LOGIC_VECTOR (2 DOWNTO 0) := "000";
SIGNAL RESET2    : STD_LOGIC_VECTOR (2 DOWNTO 0) := "001";
SIGNAL BUSCA     : STD_LOGIC_VECTOR (2 DOWNTO 0) := "010";
SIGNAL DECODIFICA: STD_LOGIC_VECTOR (2 DOWNTO 0) := "011";
SIGNAL EXECUTA   : STD_LOGIC_VECTOR (2 DOWNTO 0) := "100";

--REGISTRADORES

SIGNAL REG_DISPLAY     : STD_LOGIC_VECTOR (7 DOWNTO 0);
SIGNAL CONTTROCA : INTEGER RANGE 0 TO 1;
SIGNAL CONTDISP : INTEGER RANGE 0 TO 2;
SIGNAL REG_DISPLAY_INT : INTEGER RANGE 0 TO 256;
SIGNAL DISPLAY         : INTEGER RANGE 0 TO 9;

SIGNAL A  : STD_LOGIC_VECTOR (7 DOWNTO 0);
SIGNAL B  : STD_LOGIC_VECTOR (7 DOWNTO 0);
SIGNAL X  : STD_LOGIC_VECTOR (7 DOWNTO 0);
SIGNAL PC : STD_LOGIC_VECTOR (7 DOWNTO 0);
SIGNAL PC_AUX : STD_LOGIC_VECTOR (7 DOWNTO 0);

--código da instruçao(RI)
SIGNAL OPCODE : STD_LOGIC_VECTOR (7 DOWNTO 0);

SIGNAL FASE : STD_LOGIC_VECTOR (2 DOWNTO 0);

BEGIN
	ADDR <= PC;	
	
	PROCESS(CLK, RST)		
	BEGIN
	  IF RST='1' THEN 
	   REG_DISPLAY <= (OTHERS => '0');		

		CONTTROCA <= 0;
		CONTDISP <= 0;
		REG_DISPLAY_INT <= 0;
		DISPLAY         <= 0;
		
		A      <= (OTHERS => '0');
        B      <= (OTHERS => '0');
		X      <= (OTHERS => '0');
		PC     <= (OTHERS => '0');
		ESTADO <= (OTHERS => '0');
		OPCODE <= (OTHERS => '0');
		FASE   <= (OTHERS => '0');
		SEG    <= (OTHERS => '0');
		AN     <= (OTHERS => '1');
		LED    <= (OTHERS => '0');
		
	  ELSIF CLK'EVENT AND CLK='1' THEN
	    --MAQUINA DE ESTADO	
        CASE ESTADO IS
        WHEN RESET1 => 			   
          PC <= (OTHERS => '0');
          RW <= '0'; -- LEITURA
          ESTADO <= RESET2;        
        WHEN RESET2 => 
          ESTADO <= BUSCA;
        WHEN BUSCA => 
          OPCODE <= DOUT; -- LEITURA DE INSTRUÇAO
          ESTADO <= DECODIFICA;          
        WHEN DECODIFICA =>
          CASE OPCODE IS
            WHEN "01001100" =>  --4C (INC A)
              A <= A + 1;
              ESTADO <= EXECUTA;
            WHEN "01001010" =>  --4A (DEC A)
              A <= A - 1;
              ESTADO <= EXECUTA;						
            WHEN "10101011" => -- AB (ADD #VALOR)
              IF(FASE = "000")THEN --BUSCA VALOR DA MEMORIA
                PC <= PC + 1;
                FASE <= "001";
              ELSE
                A <= A + DOUT;
                ESTADO <= EXECUTA;
              END IF;					
            WHEN "10100110" => --A6 - LOAD CARREGA VALOR
              IF(FASE = "000")THEN --BUSCA VALOR DA MEMORIA
                PC <= PC + 1;
                FASE <= "001";
              ELSE
                A <= DOUT;
                ESTADO <= EXECUTA;
              END IF;	              
            WHEN "00100000" => -- JMP 20
              IF(FASE = "000")THEN --BUSCA VALOR DA MEMORIA
                PC <= PC + 1;
                FASE <= "001";
              ELSE
                PC <= DOUT - 1;
                ESTADO <= EXECUTA;
              END IF;              
            WHEN "00100111" => -- JMP ZERO 27
              IF(FASE = "000")THEN --BUSCA VALOR DA MEMORIA
                PC <= PC + 1;
                FASE <= "001";
              ELSE
                IF(A = "00000000") THEN
                  PC <= DOUT - 1;
                END IF;	                  
                ESTADO <= EXECUTA;
              END IF;              
            WHEN "10110111" => -- STA GRAVA VALOR NA MEMORIA
              IF(FASE = "000")THEN --BUSCA VALOR DA MEMORIA
                PC <= PC + 1;
                FASE <= "001";
              ELSIF(FASE = "001")THEN
                PC_AUX <= PC;
                PC <= DOUT;
                RW <= '1';
                DIN <= A;
                FASE <= "010";
              ELSIF(FASE = "010")THEN
                PC <= PC_AUX;							
                RW <= '0';
                ESTADO <= EXECUTA;
              END IF;
            WHEN "10100001" => -- A1 -- LE O NUMERO 1
              IF(FASE = "000")THEN
                
					 IF(ENTER = '1') THEN
                  A <= "0000" & NUM;
						FASE <= "001";
                END IF;
              
              ELSIF(FASE = "001") THEN
                IF(ENTER = '0') THEN
                  ESTADO <= EXECUTA;
                END IF;              
              END IF;             
            WHEN "10100010" => -- A2 - LE O NUMERO 2
              IF(FASE = "000")THEN                
                IF(ENTER = '1') THEN
                  B <= "0000" & NUM;
						FASE <= "001";
                END IF;
              
              ELSIF(FASE = "001") THEN
                IF(ENTER = '0') THEN
                  ESTADO <= EXECUTA;
                END IF;              
              END IF;  
            WHEN "10100011" => -- A3 - LE O OPERADOR
              IF(FASE = "000")THEN
                
                IF(ENTER = '1') THEN
					   X <= "000000" & OPER;
						FASE <= "001";
                END IF;
              
              ELSIF(FASE = "001") THEN
                IF(ENTER = '0') THEN                  
                  ESTADO <= EXECUTA;                  
                END IF;              
              END IF;    
         
            WHEN "10111011" => -- BB - EFETUA A OPERACAO
					
					IF(X = "00000000") THEN -- SOMA						
						REG_DISPLAY <= A + B;
					
					ELSIF (X = "00000001") THEN -- SUB
						REG_DISPLAY <= A - B;
					
					ELSIF (X = "00000010") THEN -- DIV 2
						REG_DISPLAY <= '0' & A(7 DOWNTO 1);
					
					ELSIF (X = "00000011") THEN -- MULT 2
						REG_DISPLAY <= A(6 DOWNTO 0) & '0';
					END IF;
					
					ESTADO <= EXECUTA;

				WHEN "11001100" => -- CC - MOSTRA VALOR NO DISPLAY
				
				  REG_DISPLAY_INT <= TO_INTEGER(UNSIGNED(REG_DISPLAY));
				  
				  IF(REG_DISPLAY_INT < 10) THEN				  
					DISPLAY <= REG_DISPLAY_INT;
					AN <= "1110";					 
				  ELSIF (REG_DISPLAY_INT >= 10) AND (REG_DISPLAY_INT < 20) THEN				  
					CONTTROCA <= CONTTROCA + 1;					
					IF(CONTTROCA = 0)THEN
					   AN <="1110";								
						DISPLAY <= 1;
					ELSIF(CONTTROCA = 1)THEN
						AN <="1101";
						DISPLAY <= REG_DISPLAY_INT - 10;						
					END IF;	
				  ELSIF (REG_DISPLAY_INT >= 20) AND (REG_DISPLAY_INT < 30) THEN
					CONTTROCA <= CONTTROCA + 1;					
					IF(CONTTROCA = 0)THEN
					   AN <="1110";								
						DISPLAY <= 2;
					ELSIF(CONTTROCA = 1)THEN
						AN <="1101";
						DISPLAY <= REG_DISPLAY_INT - 20;
					END IF;		
				  ELSIF (REG_DISPLAY_INT >= 30) THEN
					CONTTROCA <= CONTTROCA + 1;					
					IF(CONTTROCA = 0)THEN
					   AN <="1110";								
						DISPLAY <= 3;
					ELSIF(CONTTROCA = 1)THEN
						AN <="1101";
						DISPLAY <= REG_DISPLAY_INT - 30;
					END IF;					
					
				  END IF;
				  
				  CASE DISPLAY IS 
				    WHEN 0 => SEG <= "1000000"; 
				    WHEN 1 => SEG <= "1111001"; 
				    WHEN 2 => SEG <= "0100100"; 
				    WHEN 3 => SEG <= "0110000";
				    WHEN 4 => SEG <= "0011001";
				    WHEN 5 => SEG <= "0010010";
				    WHEN 6 => SEG <= "0000010";
				    WHEN 7 => SEG <= "1111000";
				    WHEN 8 => SEG <= "0000000";
				    WHEN 9 => SEG <= "0010000";
				    WHEN OTHERS => SEG <= "1010101";
				  END CASE; 
				  
            WHEN OTHERS => NULL;
          END CASE;
			 
        WHEN EXECUTA =>
          FASE <= "000";
          ESTADO <= BUSCA;          
          PC <= PC + 1;
			 
        WHEN OTHERS => NULL;
          
      END CASE;
      
	  END IF;	
    
	END PROCESS;

END BEHAVIORAL;