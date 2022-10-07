// Code based on Hadcoins ICO https://github.com/hagenderouen/mini-chain/blob/master/hadcoins_ico.sol

// Version of compiler
pragma solidity ^0.5.0;

contract jocoin_ico {

    // Imprimindo o número máximo de jocoins à venda
    uint public max_jocoins = 1000000;

    // Imprimindo a taxa de conversão de USD para jocoins
    uint public usd_to_hadcoins = 1000;

    // Imprimindo o número total de jocoins que foram comprados por investidores
    uint public total_hadcoins_bought = 0;

    // Mapeamento do endereço do investidor para seu patrimônio em jocoins para USD
    mapping(address => uint) equity_hadcoins;
    mapping(address => uint) equity_usd;

    // Verificando se um investidor pode comprar jocoins
    modifier can_buy_hadcoins(uint usd_invested) {
        require (usd_invested * usd_to_hadcoins + total_hadcoins_bought <= max_hadcoins);
        _;
    }

    // Obtendo o patrimônio em jocoins de um investidor
    function equity_in_hadcoins(address investor) external view returns (uint) {
        return equity_hadcoins[investor];
    }

    // Obtendo o patrimônio em dólares de um investidor
    function equity_in_usd(address investor) external view returns (uint) {
        return equity_usd[investor];
    }

    // Comprando jocoins
    function buy_hadcoins(address investor, uint usd_invested) external
    can_buy_hadcoins(usd_invested) {
        uint hadcoins_bought = usd_invested * usd_to_hadcoins;
        equity_hadcoins[investor] += hadcoins_bought;
        equity_usd[investor] = equity_hadcoins[investor] / 1000;
        total_hadcoins_bought += hadcoins_bought;
    }

    // Vendendo jocoins
    function sell_hadcoins(address investor, uint hadcoins_sold) external {
        equity_hadcoins[investor] -= hadcoins_sold;
        equity_usd[investor] = equity_hadcoins[investor] / 1000;
        total_hadcoins_bought -= hadcoins_sold;
    }
}
