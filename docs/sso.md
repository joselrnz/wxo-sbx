
0) What IBM needs to turn SSO on

Open a support ticket and include:

Your contact info (name, email, phone, timezone)

Tenant CRN (and Tenant ID)

Your chosen protocol (OIDC recommended; SAML also supported)

If OIDC: Issuer/Well-Known endpoint, Client ID, Client Secret

If SAML: IdP metadata XML
IBM Support will schedule a quick session to complete the hookup. 
IBM

How to grab the IDs they ask for:

Tenant ID / API URL (AWS offering): in Orchestrate, Profile → Settings → API details → Service instance URL (URL shows /instances/<tenant_id>). 
IBM

Tenant CRN: in Orchestrate, Profile → About and copy the crn shown there. 
IBM

1) Okta (OIDC) — create the app integration

In Okta Admin: Applications → Create App Integration → OIDC – Web.

Grant type: Authorization Code (PKCE on is fine)

Sign-in redirect URIs / Sign-out redirect URIs: IBM will give you the exact URIs during the SSO registration call; paste them here.

Assignments: assign only the users/groups who should reach this specific tenant (do one Okta app per Orchestrate tenant: DEV/TEST/PROD, or per BU if you split tenants).

Scopes: at minimum openid profile email (IBM may confirm others on the call).

Save and copy:

Issuer / Authorization server (e.g., https://<your-org>.okta.com/oauth2/default)

Client ID

Client Secret

Well-Known URL (e.g., https://<your-org>.okta.com/.well-known/openid-configuration or the custom-AS equivalent)
Okta setup refs: creating an OIDC app and OIDC/OAuth basics. 
Okta Docs
Okta Developer

Tip: If your Okta org uses a custom authorization server, your issuer and well-known URL will include that server path (not /default). Okta’s API docs show the exact endpoints. 
Okta Developer
