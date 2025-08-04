# Watson x Orchestrate Sandbox

A comprehensive sandbox environment for IBM Watson x Orchestrate development, featuring connection templates, automation scripts, and documentation for rapid prototyping and integration.

## 🚀 Quick Start

1. **Clone the repository**
   ```bash
   git clone https://github.com/joselrnz/wxo-sbx.git
   cd wxo-sbx
   ```

2. **Set up your environment**
   ```bash
   # Copy the example environment file
   cp .env.example .env
   
   # Edit .env with your credentials
   nano .env
   ```

3. **Deploy connections**
   ```bash
   # Deploy all connections
   orchestrate connections create -f connections/*.yaml
   
   # Or deploy specific connections
   orchestrate connections create -f connections/slack-connection.yaml
   ```

4. **Run automation scripts**
   ```bash
   # Get all Watson x Orchestrate items
   ./scripts/final_auto_get_all.sh
   ```

## 📁 Repository Structure

```
wxo-sbx/
├── 📂 connections/          # Connection templates for various services
│   ├── slack-connection.yaml
│   ├── salesforce-connection.yaml
│   ├── servicenow-connection.yaml
│   ├── github-connection.yaml
│   ├── jira-connection.yaml
│   ├── microsoft-graph-connection.yaml
│   ├── aws-connection.yaml
│   └── ...
├── 📂 docs/                 # Documentation and guides
│   ├── Watson_x_Orchestrate_ADK_Guide.md
│   ├── Watson_x_Orchestrate_Connections_Guide.md
│   ├── Salesforce_Integration_Guide.md
│   └── Watson_x_Orchestrate_All_Connections_Guide.md
├── 📂 scripts/              # Automation scripts
│   └── final_auto_get_all.sh
├── 📂 examples/             # Example configurations and notes
│   └── note.note
├── .env                     # Environment variables (not tracked)
├── .gitignore              # Git ignore rules
└── README.md               # This file
```

## 🔗 Available Connections

### **Authentication Types**
- **Basic Auth**: Username/password (ServiceNow, Jira)
- **Bearer Token**: Token-based auth (Slack, GitHub)
- **API Key**: Simple API key auth (Generic APIs)
- **OAuth 2.0**: Secure OAuth flows (Salesforce)
- **OAuth + SSO**: Enterprise SSO (Microsoft Graph)
- **Key-Value**: Custom auth schemes (AWS)

### **Service Integrations**
- 🔵 **Slack** - Team communication and notifications
- 🟠 **Salesforce** - CRM and sales automation
- 🔴 **ServiceNow** - IT service management
- ⚫ **GitHub** - Code repository management
- 🟣 **Jira** - Issue tracking and project management
- 🔵 **Microsoft Graph** - Office 365, Teams, SharePoint
- 🟡 **AWS** - Amazon Web Services integration

## 🛠️ Scripts

### `scripts/final_auto_get_all.sh`
Automated script to retrieve all Watson x Orchestrate items:
- Agents, Tools, Connections
- Knowledge Bases, Flows, Evaluations
- Environment information
- Generates HTML and text reports

**Features:**
- ✅ Secure credential loading from `.env`
- ✅ Automatic authentication
- ✅ Comprehensive data export
- ✅ Error handling and validation

## 📚 Documentation

### Core Guides
- **[ADK Guide](docs/Watson_x_Orchestrate_ADK_Guide.md)** - Complete Watson x Orchestrate setup
- **[Connections Guide](docs/Watson_x_Orchestrate_Connections_Guide.md)** - Connection management
- **[All Connections Guide](docs/Watson_x_Orchestrate_All_Connections_Guide.md)** - Comprehensive connection reference

### Service-Specific Guides
- **[Salesforce Integration](docs/Salesforce_Integration_Guide.md)** - Salesforce setup and usage

## 🔐 Security

- **Environment Variables**: All credentials stored in `.env` file
- **Git Ignore**: Sensitive files automatically excluded
- **No Hardcoded Secrets**: All examples use placeholders
- **Best Practices**: Security guidelines included in documentation

## 🚀 Usage Examples

### Deploy a Connection
```bash
# Deploy Slack connection
orchestrate connections create -f connections/slack-connection.yaml

# Test the connection
orchestrate connections test slack_connection
```

### Run Data Export
```bash
# Export all Watson x Orchestrate data
./scripts/final_auto_get_all.sh

# View results
cat watson_all_items_*/summary.txt
```

### Create Custom Tools
```bash
# List available connections
orchestrate connections list

# Create tools that use your connections
orchestrate tools create -f your-tool.yaml
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Add your connection templates or improvements
4. Update documentation
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🆘 Support

- **Documentation**: Check the `docs/` folder for detailed guides
- **Issues**: Report bugs or request features via GitHub Issues
- **Watson x Orchestrate**: [Official Documentation](https://developer.watson-orchestrate.ibm.com/)

## 🏷️ Tags

`watson-x-orchestrate` `ibm` `ai` `automation` `integrations` `api` `connections` `sandbox`
