// SPDX-License-Identifier: Unlicensed 

pragma solidity >= 0.7.0 < 0.9.0 ;


contract Players {
    
    // Owner (MAN City)
    address private  owner ;

    // init owaner 
    constructor (){
        // msg.sender it mean address of this contract 
        owner = msg.sender;
    }

    // Players Schema 

    struct Player{
        address walletPlayer ;
        string  playerName;
        uint releaseTime ;
        uint amount ;
        bool isAvailable;
    }

    // Put All Players in Array 
    /*
        type must be Player,
        make it public 
    */

    Player[] public players ;

    // Create function that add players to Array (all them)
    // params must have the same of the players struct 
    // just push the array with type Player 
    function addNewPlayer   (
        address walletPlayer ,
         string memory playerName ,
          uint releaseTime,
          uint amount,
          bool isAvailable
        ) public {

            players.push(Player(
                walletPlayer,
                playerName,
                releaseTime,
                amount,
                isAvailable
            ));

    }


    // balance is pablic  
    function balanceOf () public view returns  (uint) {
        return address(this).balance ;
    }

    // deposit funds to contract 
    // is payable & public 
    function deposit (address wallet) payable public   {
        addToPlayerWAllet(wallet);
    }

    // add funds to players 
    function addToPlayerWAllet (address wallet ) private {
        for (uint i =0;i<players.length;i++){
            if (players[i].walletPlayer == wallet){
                players[i].amount  += msg.value;
            }


        }

    }


}

/*
0x5B38Da6a701c568545dCfcB03FcB875f56beddC4 owner 

0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2,Messi,1654618180,0,false

0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db,ronaldo,1654618280,0,false


*/