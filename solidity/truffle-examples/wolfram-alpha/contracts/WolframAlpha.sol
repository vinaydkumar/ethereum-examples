pragma solidity >= 0.5.0 < 0.6.0;

import "./oraclizeAPI.sol";

contract WolframAlpha is usingOraclize {

    string public temperature;

    event LogNewOraclizeQuery(string description);
    event LogNewTemperatureMeasure(string temperature);

    constructor()
        public
    {
        update(); // Update on contract creation...
    }

    function __callback(
        bytes32 _myid,
        string memory _result
    )
        public
    {
        require(msg.sender == oraclize_cbAddress());
        temperature = _result;
        emit LogNewTemperatureMeasure(temperature);
        // Do something with the temperature measure...
    }

    function update()
        public
        payable
    {
        emit LogNewOraclizeQuery("Oraclize query was sent, standing by for the answer...");
        oraclize_query("WolframAlpha", "temperature in London");
    }
}
