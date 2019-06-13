pragma solidity ^0.5.0;

import "./ERC20.sol";
import "../node_modules/openzeppelin-solidity/contracts/math/SafeMath.sol";
import "../node_modules/openzeppelin-solidity/contracts/ownership/Ownable.sol";


contract Token is ERC20, Ownable {
    using SafeMath for uint256;

    

    mapping (address => uint256) private _balances;
    mapping (address => mapping (address => uint256)) private _allowances;
    event Transfer(address indexed sender, address indexed recipient, uint256 amount);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    
    string public _symbol;
    string public _name;
    uint8 public _decimals;
    uint256 public _RATE;
    uint256 internal _totalSupply;
    
     function getName( ) public view returns(string memory) {
        return _name;
    }function getSymbol() public view returns(string memory) {
        return _symbol;
    }function getDecimals() public view returns(uint8) {
        return _decimals;
    }function getRATE() public view returns(uint256) {
        return _RATE;
    }
     function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }
    
    function myAddress() public view returns(address){
        return msg.sender;
    }
    

    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }

    function transfer(address recipient, uint256 amount) public returns (bool) {
        _transfer(msg.sender, recipient, amount);
        return true;
    }

    function allowance(address owner, address spender) public view returns (uint256) {
        return _allowances[owner][spender];
    }

    function approve(address spender, uint256 value) public returns (bool) {
        _approve(msg.sender, spender, value);
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) public returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(sender, msg.sender, _allowances[sender][msg.sender].sub(amount));
        return true;
    }

    function increaseAllowance(address spender, uint256 addedValue) public returns (bool) {
        _approve(msg.sender, spender, _allowances[msg.sender][spender].add(addedValue));
        return true;
    }
    function decreaseAllowance(address spender, uint256 subtractedValue) public returns (bool) {
        _approve(msg.sender, spender, _allowances[msg.sender][spender].sub(subtractedValue));
        return true;
    }
    function _transfer(address sender, address recipient, uint256 amount) internal {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");

        _balances[sender] = _balances[sender].sub(amount);
        _balances[recipient] = _balances[recipient].add(amount);
        emit Transfer(sender, recipient, amount);
    }

    function createTokens(uint256 amount)public onlyOwner  {
         _totalSupply = _totalSupply + amount;
         _balances[msg.sender] = _balances[msg.sender].add(amount);
       }

    function _approve(address owner, address spender, uint256 value) internal {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = value;
        emit Approval(owner, spender, value);
    }
    function ICO (string memory symbol,string memory name,uint8 decimals,uint256 RATE) public onlyOwner  {
           _symbol = symbol;
           _name = name;
           _decimals = decimals;
        _RATE = RATE;
       }

}