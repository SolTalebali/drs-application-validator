# drs-application-validator

A simplified model of HM Land Registry's Digital Registration Service (DRS), built as a Ruby/RSpec learning project. An `Application` for a land-registry transaction (transfer, charge, or lease) is run through a set of validation rules, producing a `RequisitionReport` that lists any defects — "requisition" being HMLR's term for a query raised against a defective application.

## Domain model

- **`Application`** — title number, applicants (parties), transaction type, fee paid, and supplied documents.
- **Rules** (`lib/rules/`) — each rule is a small, duck-typed class with a `check(application)` method, returning a `Defect` or `nil`:
  - `TitleNumberFormatRule` — title number matches the expected format.
  - `PartiesPresentRule` — at least one applicant, each with required name fields.
  - `FeeCorrectRule` — fee paid matches the expected fee for the transaction type.
  - `RequiredDocumentsRule` — all documents required for the transaction type are present.
  - `TransactionTypeKnownRule` — transaction type is a recognised one.
- **`ApplicationValidator`** (`lib/engine/`) — runs a set of rules against an `Application` and collects the resulting defects.
- **`RequisitionReport`** (`lib/engine/`) — wraps a list of defects; reports whether the application is clean.
- **`ApplicationLoader`** — reads an `Application` from a JSON file.

## Setup

```
bundle install
```

## Running the tests

```
bundle exec rspec
```
