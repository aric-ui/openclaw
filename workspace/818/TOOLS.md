# TOOLS.md - 818 Shutters and Shades Local Notes

## Business Info

- **Company:** 818 Shutters & Shades
- **License:** CA Contractor License #1147886
- **Contact:** (818) 665-7244 | hello@818shuttersandshades.com
- **Service Area:** Los Angeles / Ventura County
  - Primary Cities: Calabasas, Hidden Hills, Westlake Village, Thousand Oaks, Woodland Hills, Agoura Hills, Santa Clarita, Simi Valley, Moorpark, Camarillo, Oxnard, Ventura
  - Area Codes: 818, 805, 661, 747
- **Owner:** Aric Weinberg

---

## MCP Server Tools (Live CRM Access)

| Tool | Purpose | Example |
|------|---------|---------|
| `search_leads` | Find leads by name, phone, email, status, date | "Show me all new leads from this week" |
| `get_lead_details` | Full lead info with appointments, comms | "What's the history on the Johnson lead?" |
| `search_appointments` | Find by date, consultant, status | "What's on the schedule for Friday?" |
| `search_quotes` | Find by customer, status, amount range | "Show quotes over $10k pending response" |
| `get_quote_details` | Full quote with line items, payments | "What did we quote the Smiths?" |
| `search_projects` | Find installs by status, customer, date | "What's in manufacturing right now?" |
| `get_team_members` | Staff info + commission rates | "Who's the assigned consultant?" |
| `get_commissions` | Commission status and payouts | "What's owed to the sales team?" |
| `get_system_health` | Audit findings and data issues | "Any data issues I should know about?" |
| `get_business_metrics` | Lead counts, appointment rates, revenue | "How are we doing this month?" |
| `analyze_competitor_quote` | Extract competitor quote, match to 818 | PDF/image analysis |

**Rule:** If data exists → QUERY IT. Never estimate numbers.

---

## Tech Stack

### Core Systems
- **CRM + Quote Builder** — Room-by-room config, A/B variants, product pricing
- **Quote Management** — E-signatures, Stripe payments
- **Supabase** — All pricing data lives here (never hardcode)
- **Post-Sale Pipeline:** Sold → Manufacturing → Ready to Schedule → Install Scheduled → Installed → Completed

### Existing AI Agents (Coordinate, Don't Duplicate)
- **SMS Consultant Agent** — Consultants text for leads/appointments/tasks
- **Dashboard Agent** — Internal metrics
- **Instant Quote Engine** — Conversational quoting + competitor analysis

---

## Pricing Quick Reference

| Item | Value |
|------|-------|
| Public Quote Markup | 1.18x (18%) |
| Minimum sqft | 8 |
| Dealer Cost Multiplier | 0.30x |
| Floor Margin | 20% (never below) |
| Approval Required | 25% |
| Target Margin | 35% |
| Shutter Lead Time Multiplier | 0.285 |

### Pricing Tiers
| Tier | Multiplier | Use Case |
|------|------------|----------|
| Competitive | 0.78x | Price-sensitive, multiple bids |
| Standard | 1.00x | Normal consultations |
| Premium | 1.12x | Design-focused, high-end |

---

## Product Quick Reference

### Shutters — Norman
- Programs: Woodlore Plus, Normandy, Sussex (Painted/Stained)
- Rate: $14.00 – $18.75/sqft
- Freight: $75 first / $25 additional
- Oversize: $80 (height > 90")
- Tariff: 8% (except Woodlore)
- CC Fee: 2%

### Shutters — Onyx
- Programs: Vinyl, Painted Basswood, Stained Basswood, Secamore, VLO Hybrid, US Made Vinyl
- Rate: $12.00 – $16.50/sqft
- Freight: FREE
- Hidden Tilt: $1.20/sqft surcharge
- Tariff: None
- CC Fee: 2%

### Soft Goods (Supabase Pricing)
- **Shades:** Honeycomb, Roller, Roman, PerfectSheer
- **Blinds:** Faux Wood, Wood, Vertical
- **Drapes:** SmartDrape
- Use 6-inch round-up rule for grid lookup

### Risk Levels
- **Shutters** = Highest margin + complexity + remake risk
- **Roman** = Higher remake risk (detail-sensitive)
- **Roller/Honeycomb** = Volume + speed

---

## Security Reminders

### MTS Installations = VENDOR (Hard Separation)
**Never share with MTS:**
- CRM access
- Pricing logic / margin data
- Automation / AI memory
- API keys / credentials

**OK to share (job-specific only):**
- Install packet PDFs
- Final measurements
- Product specs for install
- Job schedule
- Site notes

### Access Tiers
- **Tier 1 (Owner/Core Ops):** Full access
- **Tier 2 (Sales/Design):** Quotes, specs, measurements — NO margins
- **Tier 3 (Install/Vendor):** Read-only, job-specific, time-limited

If access doesn't fit a tier → **DENY**.

---

## Automation Cadence

| Trigger | Timing | Channel |
|---------|--------|---------|
| New lead follow-up | 24 hours | SMS/Call task |
| Quote follow-up | 48 hours after send | SMS |
| Stale lead re-engagement | 14 days | Email |
| Review request | 24 hours post-install | SMS/Email |

**SMS Quiet Hours:** 10 PM – 7 AM PT

---

## Inter-Agent Communication

### Willie (MTS Bot)
- **Agent ID:** main
- **Purpose:** Coldjack's primary assistant (handles MTS Installations)
- **How to reach:** `sessions_send(agentId: "main", message: "...")`

### Protocol
When messaging Willie:
- Prefix with `[FROM 818]` so they know the source
- Keep messages actionable and clear

When receiving from Willie:
- They'll prefix with `[FROM WILLIE]`
- Relay important stuff to operator if needed

---

## Coding Rules

I don't write production code. I plan, supervise, review.
→ "Use Claude Code to implement this. I will review."

---

Add notes here as I learn more.
