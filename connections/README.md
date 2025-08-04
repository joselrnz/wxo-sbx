# Watson x Orchestrate Connections

This directory contains connection templates for various external services and APIs.

## 📁 Available Connections

### **Basic Authentication**
- `servicenow-connection.yaml` - ServiceNow IT service management
- `jira-connection.yaml` - Atlassian Jira issue tracking

### **Bearer Token Authentication**
- `slack-connection.yaml` - Slack team communication
- `github-connection.yaml` - GitHub repository management

### **API Key Authentication**
- `api-key-connection.yaml` - Generic API key template
- `simple-api-connection.yaml` - Simple API template

### **OAuth 2.0 Authentication**
- `salesforce-connection.yaml` - Salesforce CRM (OAuth)
- `salesforce-connection-simple.yaml` - Salesforce CRM (username/password)

### **OAuth with SSO**
- `oauth-sso-connection.yaml` - Generic OAuth SSO template
- `microsoft-graph-connection.yaml` - Microsoft Graph API

### **Key-Value Authentication**
- `key-value-connection.yaml` - Generic key-value template
- `aws-connection.yaml` - Amazon Web Services

## 🚀 Quick Deployment

### Deploy All Connections
```bash
orchestrate connections create -f connections/*.yaml
```

### Deploy Specific Connection
```bash
orchestrate connections create -f connections/slack-connection.yaml
```

### Test Connection
```bash
orchestrate connections test slack_connection
```

## 🔧 Configuration

1. **Update .env file** with your service credentials
2. **Deploy connection** using the orchestrate CLI
3. **Test connection** to verify it works
4. **Use in tools** by referencing the connection name

## 📚 Documentation

For detailed setup instructions, see:
- `../docs/Watson_x_Orchestrate_All_Connections_Guide.md`
- `../docs/Salesforce_Integration_Guide.md`

## 🔐 Security Notes

- Never commit real credentials to git
- Use environment variables for all sensitive data
- Test connections in draft environment first
- Rotate API keys and tokens regularly
