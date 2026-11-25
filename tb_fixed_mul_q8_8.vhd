library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_fixed_mul_q8_8 is
end tb_fixed_mul_q8_8;

architecture Behavioral of tb_fixed_mul_q8_8 is
    signal a_tb      : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal b_tb      : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal result_tb : STD_LOGIC_VECTOR(15 downto 0);
begin
    uut: entity work.fixed_mul_q8_8
        port map (
            a      => a_tb,
            b      => b_tb,
            result => result_tb
        );

    stim_proc: process
    begin
        -- Uji 1: 2.0 (0x0200) x 3.0 (0x0300) = 6.0 (0x0600)
        a_tb <= x"0200"; b_tb <= x"0300";
        wait for 20 ns;
        assert (result_tb = x"0600")
            report "GAGAL Uji 1: 2.0 x 3.0 seharusnya 0x0600" severity error;

        -- Uji 2: 1.5 (0x0180) x 2.5 (0x0280) = 3.75 (0x03C0)
        a_tb <= x"0180"; b_tb <= x"0280";
        wait for 20 ns;
        assert (result_tb = x"03C0")
            report "GAGAL Uji 2: 1.5 x 2.5 seharusnya 0x03C0" severity error;

        -- Uji 3: 4.25 (0x0440) x 1.25 (0x0140) = 5.3125 (0x0550)
        a_tb <= x"0440"; b_tb <= x"0140";
        wait for 20 ns;
        assert (result_tb = x"0550")
            report "GAGAL Uji 3: 4.25 x 1.25 seharusnya 0x0550" severity error;

        report "Simulasi Kombinasional Selesai!" severity note;
        wait;
    end process;
end Behavioral;