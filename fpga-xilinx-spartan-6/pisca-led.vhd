
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;



entity pisca is
    Port ( clk : in  STD_LOGIC;
           led : out  STD_LOGIC);
end pisca;

architecture Behavioral of pisca is
--contador
signal cont: integer range 0 to 100000001;
begin

  process (clk) -- 100Mhz
  begin
     if clk'event and clk='1' then
	     cont <= cont+1;
		  if cont <= 50000000 then
		     led <= '0';
		  else
		  led <= '1';
		  end if;
		  if cont = 10000000 then
		  cont <=0;
		  end if;
		  
	  end if;
	  end process;

end Behavioral;

