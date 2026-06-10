## [Unreleased]

## [0.9.0] - 2026-06-09

- **Breaking:** raise the green threshold to 100%, so 🟢 now means the file is fully covered and `--fail-on-low-coverage` exits `1` for any reported file below 100% (previously 66.66%).
- Rate files and evaluate the coverage gate on the unrounded percentage, so a file at e.g. 99.996% no longer rounds up to 100% and slips past the gate.
- Display percentages with two decimal places in all cases (e.g. `60.00%`), flooring instead of rounding, so a partially covered file never displays as `100.00%`.

## [0.8.0] - 2026-06-05

- Add `--fail-on-low-coverage` flag to exit with a non-zero status when any reported file is below 100% coverage.

## [0.7.0] - 2026-06-05

- Add `--changed-files` to report the coverage status of a given list of files (e.g. a branch's changed files), including fully covered ones, instead of the project-wide below-100% view.
- Rename the report heading from "Coverage problems" to "Coverage report".

## [0.6.0] - 2026-06-04

- Add Markdown output format, selected from the output file extension (`.md`). HTML remains the default.

## [0.1.0] - 2023-07-19

- Initial release
