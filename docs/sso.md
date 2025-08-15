# SSO with Okta for IBM watsonx Orchestrate (AWS SaaS)

A concise, end-to-end plan to enable Single Sign-On (SSO) with **Okta** for the **IBM-managed AWS** version of watsonx Orchestrate.

---

# 0) What IBM Needs to Turn SSO On

Open an IBM Support ticket and include:

* Your **contact info** (name, email, phone, timezone)
* **Tenant CRN** and **Tenant ID**
* Chosen protocol: **OIDC** (recommended) or **SAML**
* If **OIDC**: **Issuer / Well-Known endpoint**, **Client ID**, **Client Secret**
* If **SAML**: **IdP metadata XML**

**Where to find tenant identifiers in Orchestrate**

* **Tenant ID**: Profile → **Settings** → **API details** → in the Service instance URL (`/instances/<tenant_id>`)
* **CRN**: Profile → **About** → copy the **crn**

---

# 1) Okta (OIDC) — Create the App Integration

In Okta Admin: **Applications → Create App Integration → OIDC – Web**

* **Grant type**: Authorization Code (PKCE is fine)
* **Redirect URIs**: add the **sign-in** and **sign-out** URIs provided by IBM during the SSO registration call
  *(You can create the app now and paste these URIs later.)*
* **Scopes**: `openid`, `profile`, `email`
* **Assignments**: assign only the users/groups who should access **this specific tenant** (create one Okta app **per tenant**: DEV/TEST/PROD, or per BU if you split tenants)

**Save these values to share with IBM**

* **Issuer / Authorization server** (e.g., `https://<your-org>.okta.com/oauth2/default` or your custom AS)
* **Well-Known URL** (e.g., `https://<your-org>.okta.com/.well-known/openid-configuration` or custom AS equivalent)
* **Client ID**
* **Client Secret**

> **Tip:** If you use a **custom authorization server**, the Issuer and Well-Known URL will reference that server path (not `/default`).

---

# 2) Open the IBM Support Ticket

**Subject**: Enable SSO for watsonx Orchestrate (AWS SaaS) – `<your_company_domain>`

Include:

* Contact info
* **Tenant CRN** and **Tenant ID**
* Protocol (**OIDC** or **SAML**)
* If **OIDC**: Issuer, Well-Known URL, Client ID, Client Secret
* If **SAML**: IdP Metadata XML

**Template (copy/paste):**

```text
Subject: Enable SSO for watsonx Orchestrate (AWS SaaS) – <your_company_domain>

Contacts:
- Name: <name>
- Email: <email>
- Phone: <phone>
- Timezone/Availability: <tz and hours>

Tenant:
- CRN: <paste CRN>
- Tenant ID: <paste tenant_id>

Protocol: OIDC | SAML

OIDC (if chosen):
- Issuer / Auth Server: <https://.../oauth2/...>
- Well-Known: <https://.../.well-known/openid-configuration>
- Client ID: <id>
- Client Secret: <secret>

SAML (if chosen):
- IdP Metadata XML attached

Notes:
- Please register our domain for SSO and provide final redirect URIs to add in Okta.
```

---

# 3) Test SSO

1. Go to the Orchestrate login page → click **Log in with SSO**
2. Enter your **company domain** → you should be redirected to **Okta**
3. Authenticate → you’re redirected back to Orchestrate’s landing page

> **Multiple tenants?** Use **Help → Switch account** (`/landing/accounts`). Close other WXO tabs first; switching works best with a single active tab.

---

# 4) Control Who Gets Into Which Tenant

* Keep **one Okta OIDC app per tenant** (`wxo-dev`, `wxo-test`, `wxo-prod`, etc.)
* In Okta, assign the app only to the **right groups/users** for that tenant
* After users first sign in, set their **Orchestrate role** under **Manage → Users**:

  * **Admin** – manage members & build
  * **Builder** – build agents/tools
  * **User** – run/use agents

*(There are no native “groups” inside a tenant; access is **Team membership + Role**.)*

---

# 5) (Optional) SAML Path

If your security team prefers SAML:

1. Create an **Okta SAML 2.0** app
2. Download the **IdP Metadata XML**
3. Provide it to IBM (with Tenant CRN/ID) in the ticket
4. IBM completes SAML registration; then test like in step 3

---

# Appendix A — Pre-Ticket Checklist

* [ ] Tenant **CRN** (Profile → About)
* [ ] **Tenant ID** (Profile → Settings → API details)
* [ ] Protocol decided: **OIDC** (preferred) or **SAML**
* **If OIDC (from Okta):**

  * [ ] **Issuer / Authorization server**
  * [ ] **Well-Known URL**
  * [ ] **Client ID**
  * [ ] **Client Secret**
* **If SAML (from Okta):**

  * [ ] **IdP Metadata XML**

---

# Appendix B — Okta App Settings (OIDC)

* App type: **OIDC – Web**
* Redirect URIs: **use the exact sign-in/sign-out URIs IBM provides**
* Scopes: `openid`, `profile`, `email`
* Assignments: only the groups/users for that tenant

---

Need me to tailor this to your actual tenant names and Okta groups?
