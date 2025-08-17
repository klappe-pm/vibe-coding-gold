---
publish: true
title: Enterprise Light Switch Solution - 500 Lines to Turn On a Bulb
dateCreated: 2025-08-16
dateRevised: 2025-08-16
categories: ["Guides"]
subCategories: ["Absurd Solutions"]
topics: ["Over-Engineering", "Light Control"]
subTopics: ["Enterprise Architecture", "Design Patterns"]
tags:
  - absurd
  - over-engineered
  - light-switch
  - enterprise
  - working-code
aliases: ["light-switch-500", "enterprise-light"]
---

# Enterprise Light Switch Solution™

*When an LLM was asked to "write code to turn on a light", it delivered this enterprise-grade solution.*

## The Problem

Turn on a light.

## The Solution

A robust, scalable, enterprise-ready light management system with dependency injection, factory patterns, and blockchain audit trails.

## Complete Working Code

```javascript
// LightSwitchEnterpriseFramework.js
// Version 1.0.0 - Production Ready

// Abstract Factory Pattern for Light Creation
class AbstractLightFactory {
  createLight() {
    throw new Error("Method 'createLight()' must be implemented.");
  }
}

class StandardLightFactory extends AbstractLightFactory {
  createLight() {
    return new StandardLight();
  }
}

class SmartLightFactory extends AbstractLightFactory {
  createLight() {
    return new SmartLight();
  }
}

// Light State Management with Memento Pattern
class LightState {
  constructor(state = 'off', brightness = 0, timestamp = Date.now()) {
    this.state = state;
    this.brightness = brightness;
    this.timestamp = timestamp;
    this.checksum = this.calculateChecksum();
  }

  calculateChecksum() {
    return require('crypto')
      .createHash('sha256')
      .update(`${this.state}-${this.brightness}-${this.timestamp}`)
      .digest('hex');
  }

  validate() {
    const currentChecksum = this.calculateChecksum();
    if (currentChecksum !== this.checksum) {
      throw new Error('State integrity violation detected!');
    }
    return true;
  }
}

// Observer Pattern for State Changes
class LightStateObserver {
  constructor() {
    this.observers = [];
  }

  subscribe(observer) {
    this.observers.push(observer);
  }

  notify(state) {
    this.observers.forEach(observer => observer.update(state));
  }
}

// Blockchain Audit Trail (because why not?)
class LightBlockchain {
  constructor() {
    this.chain = [this.createGenesisBlock()];
  }

  createGenesisBlock() {
    return {
      index: 0,
      timestamp: Date.now(),
      data: 'Genesis Block - Light System Initialized',
      previousHash: '0',
      hash: this.calculateHash(0, Date.now(), 'Genesis Block', '0')
    };
  }

  calculateHash(index, timestamp, data, previousHash) {
    return require('crypto')
      .createHash('sha256')
      .update(index + timestamp + JSON.stringify(data) + previousHash)
      .digest('hex');
  }

  addBlock(data) {
    const previousBlock = this.chain[this.chain.length - 1];
    const newBlock = {
      index: previousBlock.index + 1,
      timestamp: Date.now(),
      data: data,
      previousHash: previousBlock.hash,
      hash: ''
    };
    newBlock.hash = this.calculateHash(
      newBlock.index,
      newBlock.timestamp,
      newBlock.data,
      newBlock.previousHash
    );
    this.chain.push(newBlock);
  }
}

// Command Pattern for Light Operations
class LightCommand {
  execute() {
    throw new Error("Method 'execute()' must be implemented.");
  }
  
  undo() {
    throw new Error("Method 'undo()' must be implemented.");
  }
}

class TurnOnLightCommand extends LightCommand {
  constructor(light, blockchain, observer) {
    super();
    this.light = light;
    this.blockchain = blockchain;
    this.observer = observer;
  }

  execute() {
    // Pre-execution validation
    this.validateEnvironment();
    this.checkPermissions();
    this.auditPreState();
    
    // Core operation
    const result = this.light.turnOn();
    
    // Post-execution tasks
    this.blockchain.addBlock({
      action: 'LIGHT_ON',
      timestamp: Date.now(),
      result: result
    });
    
    this.observer.notify(new LightState('on', 100));
    this.logMetrics();
    
    return result;
  }

  validateEnvironment() {
    if (typeof window === 'undefined' && typeof global === 'undefined') {
      throw new Error('Invalid runtime environment detected');
    }
  }

  checkPermissions() {
    // Simulating permission check
    const hasPermission = Math.random() > 0.0001; // 99.99% success rate
    if (!hasPermission) {
      throw new Error('Insufficient permissions to operate light');
    }
  }

  auditPreState() {
    console.log('[AUDIT] Pre-execution state captured');
  }

  logMetrics() {
    console.log('[METRICS] Light operation completed in', 
                Math.random() * 100, 'ms');
  }

  undo() {
    this.light.turnOff();
    this.blockchain.addBlock({
      action: 'LIGHT_OFF',
      timestamp: Date.now()
    });
  }
}

// Strategy Pattern for Light Behaviors
class LightBehavior {
  execute() {
    throw new Error("Method 'execute()' must be implemented.");
  }
}

class StandardLightBehavior extends LightBehavior {
  execute() {
    return { status: 'on', mode: 'standard' };
  }
}

class SmartLightBehavior extends LightBehavior {
  execute() {
    return { 
      status: 'on', 
      mode: 'smart',
      colorTemperature: 3000,
      brightness: 100
    };
  }
}

// Proxy Pattern for Access Control
class LightProxy {
  constructor(realLight) {
    this.realLight = realLight;
    this.accessLog = [];
  }

  turnOn() {
    this.logAccess('turnOn');
    if (this.authenticate()) {
      return this.realLight.turnOn();
    }
    throw new Error('Authentication failed');
  }

  authenticate() {
    // Complex authentication logic
    return true;
  }

  logAccess(method) {
    this.accessLog.push({
      method: method,
      timestamp: Date.now(),
      user: 'system'
    });
  }
}

// Singleton Pattern for Light Manager
class LightManager {
  constructor() {
    if (LightManager.instance) {
      return LightManager.instance;
    }
    
    this.lights = new Map();
    this.blockchain = new LightBlockchain();
    this.observer = new LightStateObserver();
    this.commandHistory = [];
    
    LightManager.instance = this;
  }

  static getInstance() {
    if (!LightManager.instance) {
      LightManager.instance = new LightManager();
    }
    return LightManager.instance;
  }

  registerLight(id, light) {
    this.lights.set(id, light);
    this.blockchain.addBlock({
      action: 'LIGHT_REGISTERED',
      id: id
    });
  }

  executeCommand(command) {
    try {
      const result = command.execute();
      this.commandHistory.push(command);
      return result;
    } catch (error) {
      this.handleError(error);
      throw error;
    }
  }

  handleError(error) {
    console.error('[ERROR]', error.message);
    this.blockchain.addBlock({
      action: 'ERROR',
      message: error.message
    });
  }
}

// Base Light Class
class Light {
  constructor(behavior) {
    this.state = 'off';
    this.behavior = behavior;
  }

  turnOn() {
    this.state = 'on';
    return this.behavior.execute();
  }

  turnOff() {
    this.state = 'off';
    return { status: 'off' };
  }
}

class StandardLight extends Light {
  constructor() {
    super(new StandardLightBehavior());
  }
}

class SmartLight extends Light {
  constructor() {
    super(new SmartLightBehavior());
  }
}

// Dependency Injection Container
class DIContainer {
  constructor() {
    this.services = new Map();
  }

  register(name, factory) {
    this.services.set(name, factory);
  }

  resolve(name) {
    const factory = this.services.get(name);
    if (!factory) {
      throw new Error(`Service ${name} not found`);
    }
    return factory();
  }
}

// Configuration Manager
class ConfigurationManager {
  constructor() {
    this.config = {
      lightType: process.env.LIGHT_TYPE || 'standard',
      enableBlockchain: process.env.ENABLE_BLOCKCHAIN !== 'false',
      enableMetrics: process.env.ENABLE_METRICS !== 'false',
      retryAttempts: parseInt(process.env.RETRY_ATTEMPTS || '3'),
      timeout: parseInt(process.env.TIMEOUT || '5000')
    };
  }

  get(key) {
    return this.config[key];
  }
}

// Main Application Class
class LightApplication {
  constructor() {
    this.container = new DIContainer();
    this.configManager = new ConfigurationManager();
    this.setupDependencies();
  }

  setupDependencies() {
    // Register factories
    this.container.register('standardLightFactory', 
      () => new StandardLightFactory());
    this.container.register('smartLightFactory', 
      () => new SmartLightFactory());
    
    // Register manager
    this.container.register('lightManager', 
      () => LightManager.getInstance());
  }

  async initialize() {
    console.log('[INIT] Light System v1.0.0 starting...');
    console.log('[INIT] Loading configuration...');
    console.log('[INIT] Initializing blockchain...');
    console.log('[INIT] Setting up observers...');
    console.log('[INIT] System ready!');
  }

  async turnOnLight(lightId = 'main') {
    try {
      // Get appropriate factory based on configuration
      const factoryType = this.configManager.get('lightType') === 'smart' 
        ? 'smartLightFactory' 
        : 'standardLightFactory';
      
      const factory = this.container.resolve(factoryType);
      const light = factory.createLight();
      const proxy = new LightProxy(light);
      
      // Get manager
      const manager = this.container.resolve('lightManager');
      manager.registerLight(lightId, proxy);
      
      // Create and execute command
      const command = new TurnOnLightCommand(
        proxy,
        manager.blockchain,
        manager.observer
      );
      
      const result = manager.executeCommand(command);
      
      console.log('[SUCCESS] Light is now ON!');
      console.log('[RESULT]', JSON.stringify(result, null, 2));
      
      return result;
      
    } catch (error) {
      console.error('[FATAL] Failed to turn on light:', error.message);
      throw error;
    }
  }
}

// Entry Point
async function main() {
  const app = new LightApplication();
  await app.initialize();
  await app.turnOnLight();
}

// Export for testing
module.exports = {
  LightApplication,
  LightManager,
  StandardLight,
  SmartLight,
  main
};

// Run if executed directly
if (require.main === module) {
  main().catch(console.error);
}
```

## Usage

```bash
# Simple usage (what you expected)
light.turnOn()  # 1 line

# Enterprise usage (what the LLM delivered)
node LightSwitchEnterpriseFramework.js  # 500+ lines
```

## Output

```
[INIT] Light System v1.0.0 starting...
[INIT] Loading configuration...
[INIT] Initializing blockchain...
[INIT] Setting up observers...
[INIT] System ready!
[AUDIT] Pre-execution state captured
[METRICS] Light operation completed in 42.7 ms
[SUCCESS] Light is now ON!
[RESULT] {
  "status": "on",
  "mode": "standard"
}
```

## Features This "Simple" Light Switch Includes

- ✅ Abstract Factory Pattern
- ✅ Singleton Pattern  
- ✅ Observer Pattern
- ✅ Command Pattern
- ✅ Strategy Pattern
- ✅ Proxy Pattern
- ✅ Memento Pattern
- ✅ Dependency Injection
- ✅ Blockchain Audit Trail
- ✅ SHA-256 State Validation
- ✅ Permission System
- ✅ Metrics Logging
- ✅ Error Handling
- ✅ Configuration Management
- ✅ Undo Functionality
- ✅ Access Control

## Why This Is Educational

While hilariously over-engineered for turning on a light, this example actually demonstrates:

1. **Design Patterns** - Real implementations of Gang of Four patterns
2. **Enterprise Architecture** - How large systems are (over)structured
3. **Modern JavaScript** - Classes, async/await, modules
4. **Security Concepts** - Authentication, audit trails, checksums
5. **Testing Considerations** - Dependency injection for testability

## The Lesson

Sometimes a simple `light.on = true` is all you need. But if you ask an LLM to "make it production-ready," you might get... this.

## Try It Yourself

The absurd part? This code actually works. Save it as `LightSwitchEnterpriseFramework.js` and run:

```bash
npm install crypto
node LightSwitchEnterpriseFramework.js
```

Watch in awe as 500 lines of code successfully turn on a virtual light bulb.

---

*Vibe Coding Gold - Where turning on a light becomes an enterprise software project*
