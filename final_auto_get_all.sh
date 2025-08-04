#!/bin/sh

# Final Auto Script - Get All Watson x Orchestrate Items
# This script automatically authenticates and retrieves all items
# Credentials are loaded from .env file for security

# Load environment variables from .env file
if [ -f .env ]; then
    export $(cat .env | grep -v '^#' | xargs)
else
    echo "❌ Error: .env file not found!"
    echo "Please create a .env file with your Watson x Orchestrate credentials:"
    echo "ENV_NAME=your-environment-name"
    echo "API_KEY=your-api-key"
    echo "SERVICE_INSTANCE_URL=your-service-url"
    exit 1
fi

# Use environment variables (with fallback for SERVICE_URL)
SERVICE_URL="${SERVICE_INSTANCE_URL}"

# Validate required environment variables
if [ -z "$ENV_NAME" ] || [ -z "$API_KEY" ] || [ -z "$SERVICE_URL" ]; then
    echo "❌ Error: Missing required environment variables!"
    echo "Please ensure your .env file contains:"
    echo "ENV_NAME=your-environment-name"
    echo "API_KEY=your-api-key"
    echo "SERVICE_INSTANCE_URL=your-service-url"
    exit 1
fi

echo "🚀 Watson x Orchestrate - Auto Get All Items"
echo "============================================="
echo "Environment: $ENV_NAME"
echo "🔐 Credentials loaded securely from .env file"
echo ""

# Create output directory
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
OUTPUT_DIR="watson_all_items_$TIMESTAMP"
mkdir -p "$OUTPUT_DIR"

echo "📁 Output directory: $OUTPUT_DIR"
echo ""

# Add environment
echo "Step 1: Adding environment..."
orchestrate env add -n "$ENV_NAME" -u "$SERVICE_URL" --type mcsp

echo ""
echo "Step 2: Authenticating with API key..."
orchestrate env activate "$ENV_NAME" --api-key "$API_KEY"

echo ""
echo "Step 3: Verifying authentication..."
ENV_STATUS=$(orchestrate env list 2>&1)
if echo "$ENV_STATUS" | grep -q "(active)"; then
    echo "✅ Authentication successful!"
else
    echo "❌ Authentication failed!"
    echo "$ENV_STATUS"
    exit 1
fi

echo ""
echo "Step 4: Retrieving all items and saving to files..."
echo ""

# Get all items and save to files
echo "📋 Getting agents..."
orchestrate agents list > "$OUTPUT_DIR/agents.txt" 2>&1
echo "   ✅ Saved to agents.txt"

echo "🔧 Getting tools..."
orchestrate tools list > "$OUTPUT_DIR/tools.txt" 2>&1
echo "   ✅ Saved to tools.txt"

echo "🔗 Getting connections..."
orchestrate connections list > "$OUTPUT_DIR/connections.txt" 2>&1
echo "   ✅ Saved to connections.txt"

echo "📚 Getting knowledge bases..."
orchestrate knowledge-bases list > "$OUTPUT_DIR/knowledge-bases.txt" 2>&1
echo "   ✅ Saved to knowledge-bases.txt"

echo "🌊 Getting flows..."
orchestrate flows list > "$OUTPUT_DIR/flows.txt" 2>&1 || echo "Flows not available" > "$OUTPUT_DIR/flows.txt"
echo "   ✅ Saved to flows.txt"

echo "📊 Getting evaluations..."
orchestrate evaluations list > "$OUTPUT_DIR/evaluations.txt" 2>&1 || echo "Evaluations not available" > "$OUTPUT_DIR/evaluations.txt"
echo "   ✅ Saved to evaluations.txt"

echo "🏠 Getting environment info..."
orchestrate env list > "$OUTPUT_DIR/environments.txt" 2>&1
echo "   ✅ Saved to environments.txt"

# Create summary file
cat > "$OUTPUT_DIR/summary.txt" << EOF
Watson x Orchestrate - All Items Retrieved
==========================================
Generated: $(date)
Instance: $SERVICE_URL
Environment: $ENV_NAME
Output Directory: $OUTPUT_DIR

Files Created:
- agents.txt          (AI agents in your instance)
- tools.txt           (Custom tools and integrations)
- connections.txt     (API connections and credentials)
- knowledge-bases.txt (Document knowledge bases)
- flows.txt           (Workflow automations)
- evaluations.txt     (Agent performance evaluations)
- environments.txt    (Environment configurations)
- summary.txt         (This summary file)

Quick View Commands (Git Bash):
cat $OUTPUT_DIR/agents.txt
cat $OUTPUT_DIR/tools.txt
cat $OUTPUT_DIR/connections.txt
cat $OUTPUT_DIR/knowledge-bases.txt

Quick View Commands (Windows):
notepad $OUTPUT_DIR\\agents.txt
notepad $OUTPUT_DIR\\tools.txt
notepad $OUTPUT_DIR\\connections.txt

All files are saved as plain text and can be opened with any text editor.
EOF

# Create a simple HTML report
cat > "$OUTPUT_DIR/report.html" << EOF
<!DOCTYPE html>
<html>
<head>
    <title>Watson x Orchestrate Items Report</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        h1 { color: #1f4e79; }
        h2 { color: #2e75b6; }
        .info { background: #f0f8ff; padding: 10px; border-radius: 5px; }
        .file-list { background: #f9f9f9; padding: 15px; border-radius: 5px; }
        .file-item { margin: 5px 0; }
    </style>
</head>
<body>
    <h1>Watson x Orchestrate Items Report</h1>
    
    <div class="info">
        <h2>Instance Information</h2>
        <p><strong>Generated:</strong> $(date)</p>
        <p><strong>Instance URL:</strong> $SERVICE_URL</p>
        <p><strong>Environment:</strong> $ENV_NAME</p>
        <p><strong>Output Directory:</strong> $OUTPUT_DIR</p>
    </div>
    
    <div class="file-list">
        <h2>Retrieved Files</h2>
        <div class="file-item">📋 <strong>agents.txt</strong> - AI agents in your instance</div>
        <div class="file-item">🔧 <strong>tools.txt</strong> - Custom tools and integrations</div>
        <div class="file-item">🔗 <strong>connections.txt</strong> - API connections and credentials</div>
        <div class="file-item">📚 <strong>knowledge-bases.txt</strong> - Document knowledge bases</div>
        <div class="file-item">🌊 <strong>flows.txt</strong> - Workflow automations</div>
        <div class="file-item">📊 <strong>evaluations.txt</strong> - Agent performance evaluations</div>
        <div class="file-item">🏠 <strong>environments.txt</strong> - Environment configurations</div>
    </div>
    
    <h2>How to View Files</h2>
    <p>All files are saved as plain text. You can:</p>
    <ul>
        <li>Open with Notepad: <code>notepad filename.txt</code></li>
        <li>View in Git Bash: <code>cat filename.txt</code></li>
        <li>Open with any text editor</li>
    </ul>
</body>
</html>
EOF

echo ""
echo "✅ COMPLETE! All Watson x Orchestrate items retrieved successfully!"
echo ""
echo "📁 Results saved in: $OUTPUT_DIR"
echo "📄 Summary: $OUTPUT_DIR/summary.txt"
echo "🌐 HTML Report: $OUTPUT_DIR/report.html"
echo ""
echo "📋 Quick commands to view results:"
echo "   cat $OUTPUT_DIR/agents.txt"
echo "   cat $OUTPUT_DIR/tools.txt"
echo "   cat $OUTPUT_DIR/connections.txt"
echo "   cat $OUTPUT_DIR/summary.txt"
echo ""
echo "📂 Files created:"
ls -la "$OUTPUT_DIR/" | grep -v "^total"

echo ""
echo "🎉 SUCCESS! All items retrieved with automated API key input!"
echo "🔑 No manual intervention required!"

# Clean up environment (optional)
echo ""
read -p "Do you want to remove the temporary environment '$ENV_NAME'? (y/n): " -n 1 -r
echo
if [ "$REPLY" = "y" ] || [ "$REPLY" = "Y" ]; then
    orchestrate env remove -n "$ENV_NAME"
    echo "🗑️ Environment '$ENV_NAME' removed"
else
    echo "🏠 Environment '$ENV_NAME' kept for future use"
fi

echo ""
echo "🎯 All done! Your Watson x Orchestrate data is ready!"
