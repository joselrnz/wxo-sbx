# Watson x Orchestrate - Instance & Environment Setup Guide

This guide covers creating Watson x Orchestrate instances, managing subscriptions, and setting up environments for development and production.

## 🏗️ **Instance vs Subscription Overview**

### **Subscription**
- **What it is**: Your billing/licensing container
- **Contains**: Multiple instances (dev, test, prod)
- **Billing**: Charged at subscription level
- **Management**: Admin controls, user access, quotas

### **Instance** 
- **What it is**: Individual Watson x Orchestrate environment
- **Purpose**: Specific workload (development, testing, production)
- **Isolation**: Separate data, configurations, agents
- **Access**: Instance-specific URLs and credentials

## 🎯 **Recommended Setup Strategy**

### **Single Subscription with Multiple Instances**
```
📦 Your Company Subscription
├── 🔧 Development Instance (dev-wxo)
├── 🧪 Testing Instance (test-wxo)  
└── 🚀 Production Instance (prod-wxo)
```

**Benefits:**
- ✅ Centralized billing and management
- ✅ Easy promotion between environments
- ✅ Consistent user access controls
- ✅ Cost-effective resource sharing

## 🚀 **Instance Creation Process**

### **Step 1: Access IBM Cloud Console**
1. Go to [IBM Cloud Console](https://cloud.ibm.com)
2. Navigate to **Catalog** → **AI/Machine Learning**
3. Search for **"Watson x Orchestrate"**
4. Click **"Create"**

### **Step 2: Configure Instance**
```yaml
Instance Configuration:
  Name: "wxo-dev-instance"           # Descriptive name
  Region: "us-south"                 # Choose closest region
  Resource Group: "development"      # Organize resources
  Plan: "Standard"                   # Choose appropriate plan
  Tags: ["development", "wxo"]       # For organization
```

### **Step 3: Instance Settings**
- **Service Name**: `watson-orchestrate-dev`
- **Region**: Choose based on your location/compliance
- **Resource Group**: Group related resources
- **Pricing Plan**: Select based on usage needs

## 🔧 **Environment Configuration**

### **Development Environment (.env)**
```bash
# Development Instance
ENV_NAME=wxo-dev
API_KEY=your-dev-api-key-here
SERVICE_INSTANCE_URL=https://api.dl.watson-orchestrate.ibm.com/instances/dev-instance-id
AUTH_TYPE=basic

# Environment Metadata
ENVIRONMENT=development
REGION=us-south
RESOURCE_GROUP=development
```

### **Testing Environment (.env.test)**
```bash
# Testing Instance  
ENV_NAME=wxo-test
API_KEY=your-test-api-key-here
SERVICE_INSTANCE_URL=https://api.dl.watson-orchestrate.ibm.com/instances/test-instance-id
AUTH_TYPE=basic

# Environment Metadata
ENVIRONMENT=testing
REGION=us-south
RESOURCE_GROUP=testing
```

### **Production Environment (.env.prod)**
```bash
# Production Instance
ENV_NAME=wxo-prod
API_KEY=your-prod-api-key-here
SERVICE_INSTANCE_URL=https://api.dl.watson-orchestrate.ibm.com/instances/prod-instance-id
AUTH_TYPE=basic

# Environment Metadata
ENVIRONMENT=production
REGION=us-south
RESOURCE_GROUP=production
```

## 📋 **Instance Management Best Practices**

### **Naming Conventions**
```
Instance Names:
- wxo-{company}-dev
- wxo-{company}-test  
- wxo-{company}-prod

Environment Names:
- {company}-development
- {company}-testing
- {company}-production
```

### **Resource Organization**
```yaml
Resource Groups:
  development:
    instances: ["wxo-dev"]
    purpose: "Development and experimentation"
    
  testing:
    instances: ["wxo-test"]
    purpose: "Integration testing and QA"
    
  production:
    instances: ["wxo-prod"] 
    purpose: "Live production workloads"
```

## 🔑 **Authentication & Access**

### **API Key Management**
```bash
# Generate API Keys per environment
ibmcloud iam api-key-create wxo-dev-key --description "Watson x Orchestrate Dev"
ibmcloud iam api-key-create wxo-test-key --description "Watson x Orchestrate Test"  
ibmcloud iam api-key-create wxo-prod-key --description "Watson x Orchestrate Prod"
```

### **Service Credentials**
Each instance gets unique credentials:
- **API Key**: For programmatic access
- **Instance URL**: Unique endpoint per instance
- **Region**: Geographic location of instance

## 🌍 **Multi-Environment Workflow**

### **Development → Testing → Production**
```bash
# 1. Develop in dev environment
orchestrate env activate wxo-dev
orchestrate agents create -f my-agent.yaml

# 2. Test in testing environment  
orchestrate env activate wxo-test
orchestrate agents import -f exported-agent.yaml

# 3. Deploy to production
orchestrate env activate wxo-prod
orchestrate agents import -f tested-agent.yaml
```

### **Environment Switching**
```bash
# List available environments
orchestrate env list

# Switch to specific environment
orchestrate env activate wxo-dev
orchestrate env activate wxo-test
orchestrate env activate wxo-prod

# Verify current environment
orchestrate env current
```

## 💰 **Cost Optimization**

### **Instance Sizing**
- **Development**: Smaller instance, lower cost
- **Testing**: Medium instance for load testing
- **Production**: Sized for actual workload

### **Resource Sharing**
- **Single Subscription**: Share quotas across instances
- **Resource Groups**: Organize billing and access
- **Tagging**: Track costs by project/team

## 🔒 **Security & Compliance**

### **Access Control**
```yaml
Instance Access:
  Development:
    users: ["developers", "qa-team"]
    permissions: ["read", "write", "deploy"]
    
  Testing:
    users: ["qa-team", "product-managers"]
    permissions: ["read", "test", "validate"]
    
  Production:
    users: ["ops-team", "senior-developers"]
    permissions: ["read", "deploy-approved"]
```

### **Network Security**
- **Private Endpoints**: For production instances
- **VPC Integration**: Network isolation
- **IP Allowlisting**: Restrict access by IP

## 🚨 **Troubleshooting**

### **Common Issues**
```bash
# Instance not accessible
orchestrate env test

# Authentication failures  
orchestrate auth refresh

# Wrong instance URL
orchestrate env get wxo-dev
```

### **Health Checks**
```bash
# Check instance status
orchestrate status

# Verify connectivity
orchestrate agents list

# Test authentication
orchestrate auth validate
```

## 📊 **Monitoring & Logging**

### **Instance Metrics**
- **API Usage**: Track requests per instance
- **Resource Utilization**: Monitor compute usage
- **Error Rates**: Track failed requests

### **Logging Strategy**
```yaml
Log Levels:
  Development: DEBUG
  Testing: INFO  
  Production: WARN
  
Log Retention:
  Development: 7 days
  Testing: 30 days
  Production: 90 days
```

## 🎯 **Recommendations**

### **For Your Current Setup**
Based on your `.env` file, you have:
- ✅ **Single instance**: Good for getting started
- ✅ **Basic auth**: Appropriate for development
- 🔄 **Consider**: Adding test/prod instances later

### **Next Steps**
1. **Keep current instance** for development
2. **Create test instance** when ready for QA
3. **Add production instance** before go-live
4. **Implement CI/CD** for environment promotion

## 📞 **Support & Resources**

- **IBM Cloud Support**: For instance/subscription issues
- **Watson x Orchestrate Docs**: For technical guidance
- **Community Forums**: For best practices and tips
