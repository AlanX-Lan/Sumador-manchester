library ieee;                          -- biblioteca estándar
use ieee.std_logic_1164.all;           -- librería de tipos de datos
use ieee.numeric_std.all;              -- librería para operaciones numéricas

entity sumador_man is                   -- declaración de la entidad sumador_man
  port(a, b: in std_logic_vector(3 downto 0);  -- entradas a y b de 4 bits
       s: out std_logic_vector(3 downto 0);     -- salida s de 4 bits
       c_out: out std_logic);                   -- salida c_out de 1 bit
end sumador_man;

architecture behavioral of sumador_man is    -- declaración de la arquitectura
  signal c_int: std_logic;                   -- señal auxiliar c_int de 1 bit

  signal a_m: std_logic_vector(7 downto 0);  -- señal auxiliar a_m de 8 bits
  signal b_m: std_logic_vector(7 downto 0);  -- señal auxiliar b_m de 8 bits
  signal s_m: std_logic_vector(7 downto 0);  -- señal auxiliar s_m de 8 bits
  signal c_int_m: std_logic_vector(7 downto 0);  -- señal auxiliar c_int_m de 8 bits
  signal c_out_m: std_logic_vector(7 downto 0);  -- señal auxiliar c_out_m de 8 bits
  
begin
  a_m <= a & not a;  -- complemento a 2 de a
  b_m <= b & not b;  -- complemento a 2 de b
  
  s_m <= std_logic_vector(unsigned(a_m) + unsigned(b_m) + unsigned(c_int_m)); -- suma de a_m, b_m y c_int_m
  
  process(s_m, c_int_m)   -- proceso que se ejecuta cuando hay un cambio en s_m o c_int_m
  begin
    c_int_m(0) <= '0';    -- inicialización de c_int_m(0)
    for i in 1 to 7 loop   -- loop para calcular los demás bits de c_int_m
      if s_m(i) = '0' then -- si s_m(i) es 0, se mantiene el valor anterior de c_int_m
        c_int_m(i) <= c_int_m(i-1);
      else                  -- si s_m(i) es 1, se calcula el valor complementario de c_int_m(i-1)
        c_int_m(i) <= not c_int_m(i-1);
      end if;
    end loop;
  end process;
  
  s <= s_m(3 downto 0);   -- asignación de los 4 bits menos significativos de s a la señal s_m
  c_out <= c_int_m(7);    -- asignación del bit más significativo de c_int_m a la señal c_out
  
end behavioral;            -- fin de la arquitectura