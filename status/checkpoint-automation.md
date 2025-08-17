# Checkpoint Automation Guide

## Automated Progress Tracking System

### MCP Commands for Checkpoint Updates

#### After Each Component Completion
```bash
# Update component status
zen:chat --model gemini-2.5-flash \
  --update-status "planning-status.md" \
  --component-complete "$COMPONENT_ID" \
  --time-spent "$MINUTES" \
  --debug-time "$DEBUG_MINUTES" \
  --issues "$ISSUE_LIST"
```

#### After Each Feature Completion
```bash
# Feature checkpoint validation
zen:analyze --model o3 \
  --validate-feature "$FEATURE_ID" \
  --run-tests \
  --update-metrics \
  --generate-report
```

#### After Each Epic Completion
```bash
# Epic review gate
zen:consensus --models "o3,gemini-2.5-pro,grok-3" \
  --epic-review "$EPIC_ID" \
  --validate-deliverables \
  --check-quality \
  --approve-progression
```

---

## Automated Status Update Templates

### Component Update Script
```javascript
// auto-update-component.js
function updateComponentStatus(componentId, status, timeSpent, debugInfo) {
  const update = {
    timestamp: new Date().toISOString(),
    component: componentId,
    status: status, // 'complete', 'blocked', 'in-progress'
    metrics: {
      timeSpent: timeSpent,
      debugTime: debugInfo.time,
      debugReasons: debugInfo.reasons
    }
  };
  
  // Append to planning-status.md
  updatePlanningDoc(update);
  
  // Calculate progress
  updateProgressMetrics();
  
  // Check if feature/epic complete
  checkParentCompletion(componentId);
}
```

### Feature Validation Script
```bash
#!/bin/bash
# validate-feature.sh

FEATURE_ID=$1
START_TIME=$(date +%s)

# Run feature tests
echo "Validating Feature: $FEATURE_ID"

# Component checks
for component in $(getFeatureComponents $FEATURE_ID); do
  if ! validateComponent $component; then
    echo "❌ Component $component failed validation"
    updateStatus $FEATURE_ID "blocked" "Component $component failed"
    exit 1
  fi
done

END_TIME=$(date +%s)
DURATION=$((END_TIME - START_TIME))

# Update status
updateStatus $FEATURE_ID "complete" "" $DURATION
echo "✅ Feature $FEATURE_ID validated in ${DURATION}s"
```

---

## Progress Calculation Formulas

### Component Progress
```typescript
interface ComponentProgress {
  totalTasks: number;
  completedTasks: number;
  blockedTasks: number;
  progressPercent: number;
  estimatedCompletion: Date;
}

function calculateComponentProgress(componentId: string): ComponentProgress {
  const tasks = getComponentTasks(componentId);
  const completed = tasks.filter(t => t.status === 'complete').length;
  const blocked = tasks.filter(t => t.status === 'blocked').length;
  
  return {
    totalTasks: tasks.length,
    completedTasks: completed,
    blockedTasks: blocked,
    progressPercent: (completed / tasks.length) * 100,
    estimatedCompletion: estimateCompletion(tasks)
  };
}
```

### Epic Progress
```typescript
function calculateEpicProgress(epicId: string): EpicProgress {
  const features = getEpicFeatures(epicId);
  const weights = getFeatureWeights(epicId);
  
  let weightedProgress = 0;
  features.forEach(feature => {
    const progress = calculateFeatureProgress(feature.id);
    weightedProgress += progress.percent * weights[feature.id];
  });
  
  return {
    percent: weightedProgress,
    featuresComplete: features.filter(f => f.status === 'complete').length,
    totalFeatures: features.length,
    blockers: getEpicBlockers(epicId),
    estimatedCompletion: estimateEpicCompletion(epicId)
  };
}
```

---

## Automated Reporting

### Session Report Generator
```bash
# Generate session report
zen:docgen --model gemini-2.5-pro \
  --session-report \
  --start-time "$SESSION_START" \
  --end-time "$SESSION_END" \
  --completed-items "$COMPLETED_LIST" \
  --debug-log "$DEBUG_LOG" \
  --next-actions "$NEXT_ACTIONS" \
  --output "status/session-$(date +%Y%m%d-%H%M).md"
```

### Daily Progress Dashboard
```bash
# Update dashboard
zen:analyze --model gemini-2.5-flash \
  --generate-dashboard \
  --input "status/planning-status.md" \
  --metrics "time,progress,quality,blockers" \
  --format "markdown" \
  --output "status/dashboard.md"
```

---

## Checkpoint Validation Rules

### Component Validation
```yaml
Component:
  Required:
    - Code complete
    - Tests passing
    - Documentation updated
    - Review approved
  Optional:
    - Performance optimized
    - Accessibility checked
  
  AutoCheck:
    - Syntax validation
    - Type checking
    - Lint passing
    - Build successful
```

### Feature Validation
```yaml
Feature:
  Required:
    - All components complete
    - Integration tested
    - User acceptance criteria met
    - No critical bugs
  
  AutoCheck:
    - E2E tests passing
    - Performance within budget
    - Security scan clean
```

### Epic Validation
```yaml
Epic:
  Required:
    - All features complete
    - Review gate passed
    - Documentation complete
    - Deployment successful
  
  AutoCheck:
    - System tests passing
    - Performance metrics met
    - Monitoring configured
```

---

## Debug Tracking Automation

### Debug Logger
```javascript
class DebugLogger {
  constructor(sessionId) {
    this.sessionId = sessionId;
    this.startTime = Date.now();
    this.issues = [];
  }
  
  logIssue(issue) {
    const entry = {
      timestamp: Date.now(),
      duration: null,
      issue: issue.description,
      rootCause: null,
      resolution: null,
      category: issue.category // 'config', 'dependency', 'logic', 'environment'
    };
    
    this.issues.push(entry);
    return entry.id;
  }
  
  resolveIssue(id, rootCause, resolution) {
    const issue = this.issues.find(i => i.id === id);
    issue.duration = Date.now() - issue.timestamp;
    issue.rootCause = rootCause;
    issue.resolution = resolution;
    
    // Auto-update planning status
    this.updatePlanningStatus(issue);
  }
  
  generateReport() {
    const totalDebugTime = this.issues.reduce((sum, i) => sum + i.duration, 0);
    const debugPercentage = (totalDebugTime / (Date.now() - this.startTime)) * 100;
    
    return {
      sessionId: this.sessionId,
      totalDebugTime: totalDebugTime,
      debugPercentage: debugPercentage,
      issuesByCategory: this.groupByCategory(),
      recommendations: this.generateRecommendations()
    };
  }
}
```

---

## Progress Visualization

### ASCII Progress Bars
```javascript
function generateProgressBar(percent, width = 20) {
  const filled = Math.floor(percent / 100 * width);
  const empty = width - filled;
  return '█'.repeat(filled) + '░'.repeat(empty) + ` ${percent}%`;
}

function updateDashboard() {
  const epics = getEpics();
  let dashboard = '## Progress Overview\n\n';
  
  epics.forEach(epic => {
    const progress = calculateEpicProgress(epic.id);
    dashboard += `${epic.name}: ${generateProgressBar(progress.percent)}\n`;
  });
  
  return dashboard;
}
```

### Status Indicators
```javascript
const statusIcons = {
  'not-started': '⏳',
  'in-progress': '🔄',
  'complete': '✅',
  'blocked': '🚫',
  'at-risk': '⚠️'
};

function getStatusIcon(status) {
  return statusIcons[status] || '❓';
}
```

---

## Automated Alerts

### Blocker Detection
```bash
# Check for blockers every 30 minutes
*/30 * * * * zen:analyze --check-blockers \
  --project "Vibe Coding Gold" \
  --alert-threshold "critical" \
  --notify-method "console"
```

### Time Overrun Alert
```javascript
function checkTimeOverrun(componentId, actualTime, plannedTime) {
  const variance = ((actualTime - plannedTime) / plannedTime) * 100;
  
  if (variance > 50) {
    alert({
      level: 'warning',
      component: componentId,
      message: `Time overrun: ${variance}% over planned`,
      suggestedAction: 'Review scope or get assistance'
    });
  }
}
```

---

## Integration with Planning Status

### Auto-Update Function
```bash
# Function to call after any checkpoint
update_planning_status() {
  local checkpoint_type=$1  # component|feature|epic
  local checkpoint_id=$2
  local status=$3
  local debug_time=$4
  local debug_reason=$5
  
  # Update the markdown file
  sed -i "s/\| $checkpoint_id \| ⬜ \|/\| $checkpoint_id \| ✅ \|/" \
    "status/planning-status.md"
  
  # Add debug info if present
  if [ ! -z "$debug_time" ]; then
    echo "Debug: $checkpoint_id - Time: $debug_time - Reason: $debug_reason" \
      >> "status/debug-log.md"
  fi
  
  # Recalculate progress
  calculate_overall_progress
}
```

### Git Commit Hooks
```bash
# .git/hooks/post-commit
#!/bin/bash
# Auto-update planning status on commit

COMMIT_MSG=$(git log -1 --pretty=%B)
if [[ $COMMIT_MSG == *"[CHECKPOINT]"* ]]; then
  # Extract checkpoint ID from commit message
  CHECKPOINT_ID=$(echo $COMMIT_MSG | grep -oP '(?<=\[CHECKPOINT:\s)[^\]]+')
  
  # Update planning status
  update_planning_status "component" "$CHECKPOINT_ID" "complete"
  
  # Commit the updated status
  git add status/planning-status.md
  git commit -m "[AUTO] Update planning status for $CHECKPOINT_ID"
fi
```

---

## Quick Commands

### Mark Component Complete
```bash
alias complete='function _complete() { 
  update_planning_status "component" "$1" "complete" "$2" "$3"; 
}; _complete'

# Usage: complete C1 "15m" "CSS variable naming issue"
```

### Generate Session Report
```bash
alias session-report='zen:docgen --session-report \
  --auto-detect-changes \
  --calculate-progress \
  --output "status/session-$(date +%Y%m%d).md"'
```

### Quick Progress Check
```bash
alias progress='cat status/planning-status.md | grep "Progress:"'
```

---

*This automation guide ensures consistent tracking and reduces manual overhead in maintaining project status.*