library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_fixed_mul_pipe2 is
end tb_fixed_mul_pipe2;

architecture Behavioral of tb_fixed_mul_pipe2 is
    signal clk_tb    : STD_LOGIC := '0';
    signal a_tb      : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal b_tb      : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
    signal result_tb : STD_LOGIC_VECTOR(15 downto 0);
    constant CLK_PERIOD : time := 10 ns; -- 100 MHz
begin
    uut: entity work.fixed_mul_pipe2
        port map (
            clk    => clk_tb,
            a      => a_tb,
            b      => b_tb,
            result => result_tb
        );

    -- Pembangkit clock 100 MHz
    clk_proc: process
    begin
        clk_tb <= '0'; wait for CLK_PERIOD / 2;
        clk_tb <= '1'; wait for CLK_PERIOD / 2;
    end process;

    stim_proc: process
    begin
        wait for 20 ns;
        -- Berikan stimulus beruntun setiap siklus clock (throughput tinggi)
        a_tb <= x"0200"; b_tb <= x"0300"; -- Uji 1 (2.0 x 3.0)
        wait for CLK_PERIOD;
        a_tb <= x"0180"; b_tb <= x"0280"; -- Uji 2 (1.5 x 2.5)
        wait for CLK_PERIOD;
        a_tb <= x"0440"; b_tb <= x"0140"; -- Uji 3 (4.25 x 1.25)
        wait for CLK_PERIOD;

        -- Tunggu latency selesai
        wait for 30 ns;
        report "Simulasi Pipeline 2-Tahap Selesai!" severity note;
        wait;
    end process;
end Behavioral;