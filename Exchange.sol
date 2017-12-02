 pragma solidity ^0.4.5;
contract Exchange
{
    //token wallet
    uint [3] tokenAmount;
    
    //node for transactions
    struct Transaction
    {
        address sender;
        uint8 currencyFrom;
        uint8 currencyTo;
        uint valueFrom;
    }
    
    //two different array for local testing machine
    Transaction [] transactions;
    uint [] endBlock;
    
    //coef Tokens to BTC
    uint [3] btcToken;
    
    //queue node
    struct Debt
    {
       address sender;
       uint8 currencyFrom;
       uint valueFrom;
       uint EndBlock;
    }
    
    //queue on 2 arrays
    struct Queue
    {
        Debt [] front;
        Debt [] back;
    }
    
    //queues for Tokens
    Queue [3] Debts;
    
    //receive transaction
    function transfer(uint8 currencyFrom, uint8 currencyTo, uint valueFrom, uint Block)
    {
        if(currencyFrom > 2 || currencyTo > 2) //check whether he send me money on token
            return;
        transactions.push(Transaction(msg.sender, currencyFrom, currencyTo, valueFrom));
        Debts[currencyTo].back.push(Debt(msg.sender, currencyFrom, valueFrom, endBlock.length));
        endBlock.push(Block);
        tokenAmount[currencyFrom] += valueFrom;
        while(Debts[currencyFrom].front.length != 0|| Debts[currencyFrom].back.length != 0)
        {
            if(Debts[currencyFrom].front.length == 0)
            {
                while(Debts[currencyFrom].back.length != 0)
                {
                    Debts[currencyFrom].front.push(Debts[currencyFrom].back[Debts[currencyFrom].back.length - 1]);
                    delete Debts[currencyFrom].back[Debts[currencyFrom].back.length - 1];
                }
            }
            while(Debts[currencyFrom].front.length != 0 && tokenAmount[currencyFrom] >=
            Debts[currencyFrom].front[Debts[currencyFrom].front.length - 1].valueFrom * 
            btcToken[Debts[currencyFrom].front[Debts[currencyFrom].front.length - 1].currencyFrom] / 
            btcToken[currencyFrom])
            {
                
            }
        }
    }
    
    
}
