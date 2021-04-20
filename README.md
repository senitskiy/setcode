0 1 2 32

128 129 130 160

64 65 66 96

Possible values of parameter flag:

0 - carries funds equal to parameter value to destination. Forward fee is subtracted from parameter value.
128 - carries all the remaining balance of the current smart contract. Parameter value is ignored. The contract's balance will be equal to zero.
64 - carries funds equal to parameter value and all the remaining value of the inbound message.
Also parameter flag can be modified:

flag + 1 - means that the sender wants to pay transfer fees separately from contract's balance.
flag + 2 - means that any errors arising while processing this message during the action phase should be ignored.
flag + 32 - means that the current account must be destroyed if its resulting balance is zero. For example, flag: 128 + 32 used to send all balance and destroy the contract.

