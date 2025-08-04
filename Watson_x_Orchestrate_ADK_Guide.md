# Watson x Orchestrate ADK (Agent Development Kit) - Complete Guide

## Table of Contents
1. [Overview](#overview)
2. [Installation](#installation)
3. [Environment Setup](#environment-setup)
4. [Authentication](#authentication)
5. [Core Commands](#core-commands)
6. [Agents](#agents)
7. [Tools](#tools)
8. [Connections](#connections)
9. [Knowledge Bases](#knowledge-bases)
10. [Evaluation Framework](#evaluation-framework)
11. [Examples](#examples)
12. [Troubleshooting](#troubleshooting)

## Overview

The Watson x Orchestrate Agent Development Kit (ADK) is a developer-focused toolkit for building, testing, and managing AI agents. It provides:

- **Lightweight Framework**: Simple CLI and YAML/JSON configuration
- **Custom Tools**: Create Python-based tools for your agents
- **Local Development**: Test agents locally before deployment
- **Full Lifecycle Management**: Build, test, deploy, and monitor agents
- **Multiple Environments**: Support for IBM Cloud, AWS, and on-premises

## Installation

### Prerequisites
- **Python 3.11** or later
- **pip** package manager
- Watson x Orchestrate account (30-day free trial available)

### Install ADK
```bash
# Install globally
pip install ibm-watsonx-orchestrate

# Or in a virtual environment
python -m venv adk-env
source adk-env/bin/activate  # On Windows: adk-env\Scripts\activate
pip install ibm-watsonx-orchestrate
```

### Verify Installation
```bash
orchestrate --version
```

## Environment Setup

### Project Structure (Recommended)
```
adk-project/
├── agents/
├── tools/
├── knowledge/
├── flows/
├── connections/
└── .env
```

### Environment Commands

#### Add Environment
```bash
# AWS (Your Setup)
orchestrate env add -n myenv -u https://api.dl.watson-orchestrate.ibm.com/instances/YOUR-INSTANCE-ID --type mcsp --activate

# IBM Cloud
orchestrate env add -n <env-name> -u <service-url> --type ibm_iam --activate

# On-premises
orchestrate env add -n <env-name> -u <service-url> --type cpd --activate
```

#### List Environments
```bash
orchestrate env list
```

#### Activate Environment
```bash
orchestrate env activate <env-name>
# Or with API key directly
orchestrate env activate <env-name> --api-key <your-api-key>
```

#### Remove Environment
```bash
orchestrate env remove -n <env-name>
```

## Authentication

### Getting Credentials

#### AWS (Your Setup) 🌟
1. Log in to your Watson x Orchestrate instance
2. Click user icon (top right) → **Settings**
3. Go to **API details** tab
4. Copy service instance URL: `https://api.dl.watson-orchestrate.ibm.com/instances/YOUR-INSTANCE-ID`
5. Click **Generate API key** button
6. Copy the generated API key (base64 encoded format)
7. **Important**: API keys are not retrievable after creation - store safely!
8. **Limit**: You can have up to 10 API keys per environment

**Your API Key Format**: Base64 encoded string like:
```
your-base64-encoded-api-key-here
```

#### IBM Cloud
1. Log in to Watson x Orchestrate
2. Click user icon → **Settings**
3. Go to **API details** tab
4. Copy service instance URL
5. Click **Generate API key**
6. Follow IBM Cloud IAM process

#### On-premises
- Use API key or username/password
- Cannot use both methods simultaneously

### Authentication Types
- `mcsp`: **AWS Multi-Cloud SaaS Platform (Your Setup)** 🌟
- `mcsp_v1`: AWS MCSP v1 authentication (fallback)
- `mcsp_v2`: AWS MCSP v2 authentication (preferred)
- `ibm_iam`: IBM Cloud Identity and Access Management
- `cpd`: On-premises Cloud Pak for Data

## AWS-Specific Setup (Your Environment) 🌟

### Quick Start for AWS
```bash
# 1. Install ADK
pip install ibm-watsonx-orchestrate

# 2. Add your AWS environment (with API key)

orchestrate env add -n myenv -u https://api.dl.watson-orchestrate.ibm.com/instances/YOUR-INSTANCE-ID --type mcsp
orchestrate env activate myenv --api-key YOUR-API-KEY-HERE

# 3. Verify authentication
orchestrate agents list
```

### AWS Environment Commands
```bash
# Check current environment
orchestrate env list

# Re-authenticate if token expires (every 2 hours)
orchestrate env activate myenv

# Or authenticate non-interactively
orchestrate env activate myenv --api-key YOUR-API-KEY-HERE
```

### Script-Ready Commands (Exact from final_auto_get_all.sh)
```bash
# Step 1: Add environment (without activation)
ENV_NAME="watson-test01"
SERVICE_URL="https://api.dl.watson-orchestrate.ibm.com/instances/YOUR-INSTANCE-ID"
API_KEY="YOUR-API-KEY-HERE"

orchestrate env add -n "$ENV_NAME" -u "$SERVICE_URL" --type mcsp

# Step 2: Authenticate with API key (non-interactive)
orchestrate env activate "$ENV_NAME" --api-key "$API_KEY"

# Step 3: Verify authentication
orchestrate env list
```

### Get All Items from Your AWS Instance
```bash
# List all agents
orchestrate agents list

# List all tools
orchestrate tools list

# List all connections
orchestrate connections list

# List all knowledge bases
orchestrate knowledge-bases list

# List all flows (if available)
orchestrate flows list

# Export everything for backup
mkdir backup
orchestrate agents export-all -d backup/agents/
orchestrate tools export-all -d backup/tools/
orchestrate connections export-all -d backup/connections/
orchestrate knowledge-bases export-all -d backup/knowledge-bases/
```

## Core Commands

### General Commands
```bash
# Get help
orchestrate --help
orchestrate <command> --help

# Check version
orchestrate --version

# Start local development server
orchestrate server start

# Start chat interface
orchestrate chat
```

## Agents

### Agent Commands
```bash
# List agents
orchestrate agents list

# Import agent
orchestrate agents import -f agent.yaml

# Export agent
orchestrate agents export -n "Agent Name" -f exported-agent.yaml

# Delete agent
orchestrate agents delete -n "Agent Name"

# Get agent details
orchestrate agents get -n "Agent Name"
```

### Agent Specification (YAML)
```yaml
spec_version: v1
kind: native
name: My_Agent
description: "Agent description"
instructions: "Detailed instructions for the agent"
llm: watsonx/meta-llama/llama-3-2-90b-vision-instruct
style: default
collaborators: []
tools: []
knowledge_bases: []
```

### Agent Styles
- `default`: Standard conversational style
- `concise`: Brief, to-the-point responses
- `creative`: More creative and expressive
- `professional`: Formal business tone

### Supported LLMs
```yaml
# Watson x models
llm: watsonx/meta-llama/llama-3-2-90b-vision-instruct
llm: watsonx/ibm/granite-3-8b-instruct
llm: watsonx/meta-llama/llama-3-1-70b-instruct

# Custom LLMs (via AI Gateway)
llm: custom/my-custom-model
```

## Tools

### Tool Commands
```bash
# List tools
orchestrate tools list

# Import tool
orchestrate tools import -f tool.yaml

# Export tool
orchestrate tools export -n "Tool Name" -f exported-tool.yaml

# Delete tool
orchestrate tools delete -n "Tool Name"
```

### Tool Types

#### Python Tools
```yaml
spec_version: v1
kind: python
name: my_python_tool
description: "Custom Python tool"
input_schema:
  type: object
  properties:
    query:
      type: string
      description: "Search query"
  required: ["query"]
code: |
  def main(query: str) -> str:
      # Your Python code here
      return f"Result for: {query}"
```

#### OpenAPI Tools
```yaml
spec_version: v1
kind: openapi
name: api_tool
description: "External API integration"
openapi_spec_url: "https://api.example.com/openapi.json"
connection: my_api_connection
```

#### Flow Tools
```yaml
spec_version: v1
kind: flow
name: workflow_tool
description: "Multi-step workflow"
steps:
  - name: step1
    tool: tool1
    inputs:
      param1: "value1"
  - name: step2
    tool: tool2
    inputs:
      param1: "{{step1.output}}"
```

### Tool Development
```python
# tools/my_tool.py
def main(input_param: str) -> dict:
    """
    Tool function that processes input and returns result
    """
    result = process_input(input_param)
    return {
        "status": "success",
        "data": result
    }

def process_input(param: str) -> str:
    # Your logic here
    return f"Processed: {param}"
```

## Connections

### Connection Commands
```bash
# List connections
orchestrate connections list

# Import connection
orchestrate connections import -f connection.yaml

# Export connection
orchestrate connections export -n "Connection Name" -f exported-connection.yaml

# Delete connection
orchestrate connections delete -n "Connection Name"

# Set connection credentials
orchestrate connections set-credentials -n "Connection Name"
```

### Connection Types

#### API Key Authentication
```yaml
spec_version: v1
kind: connection
name: api_service_connection
description: "API service with key auth"
connection_type: api_key
base_url: "https://api.example.com"
auth:
  type: api_key
  api_key: "{{API_KEY}}"
  location: header
  key_name: "X-API-Key"
```

#### OAuth 2.0
```yaml
spec_version: v1
kind: connection
name: oauth_service
description: "OAuth 2.0 service"
connection_type: oauth2
auth:
  type: oauth2
  grant_type: authorization_code
  client_id: "{{CLIENT_ID}}"
  client_secret: "{{CLIENT_SECRET}}"
  authorization_url: "https://auth.example.com/oauth/authorize"
  token_url: "https://auth.example.com/oauth/token"
```

#### Basic Authentication
```yaml
spec_version: v1
kind: connection
name: basic_auth_service
description: "Basic auth service"
connection_type: basic_auth
auth:
  type: basic
  username: "{{USERNAME}}"
  password: "{{PASSWORD}}"
```

### Using Connections in Tools
```python
# In Python tools
def main(query: str, connection) -> dict:
    # Access connection credentials
    api_key = connection.get_credential("API_KEY")
    base_url = connection.base_url
    
    # Make authenticated request
    headers = {"Authorization": f"Bearer {api_key}"}
    response = requests.get(f"{base_url}/search", 
                          params={"q": query}, 
                          headers=headers)
    
    return response.json()
```

## Knowledge Bases

### Knowledge Base Commands
```bash
# List knowledge bases
orchestrate knowledge-bases list

# Import knowledge base
orchestrate knowledge-bases import -f kb.yaml

# Export knowledge base
orchestrate knowledge-bases export -n "KB Name" -f exported-kb.yaml

# Delete knowledge base
orchestrate knowledge-bases delete -n "KB Name"
```

### Knowledge Base Specification
```yaml
spec_version: v1
kind: knowledge_base
name: company_docs
description: "Company documentation knowledge base"
documents:
  - path: "./docs/policies.pdf"
    metadata:
      category: "policies"
      department: "hr"
  - path: "./docs/procedures.md"
    metadata:
      category: "procedures"
      department: "operations"
chunking:
  strategy: semantic
  chunk_size: 1000
  overlap: 200
embedding:
  model: "text-embedding-ada-002"
```

### Using Knowledge Bases in Agents
```yaml
spec_version: v1
kind: native
name: support_agent
description: "Customer support agent with knowledge base"
instructions: "Use the company knowledge base to answer questions"
llm: watsonx/meta-llama/llama-3-2-90b-vision-instruct
knowledge_bases:
  - name: company_docs
    retrieval_settings:
      top_k: 5
      similarity_threshold: 0.7
```

## Evaluation Framework

### Evaluation Commands
```bash
# List evaluations
orchestrate evaluations list

# Run evaluation
orchestrate evaluations run -f evaluation.yaml

# Get evaluation results
orchestrate evaluations get -n "Evaluation Name"
```

### Evaluation Configuration
```yaml
spec_version: v1
kind: evaluation
name: agent_performance_test
description: "Test agent performance"
target:
  type: agent
  name: "My Agent"
dataset:
  - input: "What is our return policy?"
    expected_output: "Our return policy allows..."
    metadata:
      category: "policy"
  - input: "How do I reset my password?"
    expected_output: "To reset your password..."
    metadata:
      category: "technical"
metrics:
  - accuracy
  - relevance
  - response_time
```

### Evaluation Metrics
- **Accuracy**: Correctness of responses
- **Relevance**: How relevant responses are to queries
- **Response Time**: Speed of response generation
- **Coherence**: Logical flow and consistency
- **Completeness**: Whether responses fully address queries

## Examples

### Simple Hello World Agent
```yaml
# hello-world-agent.yaml
spec_version: v1
kind: native
name: Hello_World_Agent
description: "A simple greeting agent"
instructions: "Greet users and introduce yourself as the Hello World Agent"
llm: watsonx/meta-llama/llama-3-2-90b-vision-instruct
style: default
collaborators: []
tools: []
```

### Agent with Custom Tool
```yaml
# weather-agent.yaml
spec_version: v1
kind: native
name: Weather_Agent
description: "Weather information agent"
instructions: "Help users get weather information using the weather tool"
llm: watsonx/meta-llama/llama-3-2-90b-vision-instruct
tools:
  - name: weather_tool
```

```yaml
# weather-tool.yaml
spec_version: v1
kind: python
name: weather_tool
description: "Get weather information"
input_schema:
  type: object
  properties:
    location:
      type: string
      description: "City name"
  required: ["location"]
code: |
  import requests
  
  def main(location: str, connection) -> dict:
      api_key = connection.get_credential("API_KEY")
      url = f"http://api.openweathermap.org/data/2.5/weather"
      params = {
          "q": location,
          "appid": api_key,
          "units": "metric"
      }
      response = requests.get(url, params=params)
      return response.json()
```

## Troubleshooting

### Common Issues

#### Authentication Errors
```bash
# Check environment status
orchestrate env list

# Re-authenticate
orchestrate env activate <env-name> --api-key <api-key>

# Check credentials file
cat ~/.cache/orchestrate/credentials.yaml
```

#### Import Failures
```bash
# Validate YAML syntax
python -c "import yaml; yaml.safe_load(open('agent.yaml'))"

# Check required fields
orchestrate agents import -f agent.yaml --validate-only
```

#### Connection Issues
```bash
# Test connection
orchestrate connections test -n "Connection Name"

# Check connection credentials
orchestrate connections get -n "Connection Name"
```

### Configuration Files
- **Config**: `~/.config/orchestrate/config.yaml`
- **Credentials**: `~/.cache/orchestrate/credentials.yaml`

### Logging
```bash
# Enable debug logging
export ORCHESTRATE_LOG_LEVEL=DEBUG
orchestrate agents list

# Check logs
tail -f ~/.cache/orchestrate/logs/orchestrate.log
```

### Support Resources
- [Official Documentation](https://developer.watson-orchestrate.ibm.com/)
- [GitHub Repository](https://github.com/IBM/ibm-watsonx-orchestrate-adk)
- [IBM Support](https://www.ibm.com/mysupport/s/topic/0TO3p000000A6YLGA0/watsonx-orchestrate)

---

*This guide covers the essential Watson x Orchestrate ADK commands and concepts. For the latest updates and detailed examples, refer to the official documentation.*
