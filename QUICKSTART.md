# Quick Start Guide

This guide will help you get started with the Robot Framework Accessibility Testing suite.

## Step 1: Installation

```bash
# Clone the repository
git clone https://github.com/pubertoblanco/robot.git
cd robot

# Install dependencies
pip install -r requirements.txt
```

## Step 2: Configure URLs

Edit the `urls.txt` file to include the URLs you want to test:

```text
https://www.example.com
https://www.yoursite.com/page1
https://www.yoursite.com/page2
```

## Step 3: Run Tests

### Run all tests (all violations)
```bash
robot --outputdir results tests/accessibility_tests.robot
```

### Run tests with impact filtering
```bash
# Test only for critical violations
robot --variable IMPACT:critical --outputdir results tests/accessibility_tests.robot

# Test only for serious violations
robot --variable IMPACT:serious --outputdir results tests/accessibility_tests.robot
```

### Use a custom URLs file
```bash
robot --variable URLS_FILE:my-urls.txt --outputdir results tests/accessibility_tests.robot
```

### Combine options
```bash
robot --variable IMPACT:serious \
      --variable URLS_FILE:production-urls.txt \
      --outputdir results \
      tests/accessibility_tests.robot
```

## Step 4: View Reports

After the tests complete, open the HTML reports:

- `results/report.html` - Summary of test execution
- `results/log.html` - Detailed test log with violations

## Step 5: Use in GitHub Actions

The workflow is automatically configured in `.github/workflows/accessibility-tests.yml`.

### Automatic runs
- Tests run automatically on push to main/master
- Tests run automatically on pull requests

### Manual runs
1. Go to the **Actions** tab in GitHub
2. Select **Accessibility Tests**
3. Click **Run workflow**
4. Enter optional parameters:
   - **impact**: Filter by impact level (critical, serious, moderate, minor)
   - **urls_file**: Path to custom URLs file
5. Click **Run workflow** button

## Examples

### Example 1: Test a single website
Create a file `single-site.txt`:
```
https://www.example.com
```

Run:
```bash
robot --variable URLS_FILE:single-site.txt --outputdir results tests/accessibility_tests.robot
```

### Example 2: Test only critical issues
```bash
robot --variable IMPACT:critical --outputdir results tests/accessibility_tests.robot
```

### Example 3: Run example test with impact filtering
```bash
robot --outputdir results tests/example_impact_filter.robot
```

## Understanding Results

### Violations
Each violation includes:
- **ID**: Unique identifier for the rule
- **Impact**: Severity level (critical, serious, moderate, minor)
- **Description**: What the issue is
- **Help URL**: Link to documentation on how to fix it
- **Affected nodes**: Number of HTML elements with this issue

### Impact Levels
- **Critical**: Issues that will definitely impact accessibility
- **Serious**: Issues that are likely to impact accessibility
- **Moderate**: Issues that may impact accessibility
- **Minor**: Issues with minimal impact on accessibility

## Troubleshooting

### Issue: Browser not found
**Solution**: Make sure Chrome/Chromium is installed:
```bash
# Ubuntu/Debian
sudo apt-get install chromium-browser

# Or download Chrome from google.com/chrome
```

### Issue: Tests fail due to timeouts
**Solution**: Increase timeout in the test file or check your internet connection.

### Issue: Permission denied
**Solution**: Make sure you have write permissions in the results directory:
```bash
mkdir -p results
chmod 755 results
```

## Next Steps

1. Customize the test suite for your needs
2. Add more URLs to test
3. Set up GitHub Actions for automated testing
4. Integrate with your CI/CD pipeline
5. Fix violations as they are discovered

For more information, see the main [README.md](README.md).
