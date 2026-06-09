# Happyhomarid / DreamLedger - Minimal Revenue Loop

This repo contains the minimal practical scripts for reaching paying patrons and generating sales for pre-built Commander decks.

## Quick Start

1. Run the Neural Factory to generate content
2. Run the Patreon Revenue script to post and email

## Scripts

- `Minimal-Neural-Factory.ps1` : Generates simple Patreon posts and emails
- `Minimal-Patreon-Revenue.ps1` : Posts to Patreon and emails active patrons

## Daily Command

```powershell
cd C:\BrownEyeCortex

.\Minimal-Neural-Factory.ps1 -GeneratePost
.\Minimal-Neural-Factory.ps1 -GenerateEmail

.\Minimal-Patreon-Revenue.ps1 -DryRun
```

When ready, remove -DryRun.

## Focus

This is the execution layer for revenue. Run consistently. No more architecture needed until revenue is stable.

Built for Joshua / Happyhomarid.