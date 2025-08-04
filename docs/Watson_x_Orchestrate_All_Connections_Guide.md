# Watson x Orchestrate - Complete Connections Guide

This guide covers all the connection types and popular service integrations available in your Watson x Orchestrate sandbox.

## 🔗 Available Connection Types

### 1. **Basic Authentication** (`basic`)
- **Files**: `servicenow-connection.yaml`, `jira-connection.yaml`
- **Use case**: Username/password authentication
- **Examples**: ServiceNow, Jira, legacy APIs

### 2. **Bearer Token** (`bearer`)
- **Files**: `slack-connection.yaml`, `github-connection.yaml`
- **Use case**: Token-based authentication
- **Examples**: Slack, GitHub, many modern APIs

### 3. **API Key** (`api_key`)
- **Files**: `api-key-connection.yaml`
- **Use case**: Simple API key authentication
- **Examples**: OpenWeatherMap, News APIs, many SaaS services

### 4. **OAuth 2.0** (`oauth2`)
- **Files**: `salesforce-connection.yaml`
- **Use case**: Secure OAuth 2.0 flows
- **Examples**: Salesforce, Google APIs, social media platforms

### 5. **OAuth with SSO** (`oauth_auth_on_behalf_of_flow`)
- **Files**: `oauth-sso-connection.yaml`, `microsoft-graph-connection.yaml`
- **Use case**: Enterprise SSO integrations
- **Examples**: Microsoft Graph, Azure AD, enterprise systems

### 6. **Key-Value Pairs** (`key_value`)
- **Files**: `key-value-connection.yaml`, `aws-connection.yaml`
- **Use case**: Custom authentication schemes
- **Examples**: AWS Signature V4, custom enterprise APIs

## 🚀 Quick Deployment Guide

### Step 1: Configure Credentials
Update your `.env` file with the appropriate credentials for each service:

```bash
# Example for Slack
SLACK_BOT_TOKEN=xoxb-your-slack-bot-token

# Example for GitHub
GITHUB_TOKEN=ghp_your-github-personal-access-token

# Example for Jira
JIRA_INSTANCE=your-company
JIRA_EMAIL=your-email@company.com
JIRA_API_TOKEN=your-jira-api-token
```

### Step 2: Deploy Connections
```bash
# Deploy individual connections
orchestrate connections create -f slack-connection.yaml
orchestrate connections create -f github-connection.yaml
orchestrate connections create -f jira-connection.yaml

# Or deploy all at once
orchestrate connections create -f *.yaml
```

### Step 3: Verify Connections
```bash
# List all connections
orchestrate connections list

# Test specific connection
orchestrate connections test slack_connection
```

## 📋 Service-Specific Setup Instructions

### 🔵 **Slack Integration**
1. Create a Slack app at https://api.slack.com/apps
2. Add bot token scopes (channels:read, chat:write, etc.)
3. Install app to workspace
4. Copy Bot User OAuth Token to `.env` as `SLACK_BOT_TOKEN`

### 🟠 **Salesforce Integration**
**Option A: Simple Auth**
1. Get security token: Setup → My Personal Information → Reset Security Token
2. Update `.env` with username, password, and security token

**Option B: OAuth (Recommended)**
1. Create Connected App in Salesforce Setup
2. Enable OAuth settings with appropriate scopes
3. Update `.env` with client ID and secret

### 🟣 **Jira Integration**
1. Generate API token: Account Settings → Security → API tokens
2. Update `.env` with email and API token
3. Use email as username, API token as password

### ⚫ **GitHub Integration**
1. Create Personal Access Token: Settings → Developer settings → Personal access tokens
2. Grant appropriate scopes (repo, user, etc.)
3. Update `.env` with token

### 🔵 **Microsoft Graph Integration**
1. Register app in Azure AD: Azure Portal → App registrations
2. Configure API permissions for Microsoft Graph
3. Create client secret
4. Update `.env` with client ID and secret

### 🟡 **AWS Integration**
1. Create IAM user with programmatic access
2. Attach appropriate policies
3. Update `.env` with access key ID and secret access key

## 🔧 Connection Configuration Reference

### Environment Types
- **`draft`**: Development environment
- **`live`**: Production environment

### Credential Types
- **`team`**: Shared credentials for all team members
- **`member`**: Individual credentials per user

### Authentication Kinds
- **`basic`**: Username/password
- **`bearer`**: Bearer token
- **`api_key`**: API key authentication
- **`oauth2`**: OAuth 2.0 flow
- **`oauth_auth_on_behalf_of_flow`**: OAuth with SSO
- **`key_value`**: Custom key-value pairs

## 🛠️ Advanced Usage

### Custom Headers
```yaml
headers:
  Content-Type: "application/json"
  Accept: "application/json"
  User-Agent: "Watson-x-Orchestrate/1.0"
  Custom-Header: "{{CUSTOM_VALUE}}"
```

### Multiple Environments
```yaml
environments:
  draft:
    kind: basic
    server_url: "https://dev-api.example.com"
  live:
    kind: oauth2
    server_url: "https://api.example.com"
```

### Endpoint Definitions
```yaml
endpoints:
  users: "/api/v1/users"
  projects: "/api/v1/projects"
  search: "/api/v1/search?q={{QUERY}}"
```

## 🔐 Security Best Practices

1. **Never commit credentials** - Always use `.env` file
2. **Use least privilege** - Grant minimal required permissions
3. **Rotate credentials regularly** - Especially API keys and tokens
4. **Use OAuth for production** - More secure than API keys
5. **Monitor API usage** - Track and limit API calls
6. **Validate SSL certificates** - Ensure secure connections

## 📚 Next Steps

1. **Deploy connections** you need for your use case
2. **Create custom tools** that use these connections
3. **Build agents** that orchestrate multiple services
4. **Set up monitoring** for connection health and usage
5. **Implement error handling** for connection failures

## 🆘 Troubleshooting

- **Connection failed**: Check credentials in `.env` file
- **SSL errors**: Verify server URLs and certificates
- **Rate limiting**: Implement retry logic and respect API limits
- **Token expired**: Refresh OAuth tokens or regenerate API keys
- **Permission denied**: Check API scopes and user permissions

For more details, see the [official Watson x Orchestrate documentation](https://developer.watson-orchestrate.ibm.com/connections/overview).
