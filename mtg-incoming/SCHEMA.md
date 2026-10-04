# Raw MTG Deck Intake Contract

## Raw record

```text
intake_id: HH-MTG-YYYYMMDD-NNN
source: BIGGIE_PHONE | WIFE_PHONE
captured_at:
raw_text:
status: RAW
```

## Normalized record

```text
deck_id:
name:
commander:
colour_identity:
strategy:
rough_value:
asking_price:
location:
availability:
customization_envelope:
raw_intake_ref:
media_refs:
status: NORMALIZED | NEEDS_REVIEW | READY
```

## Truth boundary

Raw text is immutable intake evidence. Normalized fields are derived from the raw text and may be revised. Unknown remains unknown. Ambiguous card/deck identity is flagged rather than guessed.

## Commercial boundary

Pre-sale processing is intentionally lightweight. No exhaustive card scan, condition audit, or individual-card repricing is required before a deck becomes a catalogue candidate.

Post-purchase processing is where physical verification, personalization, final decklist generation, fulfillment, and evidence sealing occur.
