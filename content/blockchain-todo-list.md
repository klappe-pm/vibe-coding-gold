---
publish: true
title: "Blockchain-Powered TODO List"
date: 2025-08-17
categories: ["Guides", "Absurd Solutions"]
tags: ["blockchain", "todo", "distributed", "web3", "smart-contracts"]
---

# Blockchain-Powered TODO List

## The Problem

Manage a simple list of tasks. Add items, mark them complete, delete them. Surely this doesn't need immutable distributed ledger technology... right?

## The Blockchain Solution

Why store TODO items in boring databases when you can harness the power of cryptocurrency technology for ultimate task management?

```solidity
// TodoBlockchain.sol - Smart Contract for Immutable Task Management
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract TodoBlockchain is Ownable, ReentrancyGuard {
    using Counters for Counters.Counter;
    
    // Event emissions for the blockchain
    event TodoCreated(uint256 indexed todoId, address indexed creator, string task, uint256 timestamp);
    event TodoCompleted(uint256 indexed todoId, address indexed completer, uint256 timestamp);
    event TodoUpdated(uint256 indexed todoId, address indexed updater, string newTask, uint256 timestamp);
    event TodoDeleted(uint256 indexed todoId, address indexed deleter, uint256 timestamp);
    event PriorityChanged(uint256 indexed todoId, Priority newPriority);
    event CategoryAssigned(uint256 indexed todoId, uint256 categoryId);
    
    enum Priority { LOW, MEDIUM, HIGH, CRITICAL, EMERGENCY }
    enum TodoStatus { PENDING, IN_PROGRESS, COMPLETED, CANCELLED }
    
    struct Todo {
        uint256 id;
        string task;
        string description;
        address creator;
        address assignee;
        TodoStatus status;
        Priority priority;
        uint256 categoryId;
        uint256 createdAt;
        uint256 updatedAt;
        uint256 completedAt;
        bytes32 hashProof;
        bool exists;
    }
    
    struct Category {
        uint256 id;
        string name;
        string description;
        bytes32 colorCode;
        address creator;
        bool isActive;
    }
    
    // State variables
    Counters.Counter private _todoIds;
    Counters.Counter private _categoryIds;
    
    mapping(uint256 => Todo) public todos;
    mapping(uint256 => Category) public categories;
    mapping(address => uint256[]) public userTodos;
    mapping(address => mapping(uint256 => bool)) public todoPermissions;
    
    // Gas optimization: pack booleans
    mapping(uint256 => bool) public todoExists;
    mapping(uint256 => bool) public categoryExists;
    
    // Advanced features
    mapping(uint256 => uint256) public todoDependencies; // Todo A depends on Todo B
    mapping(uint256 => uint256[]) public todoSubtasks;
    mapping(uint256 => string) public todoAttachments; // IPFS hashes
    mapping(uint256 => uint256) public todoDeadlines;
    
    // Gas fees for todo operations (because why not monetize task management?)
    uint256 public todoCreationFee = 0.001 ether;
    uint256 public todoUpdateFee = 0.0005 ether;
    uint256 public todoCompletionReward = 0.0002 ether;
    
    modifier todoExistsAndActive(uint256 _todoId) {
        require(todoExists[_todoId], "Todo does not exist");
        require(todos[_todoId].status != TodoStatus.CANCELLED, "Todo is cancelled");
        _;
    }
    
    modifier onlyTodoCreatorOrAssignee(uint256 _todoId) {
        Todo memory todo = todos[_todoId];
        require(
            msg.sender == todo.creator || 
            msg.sender == todo.assignee || 
            todoPermissions[msg.sender][_todoId],
            "Insufficient permissions"
        );
        _;
    }

    constructor() {
        // Create default categories
        createCategory("Personal", "Personal tasks and reminders", 0x3B82F6);
        createCategory("Work", "Professional and work-related tasks", 0xEF4444);
        createCategory("Shopping", "Items to purchase", 0x10B981);
        createCategory("Health", "Health and fitness related tasks", 0xF59E0B);
    }

    function createTodo(
        string memory _task,
        string memory _description,
        Priority _priority,
        uint256 _categoryId,
        address _assignee,
        uint256 _deadline
    ) public payable nonReentrant returns (uint256) {
        require(msg.value >= todoCreationFee, "Insufficient gas fee for todo creation");
        require(bytes(_task).length > 0, "Task cannot be empty");
        require(bytes(_task).length <= 280, "Task too long (max 280 characters)");
        require(_categoryId == 0 || categoryExists[_categoryId], "Invalid category");
        
        if (_assignee == address(0)) {
            _assignee = msg.sender;
        }
        
        _todoIds.increment();
        uint256 newTodoId = _todoIds.current();
        
        // Generate cryptographic proof of task integrity
        bytes32 hashProof = keccak256(abi.encodePacked(
            _task, 
            _description, 
            msg.sender, 
            block.timestamp,
            newTodoId
        ));
        
        Todo memory newTodo = Todo({
            id: newTodoId,
            task: _task,
            description: _description,
            creator: msg.sender,
            assignee: _assignee,
            status: TodoStatus.PENDING,
            priority: _priority,
            categoryId: _categoryId,
            createdAt: block.timestamp,
            updatedAt: block.timestamp,
            completedAt: 0,
            hashProof: hashProof,
            exists: true
        });
        
        todos[newTodoId] = newTodo;
        todoExists[newTodoId] = true;
        userTodos[msg.sender].push(newTodoId);
        
        if (_assignee != msg.sender) {
            userTodos[_assignee].push(newTodoId);
            todoPermissions[_assignee][newTodoId] = true;
        }
        
        if (_deadline > 0) {
            todoDeadlines[newTodoId] = _deadline;
        }
        
        emit TodoCreated(newTodoId, msg.sender, _task, block.timestamp);
        
        return newTodoId;
    }
    
    function completeTodo(uint256 _todoId) 
        public 
        payable 
        nonReentrant 
        todoExistsAndActive(_todoId) 
        onlyTodoCreatorOrAssignee(_todoId) 
    {
        Todo storage todo = todos[_todoId];
        require(todo.status != TodoStatus.COMPLETED, "Todo already completed");
        
        // Check if dependencies are completed
        if (todoDependencies[_todoId] != 0) {
            require(
                todos[todoDependencies[_todoId]].status == TodoStatus.COMPLETED,
                "Dependency not completed"
            );
        }
        
        todo.status = TodoStatus.COMPLETED;
        todo.completedAt = block.timestamp;
        todo.updatedAt = block.timestamp;
        
        // Reward user for completing task (gamification!)
        if (address(this).balance >= todoCompletionReward) {
            payable(msg.sender).transfer(todoCompletionReward);
        }
        
        emit TodoCompleted(_todoId, msg.sender, block.timestamp);
    }
    
    function updateTodo(
        uint256 _todoId,
        string memory _newTask,
        string memory _newDescription,
        Priority _newPriority
    ) public payable nonReentrant todoExistsAndActive(_todoId) onlyTodoCreatorOrAssignee(_todoId) {
        require(msg.value >= todoUpdateFee, "Insufficient gas fee for todo update");
        require(bytes(_newTask).length > 0, "Task cannot be empty");
        
        Todo storage todo = todos[_todoId];
        todo.task = _newTask;
        todo.description = _newDescription;
        todo.priority = _newPriority;
        todo.updatedAt = block.timestamp;
        
        emit TodoUpdated(_todoId, msg.sender, _newTask, block.timestamp);
    }
    
    function createCategory(
        string memory _name,
        string memory _description,
        bytes32 _colorCode
    ) public returns (uint256) {
        _categoryIds.increment();
        uint256 newCategoryId = _categoryIds.current();
        
        categories[newCategoryId] = Category({
            id: newCategoryId,
            name: _name,
            description: _description,
            colorCode: _colorCode,
            creator: msg.sender,
            isActive: true
        });
        
        categoryExists[newCategoryId] = true;
        
        return newCategoryId;
    }
    
    // Get user's todos (view function)
    function getUserTodos(address _user) public view returns (uint256[] memory) {
        return userTodos[_user];
    }
    
    // Get todo details with full metadata
    function getTodoDetails(uint256 _todoId) public view returns (
        string memory task,
        string memory description,
        address creator,
        address assignee,
        TodoStatus status,
        Priority priority,
        uint256 createdAt,
        uint256 completedAt,
        bytes32 hashProof
    ) {
        Todo memory todo = todos[_todoId];
        return (
            todo.task,
            todo.description,
            todo.creator,
            todo.assignee,
            todo.status,
            todo.priority,
            todo.createdAt,
            todo.completedAt,
            todo.hashProof
        );
    }
    
    // Advanced analytics
    function getUserCompletionRate(address _user) public view returns (uint256, uint256) {
        uint256[] memory userTodosList = userTodos[_user];
        uint256 completed = 0;
        uint256 total = userTodosList.length;
        
        for (uint256 i = 0; i < total; i++) {
            if (todos[userTodosList[i]].status == TodoStatus.COMPLETED) {
                completed++;
            }
        }
        
        return (completed, total);
    }
    
    // Owner functions
    function updateFees(
        uint256 _creationFee,
        uint256 _updateFee,
        uint256 _completionReward
    ) public onlyOwner {
        todoCreationFee = _creationFee;
        todoUpdateFee = _updateFee;
        todoCompletionReward = _completionReward;
    }
    
    function withdrawFees() public onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }
}
```

```typescript
// Frontend Integration with Web3
import { ethers } from 'ethers';
import TodoBlockchainABI from './contracts/TodoBlockchain.json';

class BlockchainTodoManager {
  private provider: ethers.providers.Web3Provider;
  private contract: ethers.Contract;
  private signer: ethers.Signer;
  
  constructor() {
    this.initializeProvider();
  }
  
  async initializeProvider() {
    if (window.ethereum) {
      this.provider = new ethers.providers.Web3Provider(window.ethereum);
      await this.provider.send("eth_requestAccounts", []);
      this.signer = this.provider.getSigner();
      
      this.contract = new ethers.Contract(
        process.env.REACT_APP_TODO_CONTRACT_ADDRESS!,
        TodoBlockchainABI.abi,
        this.signer
      );
    } else {
      throw new Error('Please install MetaMask to use the blockchain TODO list!');
    }
  }
  
  async createTodo(
    task: string,
    description: string = '',
    priority: number = 1,
    categoryId: number = 1
  ): Promise<string> {
    try {
      const gasPrice = await this.provider.getGasPrice();
      const creationFee = ethers.utils.parseEther('0.001');
      
      const tx = await this.contract.createTodo(
        task,
        description,
        priority,
        categoryId,
        ethers.constants.AddressZero, // Self-assign
        0, // No deadline
        {
          value: creationFee,
          gasPrice: gasPrice.mul(110).div(100), // 10% buffer
          gasLimit: 300000
        }
      );
      
      console.log('📝 Creating TODO on blockchain...', tx.hash);
      const receipt = await tx.wait();
      
      console.log('✅ TODO successfully mined in block:', receipt.blockNumber);
      return tx.hash;
      
    } catch (error) {
      console.error('❌ Failed to create blockchain TODO:', error);
      throw error;
    }
  }
  
  async completeTodo(todoId: number): Promise<string> {
    try {
      const tx = await this.contract.completeTodo(todoId, {
        gasLimit: 150000
      });
      
      console.log('⏳ Completing TODO on blockchain...', tx.hash);
      await tx.wait();
      console.log('🎉 TODO completion confirmed on blockchain!');
      
      return tx.hash;
    } catch (error) {
      console.error('❌ Failed to complete blockchain TODO:', error);
      throw error;
    }
  }
  
  async getUserTodos(): Promise<Todo[]> {
    try {
      const userAddress = await this.signer.getAddress();
      const todoIds = await this.contract.getUserTodos(userAddress);
      
      const todos = await Promise.all(
        todoIds.map(async (id: ethers.BigNumber) => {
          const details = await this.contract.getTodoDetails(id.toNumber());
          return {
            id: id.toNumber(),
            task: details.task,
            description: details.description,
            status: details.status,
            priority: details.priority,
            createdAt: new Date(details.createdAt.toNumber() * 1000),
            completedAt: details.completedAt.toNumber() > 0 
              ? new Date(details.completedAt.toNumber() * 1000) 
              : null
          };
        })
      );
      
      return todos;
    } catch (error) {
      console.error('❌ Failed to fetch blockchain TODOs:', error);
      throw error;
    }
  }
}

// React Component
import React, { useState, useEffect } from 'react';

const BlockchainTodoApp: React.FC = () => {
  const [todoManager] = useState(new BlockchainTodoManager());
  const [todos, setTodos] = useState<Todo[]>([]);
  const [newTodo, setNewTodo] = useState('');
  const [loading, setLoading] = useState(false);
  
  useEffect(() => {
    loadTodos();
  }, []);
  
  const loadTodos = async () => {
    try {
      setLoading(true);
      const userTodos = await todoManager.getUserTodos();
      setTodos(userTodos);
    } catch (error) {
      alert('Failed to load TODOs from blockchain');
    } finally {
      setLoading(false);
    }
  };
  
  const handleCreateTodo = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!newTodo.trim()) return;
    
    try {
      setLoading(true);
      await todoManager.createTodo(newTodo);
      setNewTodo('');
      await loadTodos(); // Refresh the list
    } catch (error) {
      alert('Failed to create TODO on blockchain');
    } finally {
      setLoading(false);
    }
  };
  
  const handleCompleteTodo = async (todoId: number) => {
    try {
      setLoading(true);
      await todoManager.completeTodo(todoId);
      await loadTodos(); // Refresh the list
    } catch (error) {
      alert('Failed to complete TODO on blockchain');
    } finally {
      setLoading(false);
    }
  };
  
  return (
    <div className="blockchain-todo-app">
      <h1>🔗 Blockchain TODO List</h1>
      <p>Your tasks, secured by the power of distributed ledger technology!</p>
      
      <form onSubmit={handleCreateTodo}>
        <input
          type="text"
          value={newTodo}
          onChange={(e) => setNewTodo(e.target.value)}
          placeholder="What needs to be done? (Cost: 0.001 ETH)"
          disabled={loading}
        />
        <button type="submit" disabled={loading || !newTodo.trim()}>
          {loading ? 'Mining...' : 'Add to Blockchain'}
        </button>
      </form>
      
      {loading && <p>⏳ Transaction being processed on blockchain...</p>}
      
      <ul>
        {todos.map(todo => (
          <li key={todo.id} className={todo.status === 2 ? 'completed' : ''}>
            <span>{todo.task}</span>
            {todo.status !== 2 && (
              <button 
                onClick={() => handleCompleteTodo(todo.id)}
                disabled={loading}
              >
                Complete
              </button>
            )}
            <small>Created: {todo.createdAt.toLocaleString()}</small>
          </li>
        ))}
      </ul>
    </div>
  );
};
```

## Why This Is Educational

This showcases several blockchain concepts that have real-world applications:
- **Smart Contracts**: Self-executing contracts with terms directly written into code
- **Events & Logs**: Blockchain event emission for transparency
- **Gas Optimization**: Efficient storage and computation patterns
- **Access Control**: Permission-based operations
- **State Management**: Immutable state transitions

## Related Concepts

Explore more blockchain-powered solutions:
- [[enterprise-hello-world]] - When simple greetings need enterprise architecture
- [[quantum-fizzbuzz]] - Applying quantum principles to programming challenges
- [[ai-powered-coin-flip]] - Using machine learning for "random" decisions
- [[microservices-calculator]] - Distributed arithmetic operations

## The Real Lesson

Blockchain technology is powerful for:
- **Decentralized applications** requiring trust
- **Financial systems** needing transparency
- **Supply chain tracking** with immutable records
- **Digital identity** verification

For a simple TODO list? Maybe just use:

```javascript
let todos = [];
function addTodo(task) { todos.push({task, completed: false}); }
function completeTodo(index) { todos[index].completed = true; }
```

*But where's the immutable distributed consensus in that?*

---

**Gas Cost per TODO**: ~$2.50 (at current ETH prices)  
**Transaction Confirmation Time**: 15-30 seconds  
**Smart Contract Size**: 2,847 bytes  
**Annual Blockchain Storage Cost**: $47 per TODO  

*Perfectly reasonable for grocery lists!*