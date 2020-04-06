----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.12.2018 23:05:32
-- Design Name: 
-- Module Name: fa - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ha is
    Port ( a : in STD_LOGIC_VECTOR (1 downto 0);
           sum : out STD_LOGIC;
           carry : out STD_LOGIC);
end ha;

architecture behavioral of ha is
begin
sum<=a(0) xor a(1);
carry<=(a(0) and a(1));

end Behavioral;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity fa is
    port(a:in std_logic_vector (2 downto 0);
         sum: out std_logic;
         carry: out std_logic);
end fa;

architecture beh of fa is
component ha is
Port( a : in STD_LOGIC_VECTOR (1 downto 0);
           sum : out STD_LOGIC;
           carry : out STD_LOGIC);
end component ha;
signal s1,s2,s3:std_logic;
begin
h1: ha port map(a(0)=>a(0),a(1)=>a(1),sum=>s1,carry=>s3);
h2: ha port map(a(0)=>s1,a(1)=>a(2),sum=>sum,carry=>s2);
carry<=s2 or s3;
end beh;



