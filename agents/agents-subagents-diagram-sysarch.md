---
vault:
categories:
subCategories:
topics:
subTopics:
dateCreated: 2025-08-14
dateRevised: 2025-08-16
aliases: []
tags: []
---

# agents-subagents-diagram-sysarch

## Complete Agent Network with All Relationships

```mermaid
graph TB
    %% User Interface
    User[👤 User] --> AO[🎯 agentOrchestrator]
    
    %% Orchestrator connections to all agents
    AO -.->|orchestrates| AA[🔍 agentAnalyzer]
    AO -.->|orchestrates| AB[⚙️ agentBackend]
    AO -.->|orchestrates| AF[🎨 agentFrontend]
    AO -.->|orchestrates| AS[🔒 agentSecurity]
    AO -.->|orchestrates| AT[🧪 agentTest]
    AO -.->|orchestrates| AP[⚡ agentPerformance]
    AO -.->|orchestrates| AD[📚 agentDocumentation]
    AO -.->|orchestrates| AI[🏗️ agentInfrastructure]
    AO -.->|orchestrates| AIm[💻 agentImplementation]
    AO -.->|orchestrates| ADe[🐛 agentDebug]
    AO -.->|orchestrates| AC[🧹 agentCleanup]
    AO -.->|orchestrates| AW[📋 agentWorkflow]
    AO -.->|orchestrates| ABu[🔨 agentBuilder]
    AO -.->|orchestrates| AG[📦 agentGit]
    AO -.->|orchestrates| ADes[🎯 agentDesign]
    AO -.->|orchestrates| AE[📊 agentEstimation]
    
    %% Language SubAgents
    subgraph "Language SubAgents"
        SANJ[Node.js]
        SAJS[JavaScript]
        SATS[TypeScript]
        SAGAS[Google Apps Script]
        SAG[Go]
        SAP[Python]
    end
    
    %% Code-writing agents to language subagents
    AB --> SANJ
    AB --> SAJS
    AB --> SATS
    AB --> SAGAS
    AB --> SAG
    AB --> SAP
    
    AF --> SAJS
    AF --> SATS
    AF --> SAGAS
    
    AIm --> SANJ
    AIm --> SAJS
    AIm --> SATS
    AIm --> SAGAS
    AIm --> SAG
    AIm --> SAP
    
    ADe --> SANJ
    ADe --> SAJS
    ADe --> SATS
    ADe --> SAGAS
    ADe --> SAG
    ADe --> SAP
    
    AC --> SANJ
    AC --> SAJS
    AC --> SATS
    AC --> SAGAS
    AC --> SAG
    AC --> SAP
    
    AT --> SANJ
    AT --> SAJS
    AT --> SATS
    AT --> SAG
    AT --> SAP
    
    ABu --> SAJS
    ABu --> SATS
    ABu --> SAP
    ABu --> SAG
    
    AI --> SAP
    AI --> SAG
    AI --> SAJS
    AI --> SATS
    
    %% Coordination relationships
    AB <--> AF
    AB <--> AS
    AF <--> AS
    AT <--> AP
    AIm <--> AB
    AIm <--> AF
    ADe <--> AA
    AW <--> AE
    
    %% All outputs lead to code
    SANJ --> Code[📄 Generated Code]
    SAJS --> Code
    SATS --> Code
    SAGAS --> Code
    SAG --> Code
    SAP --> Code
    
    %% Styling
    style User fill:#FFE5B4,stroke:#8B7355,stroke-width:2px
    style AO fill:#FF6B6B,stroke:#C92A2A,stroke-width:3px,color:#fff
    style Code fill:#90EE90,stroke:#228B22,stroke-width:3px
    style SANJ fill:#68D391,stroke:#2F855A,stroke-width:2px
    style SAJS fill:#F6E05E,stroke:#D69E2E,stroke-width:2px
    style SATS fill:#4299E1,stroke:#2B6CB0,stroke-width:2px
    style SAGAS fill:#9F7AEA,stroke:#6B46C1,stroke-width:2px
    style SAG fill:#48BB78,stroke:#276749,stroke-width:2px
    style SAP fill:#4299E1,stroke:#2C5282,stroke-width:2px
```

## Data Flow and Memory Access Patterns

```mermaid
graph LR
    %% Memory System
    subgraph "Memory System"
        MEM[(📝 agents-memory.md)]
        SESS[Session Data]
        LOGS[Update Logs]
        LEARN[Lessons Learned]
        MULTI[Multi-Agent Memory]
    end
    
    %% Agents accessing memory
    AO[agentOrchestrator] -->|read/write| MEM
    AA[agentAnalyzer] -->|read| MEM
    AB[agentBackend] -->|read/write| MEM
    AF[agentFrontend] -->|read/write| MEM
    AIm[agentImplementation] -->|read/write| MEM
    ADe[agentDebug] -->|read/write| MEM
    
    %% Memory components
    MEM --> SESS
    MEM --> LOGS
    MEM --> LEARN
    MEM --> MULTI
    
    %% Data flow
    SESS -->|compaction| COMPACT[Compacted Data]
    LOGS -->|analysis| INSIGHTS[Insights]
    LEARN -->|patterns| PATTERNS[Patterns]
    
    COMPACT --> AO
    INSIGHTS --> AA
    PATTERNS --> AIm
    
    style MEM fill:#FFD700,stroke:#B8860B,stroke-width:3px
```

## Communication Protocol Visualization

```mermaid
sequenceDiagram
    participant U as User
    participant O as Orchestrator
    participant D as Design Agent
    participant I as Implementation Agent
    participant L as Language SubAgent
    participant T as Test Agent
    participant M as Memory
    
    U->>O: Request Feature
    O->>M: Load Context
    M-->>O: Context Data
    O->>D: Design System
    D-->>O: Design Complete
    O->>I: Implement Design
    I->>L: Generate Code
    L-->>I: Code Generated
    I-->>O: Implementation Done
    O->>T: Test Implementation
    T->>L: Generate Tests
    L-->>T: Tests Created
    T-->>O: Tests Passing
    O->>M: Save Session
    O-->>U: Feature Complete
```

## Agent Hierarchy and Authority

```mermaid
graph TD
    %% Tier 1: Orchestrator
    subgraph "Tier 1: Command"
        AO[agentOrchestrator<br/>Full Authority]
    end
    
    %% Tier 2: Primary Agents
    subgraph "Tier 2: Execution"
        subgraph "Core Agents"
            AA[agentAnalyzer]
            AB[agentBackend]
            AF[agentFrontend]
            AS[agentSecurity]
            AT[agentTest]
            AP[agentPerformance]
            AD[agentDocumentation]
            AI[agentInfrastructure]
        end
        
        subgraph "Specialized Agents"
            AIm[agentImplementation]
            ADe[agentDebug]
            AC[agentCleanup]
            Others[...]
        end
    end
    
    %% Tier 3: SubAgents
    subgraph "Tier 3: Support"
        subgraph "Language SubAgents"
            LangSubs[Node.js | JS | TS | Python | Go | GAS]
        end
        
        subgraph "Domain SubAgents"
            DomainSubs[Database | API | Security | Testing | ...]
        end
    end
    
    %% Authority flow
    AO ==>|Commands| AA
    AO ==>|Commands| AB
    AO ==>|Commands| AF
    AO ==>|Commands| AIm
    
    AA -->|Delegates| DomainSubs
    AB -->|Delegates| LangSubs
    AF -->|Delegates| LangSubs
    AIm -->|Delegates| LangSubs
    
    %% Styling
    style AO fill:#FF6B6B,stroke:#C92A2A,stroke-width:4px,color:#fff
    style LangSubs fill:#90EE90,stroke:#228B22,stroke-width:2px
    style DomainSubs fill:#87CEEB,stroke:#4682B4,stroke-width:2px
```

## Task Execution Flow

```mermaid
graph TB
    Start([User Request]) --> Parse{Parse Request}
    
    Parse --> Simple[Simple Task]
    Parse --> Complex[Complex Task]
    Parse --> Critical[Critical Task]
    
    Simple --> FastModel[gemini-2.5-flash]
    Complex --> BalancedModel[o3 / gemini-2.5-pro]
    Critical --> PowerfulModel[o3-pro / claude-opus-4]
    
    FastModel --> Execute[Execute Task]
    BalancedModel --> Execute
    PowerfulModel --> Execute
    
    Execute --> Success{Success?}
    
    Success -->|Yes| Complete([Task Complete])
    Success -->|No| Fallback[Try Fallback Model]
    
    Fallback --> Execute
    
    Complete --> UpdateMemory[Update Memory]
    UpdateMemory --> LogCLI[Log to CLI]
    LogCLI --> End([Return to User])
    
    style Start fill:#98FB98,stroke:#228B22,stroke-width:2px
    style End fill:#98FB98,stroke:#228B22,stroke-width:2px
    style Critical fill:#FFB6C1,stroke:#DC143C,stroke-width:2px
```

## Model Selection Decision Tree

```mermaid
graph TD
    Request[Task Request] --> Analyze{Analyze Requirements}
    
    Analyze --> Context{Context Size?}
    
    Context -->|< 50K| Small[Small Context]
    Context -->|50K-200K| Medium[Medium Context]
    Context -->|> 200K| Large[Large Context]
    
    Small --> Complexity1{Complexity?}
    Medium --> Complexity2{Complexity?}
    Large --> LargeModel[gpt-4.1 / gemini-2.5-pro]
    
    Complexity1 -->|Low| Flash[gemini-2.5-flash]
    Complexity1 -->|Medium| Mini[o4-mini]
    Complexity1 -->|High| O3[o3]
    
    Complexity2 -->|Low| Mini2[o4-mini]
    Complexity2 -->|Medium| Grok[grok-3]
    Complexity2 -->|High| O3Pro[o3-pro]
    
    Flash --> Budget{Budget OK?}
    Mini --> Budget
    O3 --> Budget
    Mini2 --> Budget
    Grok --> Budget
    O3Pro --> Budget
    LargeModel --> Budget
    
    Budget -->|Yes| Proceed[Use Selected Model]
    Budget -->|No| Downgrade[Use Cheaper Alternative]
    
    Downgrade --> Local{Can Use Local?}
    Local -->|Yes| Llama[llama-3.2]
    Local -->|No| Emergency[gemini-2.5-flash]
    
    style Request fill:#E6E6FA,stroke:#6A5ACD,stroke-width:2px
    style Proceed fill:#90EE90,stroke:#228B22,stroke-width:2px
    style Llama fill:#FFD700,stroke:#B8860B,stroke-width:2px
```

## Parallel Execution Pattern

```mermaid
graph TB
    subgraph "Orchestrator"
        O[agentOrchestrator]
    end
    
    subgraph "Parallel Execution Wave 1"
        O -->|async| Design[agentDesign]
        O -->|async| Context[agentContextLoader]
        O -->|async| Estimate[agentEstimation]
    end
    
    subgraph "Parallel Execution Wave 2"
        Design --> Backend[agentBackend]
        Design --> Frontend[agentFrontend]
        Context --> Implementation[agentImplementation]
    end
    
    subgraph "Language SubAgents (Parallel)"
        Backend --> NodeJS[subAgentNodeJS]
        Backend --> Python[subAgentPython]
        Frontend --> JavaScript[subAgentJavaScript]
        Frontend --> TypeScript[subAgentTypeScript]
        Implementation --> Go[subAgentGo]
    end
    
    subgraph "Convergence"
        NodeJS --> Integration[Integration Point]
        Python --> Integration
        JavaScript --> Integration
        TypeScript --> Integration
        Go --> Integration
    end
    
    Integration --> Test[agentTest]
    Test --> Complete[✓ Complete]
    
    style O fill:#FF6B6B,stroke:#C92A2A,stroke-width:3px,color:#fff
    style Complete fill:#90EE90,stroke:#228B22,stroke-width:2px
```

## Error Handling and Recovery Flow

```mermaid
graph TD
    subgraph "Error Detection"
        E[Error Occurs] --> Type{Error Type?}
        Type -->|Timeout| Timeout[Timeout Handler]
        Type -->|Model Error| ModelErr[Model Error Handler]
        Type -->|Logic Error| LogicErr[Logic Error Handler]
        Type -->|Resource| ResourceErr[Resource Handler]
    end
    
    subgraph "Recovery Strategies"
        Timeout --> Retry1[Retry with Faster Model]
        ModelErr --> Fallback[Use Fallback Model]
        LogicErr --> Debug[Activate agentDebug]
        ResourceErr --> Scale[Scale Down Request]
    end
    
    subgraph "Escalation"
        Retry1 --> Check1{Success?}
        Fallback --> Check2{Success?}
        Debug --> Check3{Success?}
        Scale --> Check4{Success?}
        
        Check1 -->|No| Escalate1[Escalate to Orchestrator]
        Check2 -->|No| Escalate2[Escalate to Orchestrator]
        Check3 -->|No| Escalate3[Escalate to Orchestrator]
        Check4 -->|No| Escalate4[Escalate to Orchestrator]
        
        Check1 -->|Yes| Resolved[Task Continues]
        Check2 -->|Yes| Resolved
        Check3 -->|Yes| Resolved
        Check4 -->|Yes| Resolved
    end
    
    subgraph "Final Resolution"
        Escalate1 --> Orchestrator[Orchestrator Decision]
        Escalate2 --> Orchestrator
        Escalate3 --> Orchestrator
        Escalate4 --> Orchestrator
        
        Orchestrator --> Manual[Manual Intervention]
        Orchestrator --> Abort[Abort Task]
        Orchestrator --> Degrade[Degraded Mode]
    end
    
    style E fill:#FF6B6B,stroke:#C92A2A,stroke-width:2px
    style Resolved fill:#90EE90,stroke:#228B22,stroke-width:2px
```

## Complete Workflow Example: Feature Implementation

```mermaid
graph LR
    subgraph "Phase 1: Planning"
        U[User Request] --> O[Orchestrator]
        O --> W[Workflow Agent]
        W --> E[Estimation Agent]
        W --> D[Design Agent]
    end
    
    subgraph "Phase 2: Implementation"
        D --> I[Implementation Agent]
        I --> BK[Backend Agent]
        I --> FE[Frontend Agent]
        
        BK --> NJS[Node.js SubAgent]
        FE --> TS[TypeScript SubAgent]
    end
    
    subgraph "Phase 3: Quality"
        NJS --> T[Test Agent]
        TS --> T
        T --> UT[Unit Test SubAgent]
        T --> IT[Integration Test SubAgent]
        
        T --> S[Security Agent]
        S --> VA[Vulnerability SubAgent]
    end
    
    subgraph "Phase 4: Deployment"
        S --> INF[Infrastructure Agent]
        INF --> K8S[Kubernetes SubAgent]
        INF --> TF[Terraform SubAgent]
        
        INF --> DOC[Documentation Agent]
        DOC --> API[API Doc SubAgent]
    end
    
    subgraph "Phase 5: Completion"
        DOC --> GIT[Git Agent]
        GIT --> O2[Orchestrator]
        O2 --> U2[User Notification]
    end
    
    style U fill:#FFE5B4,stroke:#8B7355,stroke-width:2px
    style U2 fill:#90EE90,stroke:#228B22,stroke-width:2px
```
