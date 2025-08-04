# Salesforce Integration with Watson x Orchestrate

This guide helps you integrate Salesforce with Watson x Orchestrate using the provided connection configurations.

## 🔧 Connection Files

### 1. `salesforce-connection.yaml` (OAuth 2.0 - Recommended for Production)
- Uses OAuth 2.0 authentication
- Requires a Salesforce Connected App
- More secure for production environments

### 2. `salesforce-connection-simple.yaml` (Username/Password - Development)
- Uses username/password authentication
- Simpler setup for development/testing
- Requires security token

## 🚀 Quick Setup

### Option A: Simple Authentication (Development)

1. **Get your Salesforce credentials:**
   - Username: Your Salesforce login email
   - Password: Your Salesforce password
   - Security Token: Get from Salesforce Setup → My Personal Information → Reset My Security Token

2. **Update your `.env` file:**
   ```bash
   SALESFORCE_INSTANCE=your-company  # e.g., if your URL is https://mycompany.salesforce.com
   SALESFORCE_USERNAME=your-email@company.com
   SALESFORCE_PASSWORD=your-password
   SALESFORCE_SECURITY_TOKEN=your-security-token
   ```

3. **Deploy the connection:**
   ```bash
   orchestrate connections create -f salesforce-connection-simple.yaml
   ```

### Option B: OAuth 2.0 Authentication (Production)

1. **Create a Salesforce Connected App:**
   - Go to Salesforce Setup → App Manager → New Connected App
   - Enable OAuth Settings
   - Add scopes: `api`, `refresh_token`
   - Set callback URL

2. **Update your `.env` file:**
   ```bash
   SALESFORCE_INSTANCE=your-company
   SALESFORCE_CLIENT_ID=your-connected-app-client-id
   SALESFORCE_CLIENT_SECRET=your-connected-app-client-secret
   SALESFORCE_REDIRECT_URI=https://your-app.com/oauth/callback
   ```

3. **Deploy the connection:**
   ```bash
   orchestrate connections create -f salesforce-connection.yaml
   ```

## 📋 Available Endpoints

Both connection files include these common Salesforce endpoints:

- **Accounts**: `/services/data/v58.0/sobjects/Account`
- **Contacts**: `/services/data/v58.0/sobjects/Contact`
- **Opportunities**: `/services/data/v58.0/sobjects/Opportunity`
- **Leads**: `/services/data/v58.0/sobjects/Lead`
- **Cases**: `/services/data/v58.0/sobjects/Case`
- **Query**: `/services/data/v58.0/query` (SOQL queries)
- **Search**: `/services/data/v58.0/search` (SOSL searches)
- **Describe**: `/services/data/v58.0/sobjects` (Object metadata)

## 🔍 Example Usage

### Query Accounts
```bash
# Using SOQL query
GET /services/data/v58.0/query?q=SELECT Id, Name, Type FROM Account LIMIT 10
```

### Create a Contact
```bash
POST /services/data/v58.0/sobjects/Contact
{
  "FirstName": "John",
  "LastName": "Doe",
  "Email": "john.doe@example.com",
  "AccountId": "001XXXXXXXXXXXXXXX"
}
```

### Update an Opportunity
```bash
PATCH /services/data/v58.0/sobjects/Opportunity/006XXXXXXXXXXXXXXX
{
  "StageName": "Closed Won",
  "Amount": 50000
}
```

## 🛠️ Testing Your Connection

1. **List your connections:**
   ```bash
   orchestrate connections list
   ```

2. **Test the connection:**
   ```bash
   orchestrate connections test salesforce_connection
   ```

3. **Query Salesforce data:**
   ```bash
   # Example: Get all accounts
   orchestrate tools invoke --connection salesforce_connection \
     --endpoint accounts \
     --method GET
   ```

## 🔐 Security Best Practices

1. **Never commit credentials to git** - They're safely stored in `.env`
2. **Use OAuth 2.0 for production** - More secure than username/password
3. **Rotate security tokens regularly** - Especially for username/password auth
4. **Limit API permissions** - Only grant necessary scopes in Connected Apps
5. **Monitor API usage** - Salesforce has API call limits

## 📚 Next Steps

1. Deploy one of the connection configurations
2. Create custom tools that use the Salesforce connection
3. Build agents that can interact with Salesforce data
4. Set up automated workflows between Salesforce and other systems

## 🆘 Troubleshooting

- **Authentication failed**: Check credentials in `.env` file
- **Invalid security token**: Reset token in Salesforce and update `.env`
- **API limits exceeded**: Monitor your Salesforce API usage
- **Connection timeout**: Check your Salesforce instance URL

For more details, see the Watson x Orchestrate documentation and Salesforce REST API guide.
