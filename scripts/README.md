# Watson x Orchestrate Scripts

Automation scripts for Watson x Orchestrate management and data export.

## 📁 Available Scripts

### `final_auto_get_all.sh`
Comprehensive data export script that retrieves all Watson x Orchestrate items.

**What it exports:**
- 📋 Agents
- 🔧 Tools  
- 🔗 Connections
- 📚 Knowledge Bases
- 🌊 Flows
- 📊 Evaluations
- 🏠 Environment Information

**Features:**
- ✅ Secure credential loading from `.env` file
- ✅ Automatic authentication and environment setup
- ✅ Error handling and validation
- ✅ Generates both text and HTML reports
- ✅ Timestamped output directories
- ✅ Optional environment cleanup

## 🚀 Usage

### Prerequisites
1. **Watson x Orchestrate CLI** installed and configured
2. **Environment variables** set in `.env` file:
   ```bash
   ENV_NAME=your-environment-name
   API_KEY=your-api-key
   SERVICE_INSTANCE_URL=your-service-url
   ```

### Run the Script
```bash
# Make script executable (if needed)
chmod +x scripts/final_auto_get_all.sh

# Run the script
./scripts/final_auto_get_all.sh
```

### Output
The script creates a timestamped directory with:
- `agents.txt` - List of AI agents
- `tools.txt` - Custom tools and integrations
- `connections.txt` - API connections
- `knowledge-bases.txt` - Document knowledge bases
- `flows.txt` - Workflow automations
- `evaluations.txt` - Performance evaluations
- `environments.txt` - Environment configurations
- `summary.txt` - Summary report
- `report.html` - HTML report for easy viewing

### Example Output Directory
```
watson_all_items_20250804_143022/
├── agents.txt
├── tools.txt
├── connections.txt
├── knowledge-bases.txt
├── flows.txt
├── evaluations.txt
├── environments.txt
├── summary.txt
└── report.html
```

## 🔧 Customization

### Environment Variables
The script reads these variables from `.env`:
- `ENV_NAME` - Watson x Orchestrate environment name
- `API_KEY` - Your API key for authentication
- `SERVICE_INSTANCE_URL` - Your Watson x Orchestrate instance URL

### Script Modifications
You can modify the script to:
- Add additional data exports
- Change output formats
- Customize report generation
- Add filtering or processing

## 🔐 Security

- **Credentials**: Loaded securely from `.env` file
- **No Hardcoding**: No sensitive data in the script
- **Environment Cleanup**: Optional removal of temporary environments
- **Error Handling**: Graceful failure with informative messages

## 📚 Documentation

For more details, see:
- `../docs/Watson_x_Orchestrate_ADK_Guide.md`
- Script comments for inline documentation

## 🆘 Troubleshooting

### Common Issues
- **Authentication failed**: Check `.env` file credentials
- **Command not found**: Ensure Watson x Orchestrate CLI is installed
- **Permission denied**: Make script executable with `chmod +x`
- **API limits**: Check your Watson x Orchestrate usage limits

### Debug Mode
Add debug output by modifying the script:
```bash
set -x  # Add at the top for verbose output
```
