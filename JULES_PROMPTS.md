# Jules Prompts for Scaling MaterialSymbolsKit

## Context
MaterialSymbolsKit is a Swift package that packages Material Symbols as SF Symbols for iOS. The POC (v0.1) has 1 symbol working. Now we need to scale to 100 symbols by running packaging scripts in batches.

**GitHub Repo:** `https://github.com/samuelalake/MaterialSymbolsKit`

---

## Pre-requisites (One-time Setup)

### Prompt 1: Clone and Setup

```
Clone the MaterialSymbolsKit repository and set up the environment:

1. Clone repo: git clone https://github.com/samuelalake/MaterialSymbolsKit.git
2. cd MaterialSymbolsKit
3. Clone Material Design Icons (shallow clone to save space):
   git clone --depth 1 https://github.com/google/material-design-icons.git
4. Verify scripts exist:
   ls -la scripts/
5. Make scripts executable:
   chmod +x scripts/*.sh scripts/*.py

Expected output: Both repos cloned, scripts directory contains:
- popular_symbols.txt
- package_symbols.py
- generate_enum.py
```

---

## Batch Processing (Run these in sequence)

### Prompt 2: Package Symbols (Batch 1-50)

```
Package the first 50 Material Symbols:

1. cd MaterialSymbolsKit
2. Create a temporary file with first 50 symbols from popular_symbols.txt:
   head -n 50 scripts/popular_symbols.txt > scripts/batch_1.txt
3. Run packaging script with this batch:
   SYMBOLS_LIST=scripts/batch_1.txt python3 scripts/package_symbols.py
4. Report:
   - How many symbols were successfully packaged?
   - How many were skipped (not found)?
   - Show the summary output

If any symbols are missing, that's expected - just note which ones.
```

### Prompt 3: Package Symbols (Batch 51-100)

```
Package symbols 51-100:

1. cd MaterialSymbolsKit
2. Create batch file for remaining symbols:
   tail -n +51 scripts/popular_symbols.txt > scripts/batch_2.txt
3. Run packaging:
   SYMBOLS_LIST=scripts/batch_2.txt python3 scripts/package_symbols.py
4. Report:
   - Total symbols packaged in this batch
   - Any errors or skipped symbols
   
After this completes, count total symbolsets:
ls -d Sources/MaterialSymbolsKit/Resources/Symbols.xcassets/*.symbolset | wc -l
```

### Prompt 4: Generate Swift Enum

```
Generate the MaterialSymbols enum from all packaged symbols:

1. cd MaterialSymbolsKit
2. Run enum generation:
   python3 scripts/generate_enum.py
3. Verify the output:
   - Check that Sources/MaterialSymbolsKit/MaterialSymbols.swift was updated
   - Count the enum cases: grep -c "case " Sources/MaterialSymbolsKit/MaterialSymbols.swift
4. Show the first 10 and last 10 enum cases:
   grep "case " Sources/MaterialSymbolsKit/MaterialSymbols.swift | head -n 10
   grep "case " Sources/MaterialSymbolsKit/MaterialSymbols.swift | tail -n 10

Expected: Should have ~90-100 enum cases (some symbols from the list might not exist in Google's repo).
```

### Prompt 5: Build and Test

```
Build and test the package:

1. cd MaterialSymbolsKit
2. Clean build:
   swift package clean
3. Build:
   swift build
4. Run tests:
   swift test
5. Report:
   - Did the build succeed?
   - Did all tests pass?
   - Show the test output summary

If there are any errors, show the error messages.
```

### Prompt 6: Commit and Push

```
Commit the packaged symbols and push to GitHub:

1. cd MaterialSymbolsKit
2. Check status:
   git status
3. Add all new symbol assets:
   git add Sources/MaterialSymbolsKit/Resources/Symbols.xcassets/
   git add Sources/MaterialSymbolsKit/MaterialSymbols.swift
   git add scripts/batch_*.txt
4. Commit with descriptive message:
   git commit -m "Package 100 Material Symbols for v1.0

- Added ~90-100 popular Material Symbols
- Generated MaterialSymbols enum with all cases
- All symbols validated and tested
- Ready for v1.0 release

Packaged using automated batch processing."

5. Push to main:
   git push origin main

6. Report the commit hash and confirmation that push succeeded.
```

---

## Verification (Final Check)

### Prompt 7: Verify Package Installation

```
Verify the package can be installed and used:

1. Create a test Swift package:
   mkdir -p /tmp/MaterialSymbolsKitTest
   cd /tmp/MaterialSymbolsKitTest
   swift package init --type executable

2. Add MaterialSymbolsKit as dependency in Package.swift:
   Edit Package.swift to add:
   dependencies: [
       .package(url: "https://github.com/samuelalake/MaterialSymbolsKit.git", branch: "main")
   ]
   And add "MaterialSymbolsKit" to the target dependencies.

3. Try to build:
   swift build

4. Report if it builds successfully and what symbols are available.

This verifies the package is installable from GitHub.
```

---

## Alternative: Parallel Processing (Faster)

If Jules supports parallel tasks, use these instead of Prompts 2-3:

### Prompt 2A: Package All Symbols (Parallel)

```
Package all Material Symbols in one go:

1. cd MaterialSymbolsKit
2. Run the full packaging script:
   python3 scripts/package_symbols.py
3. This will process all symbols from scripts/popular_symbols.txt
4. Report:
   - Total symbols processed
   - Successfully packaged count
   - Skipped count
   - List any symbols that were skipped

Then continue with Prompt 4 (Generate Swift Enum).
```

---

## Troubleshooting Prompts

### If "material-design-icons not found" error:

```
The material-design-icons repository is missing. Clone it:

cd MaterialSymbolsKit
git clone --depth 1 https://github.com/google/material-design-icons.git

Verify it exists:
ls -la material-design-icons/symbols/ios/

You should see directories for each symbol (home, menu, search, etc.)
```

### If "Permission denied" on scripts:

```
Make scripts executable:

cd MaterialSymbolsKit
chmod +x scripts/*.sh
chmod +x scripts/*.py

Try running the command again.
```

### If symbols are missing:

```
Some symbols in popular_symbols.txt might not exist in Google's repo. This is normal.

To see which symbols are available, list them:
ls material-design-icons/symbols/ios/ | head -n 20

We expect ~80-90% success rate. Any symbols that don't exist will be skipped automatically.
```

---

## Expected Timeline

- **Setup (Prompt 1)**: ~2 minutes (cloning repos)
- **Batch 1 (Prompt 2)**: ~1-2 minutes (50 symbols)
- **Batch 2 (Prompt 3)**: ~1-2 minutes (50 symbols)
- **Generate Enum (Prompt 4)**: ~10 seconds
- **Build & Test (Prompt 5)**: ~30 seconds
- **Commit & Push (Prompt 6)**: ~30 seconds
- **Verify (Prompt 7)**: ~1 minute

**Total: ~7-10 minutes** for full automation

---

## Success Criteria

✅ 80-100 symbols packaged  
✅ MaterialSymbols.swift contains all enum cases  
✅ `swift build` succeeds  
✅ `swift test` passes  
✅ Changes committed and pushed to GitHub  
✅ Package installable from GitHub  

---

## For Your Records (EB-1 Documentation)

This demonstrates:
- ✅ **Strategic Scaling**: POC → Full scale via automation
- ✅ **Infrastructure Thinking**: Batch processing, parallel execution
- ✅ **Reproducibility**: Clear prompts, automated scripts
- ✅ **Delegation**: Leveraging cloud AI for repetitive tasks
- ✅ **Verification**: Build, test, and installation validation

**Key Message for EB-1**: "Rather than manually package 100 symbols, I designed a scalable system with automated scripts and clear documentation, enabling delegation to cloud AI workers. This demonstrates engineering leadership and strategic thinking beyond individual coding."

🚀 Ready to hand these to Jules!

