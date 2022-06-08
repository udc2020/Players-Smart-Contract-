// SPDX-License-Identifier: Unlicensed 

pragma solidity >= 0.7.0 < 0.9.0 ;


contract Players {
    
    // Owner (MAN City)
    address private  owner ;

    // event 
    event LogPlayers (address addr, uint amount,uint balanceContract);

    // init owaner 
    constructor (){
        // msg.sender it mean address of this contract 
        owner = msg.sender;
    }

    // Players Schema 

    struct Player{
        address payable walletPlayer ;
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

    // Create Modifier
    modifier onlyOwner(){
        require (msg.sender == owner,"prmetion for owner");
        _;
    }

    // Create function that add players to Array (all them)
    // params must have the same of the players struct 
    // just push the array with type Player 
    function addNewPlayer   (
        address payable walletPlayer ,
         string memory playerName ,
          uint releaseTime,
          uint amount,
          bool isAvailable
        ) public onlyOwner {

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
    function addToPlayerWAllet (address wallet ) private onlyOwner {
            uint i = getIndex(wallet);
            players[i].amount  += msg.value;

            emit LogPlayers(wallet,msg.value,balanceOf());

    }

    // make indexer (getindex)
    function getIndex(address wallet ) view private returns(uint)  {
        for (uint i =0;i<players.length;i++ ){
            if ( players[i].walletPlayer == wallet ){
                return i;
            }
        }
        return 999;
    }

    // check if withdrow is available 
    function withdrowIsAvailable( address wallet )public returns(bool) {
        uint i  =getIndex(wallet);
        require( block.timestamp > players[i].releaseTime , "You cannot withdrow Now"); 

        if ( block.timestamp > players[i].releaseTime  ){
            players[i].isAvailable = true;
            return true;
        }
        else{
            return false;
        }
    }

    // withdrow 
    function withdrow ( address payable wallet ) public payable {
        uint i = getIndex(wallet);

        require( msg.sender == players[i].walletPlayer ,"You Must be Player to withdrow");
        require ( players[i].isAvailable == true,"You Can Withdrow Now!" );

        players[i].walletPlayer
            .transfer( players[i].amount );
    }

}

/*
0x5B38Da6a701c568545dCfcB03FcB875f56beddC4 owner 

0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2,Messi,1654697820,0,false

0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db,ronaldo,1654692031,0,false

*/