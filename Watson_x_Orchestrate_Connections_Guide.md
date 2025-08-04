# Watson x Orchestrate Connections - Complete Guide

> **⚠️ Important Corrections Applied:**
> - **Environments**: Watson x Orchestrate uses `draft` and `live` environments (not "production")
> - **OAuth**: Uses `oauth_auth_on_behalf_of_flow` (not standard OAuth 2.0 flows)
> - **CLI Commands**: Use `--app-id` and `--environment` parameters
> - **Connection Types**: Includes `key_value` type for Python tools
> - **Available Commands**: Only `add`, `remove`, `list`, `import`, `configure`, `set-credentials`, `set-identity-provider` (no `export`, `test`, or `get` commands)

## Table of Contents
1. [Overview](#overview)
2. [Connection Types](#connection-types)
3. [Creating Connections](#creating-connections)
4. [Authentication Methods](#authentication-methods)
5. [YAML Configuration Examples](#yaml-configuration-examples)
6. [CLI Commands](#cli-commands)
7. [Environment Variables & Secrets](#environment-variables--secrets)
8. [Best Practices](#best-practices)
9. [Troubleshooting](#troubleshooting)

## Overview

Connections in Watson x Orchestrate allow your agents and tools to securely authenticate with external APIs and services. They handle credentials, authentication flows, and provide a secure way to integrate with third-party systems.

### Key Features
- **Secure credential storage** with environment variable support
- **Multiple authentication types** (API Key, OAuth 2.0, Basic Auth, Bearer Token)
- **Environment-specific configurations** (draft, live)
- **Credential management** with masked values
- **Reusable across multiple tools** and agents

## Connection Types

Watson x Orchestrate supports several connection types for different authentication scenarios:

### Supported Authentication Types
- ✅ **API Key** (Header, Query Parameter, Cookie)
- ✅ **Basic Authentication** (Username/Password)
- ✅ **Bearer Token** (JWT, Access Tokens)
- ✅ **OAuth 2.0** (oauth_auth_on_behalf_of_flow - Watson x Orchestrate specific)
- ✅ **Key-Value** (Exclusive to Python tools - key-value pairs)
- ❌ **Not Supported**: Standard OAuth 2.0 flows, Digest, HOBA, Mutual, OAuth 1.0, OIDC

### ⚠️ Important OAuth Note
Watson x Orchestrate uses `oauth_auth_on_behalf_of_flow` as the primary OAuth connection type, which is different from standard OAuth 2.0 flows (Authorization Code, Client Credentials, etc.).

## Creating Connections

### Method 1: Using CLI Commands

#### Basic Workflow
```bash
# 1. Add a connection
orchestrate connections add -a <connection-name>

# 2. Configure the connection
orchestrate connections configure -a <connection-name> --env <environment> --type <type> --kind <kind> --url <base-url>

# 3. Set credentials
orchestrate connections set-credentials -a <connection-name> --env <environment> -u <username> -p <password>
```

#### Example: Service Now Connection
```bash
# Add Service Now connection
orchestrate connections add -a service-now

# Configure for draft environment
orchestrate connections configure --app-id service-now --environment draft --kind basic --url https://your-instance.service-now.com

# Set admin credentials
orchestrate connections set-credentials --app-id service-now --environment draft -u admin -p your-password
```

### Method 2: Using YAML Configuration

Create connection YAML files and import them using the CLI.

## Authentication Methods

### 1. API Key Authentication

#### Header-based API Key
```yaml
spec_version: v1
kind: connection
name: api_service_connection
description: "API service with header-based key authentication"
connection_type: api_key
base_url: "https://api.example.com"
auth:
  type: api_key
  api_key: "{{API_KEY}}"
  location: header
  key_name: "X-API-Key"
```

#### Query Parameter API Key
```yaml
spec_version: v1
kind: connection
name: query_api_connection
description: "API service with query parameter authentication"
connection_type: api_key
base_url: "https://api.example.com"
auth:
  type: api_key
  api_key: "{{API_KEY}}"
  location: query
  key_name: "apikey"
```

#### Authorization Header API Key
```yaml
spec_version: v1
kind: connection
name: auth_header_connection
description: "API service with Authorization header"
connection_type: api_key
base_url: "https://api.example.com"
auth:
  type: api_key
  api_key: "{{API_KEY}}"
  location: header
  key_name: "Authorization"
  # Value will be sent as: Authorization: Bearer {{API_KEY}}
```

### 2. Basic Authentication

```yaml
spec_version: v1
kind: connection
name: basic_auth_service
description: "Service using basic authentication"
connection_type: basic_auth
base_url: "https://api.example.com"
auth:
  type: basic
  username: "{{USERNAME}}"
  password: "{{PASSWORD}}"
```

### 3. Bearer Token Authentication

```yaml
spec_version: v1
kind: connection
name: bearer_token_service
description: "Service using bearer token authentication"
connection_type: bearer_token
base_url: "https://api.example.com"
auth:
  type: bearer
  token: "{{BEARER_TOKEN}}"
```

### 4. OAuth 2.0 Authentication (Watson x Orchestrate Specific)

#### OAuth Auth On Behalf Of Flow
```yaml
spec_version: v1
kind: connection
name: oauth_on_behalf_connection
description: "OAuth 2.0 using Watson x Orchestrate oauth_auth_on_behalf_of_flow"
connection_type: oauth_auth_on_behalf_of_flow
base_url: "https://api.example.com"
auth:
  type: oauth_auth_on_behalf_of_flow
  client_id: "{{CLIENT_ID}}"
  client_secret: "{{CLIENT_SECRET}}"
  authorization_url: "https://auth.example.com/oauth/authorize"
  token_url: "https://auth.example.com/oauth/token"
  scopes:
    - "read"
    - "write"
```

### 5. Key-Value Connection (Python Tools Only)

```yaml
spec_version: v1
kind: connection
name: key_value_connection
description: "Key-value connection for Python tools"
connection_type: key_value
auth:
  type: key_value
  parameters:
    database_host: "{{DB_HOST}}"
    database_port: "{{DB_PORT}}"
    database_name: "{{DB_NAME}}"
    api_endpoint: "{{API_ENDPOINT}}"
    custom_config: "{{CUSTOM_CONFIG}}"
```

## YAML Configuration Examples

### Complete Connection Examples

#### Salesforce Connection
```yaml
spec_version: v1
kind: connection
name: salesforce_connection
description: "Salesforce API connection with OAuth on behalf of flow"
connection_type: oauth_auth_on_behalf_of_flow
base_url: "https://your-instance.salesforce.com"
auth:
  type: oauth_auth_on_behalf_of_flow
  client_id: "{{SALESFORCE_CLIENT_ID}}"
  client_secret: "{{SALESFORCE_CLIENT_SECRET}}"
  authorization_url: "https://login.salesforce.com/services/oauth2/authorize"
  token_url: "https://login.salesforce.com/services/oauth2/token"
  scopes:
    - "api"
    - "refresh_token"
```

#### GitHub API Connection
```yaml
spec_version: v1
kind: connection
name: github_api_connection
description: "GitHub API connection with personal access token"
connection_type: api_key
base_url: "https://api.github.com"
auth:
  type: api_key
  api_key: "{{GITHUB_TOKEN}}"
  location: header
  key_name: "Authorization"
  # Token will be sent as: Authorization: token {{GITHUB_TOKEN}}
headers:
  User-Agent: "Watson-x-Orchestrate/1.0"
  Accept: "application/vnd.github.v3+json"
```

#### Slack API Connection
```yaml
spec_version: v1
kind: connection
name: slack_api_connection
description: "Slack API connection with bot token"
connection_type: api_key
base_url: "https://slack.com/api"
auth:
  type: api_key
  api_key: "{{SLACK_BOT_TOKEN}}"
  location: header
  key_name: "Authorization"
  # Token will be sent as: Authorization: Bearer {{SLACK_BOT_TOKEN}}
```

#### REST API with Custom Headers
```yaml
spec_version: v1
kind: connection
name: custom_api_connection
description: "Custom REST API with multiple headers"
connection_type: api_key
base_url: "https://api.custom-service.com/v1"
auth:
  type: api_key
  api_key: "{{API_KEY}}"
  location: header
  key_name: "X-API-Key"
headers:
  Content-Type: "application/json"
  Accept: "application/json"
  X-Client-Version: "1.0.0"
  X-Custom-Header: "{{CUSTOM_VALUE}}"
```

## CLI Commands

### Connection Management Commands

#### List Connections
```bash
# List all connections
orchestrate connections list

# List connections in specific environment
orchestrate connections list --environment live
```

#### Add Connection
```bash
# Add a new connection
orchestrate connections add --app-id my-api-connection
```

#### Configure Connection
```bash
# Configure connection details
orchestrate connections configure --app-id my-api-connection \
  --environment draft \
  --kind api_key \
  --url https://api.example.com
```

#### Set Credentials
```bash
# Set username and password
orchestrate connections set-credentials --app-id my-connection --environment draft -u username -p password

# Set API key
orchestrate connections set-credentials --app-id my-connection --environment draft --api-key your-api-key

# Set OAuth credentials
orchestrate connections set-credentials --app-id my-connection --environment draft \
  --client-id your-client-id \
  --client-secret your-client-secret
```

#### Import Connections
```bash
# Import connection from YAML
orchestrate connections import -f my-connection.yaml

# Note: Export commands are not available in Watson x Orchestrate CLI
# Connections must be managed through YAML files and version control
```

#### Remove Connection
```bash
# Remove connection
orchestrate connections remove --app-id my-connection
```

## Environment Variables & Secrets

### Using Environment Variables in YAML

Watson x Orchestrate supports environment variable substitution using the `{{VARIABLE_NAME}}` syntax:

```yaml
auth:
  type: api_key
  api_key: "{{API_KEY}}"           # References $API_KEY environment variable
  username: "{{DB_USERNAME}}"      # References $DB_USERNAME environment variable
  password: "{{DB_PASSWORD}}"      # References $DB_PASSWORD environment variable
```

### Setting Environment Variables

#### In .env File
```bash
# .env file
API_KEY=your-secret-api-key
DB_USERNAME=admin
DB_PASSWORD=secure-password
OAUTH_CLIENT_ID=your-client-id
OAUTH_CLIENT_SECRET=your-client-secret
```

#### In Shell
```bash
export API_KEY="your-secret-api-key"
export DB_USERNAME="admin"
export DB_PASSWORD="secure-password"
```

#### Using CLI
```bash
# Set credentials directly via CLI
orchestrate connections set-credentials -a my-connection --env draft \
  --api-key "your-secret-api-key"
```

### Credential Security Best Practices

1. **Never hardcode credentials** in YAML files
2. **Use environment variables** for all sensitive data
3. **Use different credentials** for different environments
4. **Rotate credentials regularly**
5. **Use least privilege principle** for API keys and tokens
6. **Store credentials securely** in your deployment environment

## Best Practices

### 1. Connection Naming
- Use descriptive, consistent names: `salesforce_prod`, `github_api`, `slack_bot`
- Include environment in name if needed: `database_dev`, `database_prod`
- Use lowercase with underscores or hyphens

### 2. Environment Management
- Use separate connections for different environments
- Test connections in `draft` before promoting to `production`
- Use environment-specific credentials

### 3. Security
- Always use environment variables for sensitive data
- Regularly rotate API keys and tokens
- Use OAuth 2.0 when available for better security
- Implement proper scopes and permissions

### 4. Documentation
- Add clear descriptions to your connections
- Document required environment variables
- Include setup instructions for team members

### 5. Testing
- Test connections after creation
- Verify credentials work with actual API calls
- Monitor connection health in production

## Troubleshooting

### Common Issues

#### Authentication Failures
```bash
# List connections to verify they exist
orchestrate connections list

# Verify credentials are set by checking connection configuration
# Note: No direct 'get' or 'test' commands available
# Use 'list' to see available connections
```

#### Environment Variable Issues
```bash
# Check if environment variables are set
echo $API_KEY

# Verify .env file is loaded
orchestrate server start -e .env
```

#### OAuth 2.0 Issues
- Verify redirect URIs match exactly
- Check client ID and secret are correct
- Ensure scopes are properly configured
- Verify authorization and token URLs

#### Connection Not Found
```bash
# List all connections to verify name
orchestrate connections list

# Check if connection exists in correct environment
orchestrate connections list --env production
```

### Debug Commands
```bash
# List all connections
orchestrate connections list

# Verify environment variables
orchestrate env list

# Check active environment
orchestrate env list | grep "(active)"
```

### Error Messages and Solutions

| Error | Solution |
|-------|----------|
| "Connection not found" | Verify connection name and environment |
| "Invalid credentials" | Check username/password or API key |
| "OAuth flow failed" | Verify client ID, secret, and URLs |
| "Environment variable not set" | Set required environment variables |
| "Invalid URL" | Ensure base URL is correct and accessible |

---

*This guide covers the essential aspects of creating and managing connections in Watson x Orchestrate. For the latest updates and additional examples, refer to the official documentation.*
