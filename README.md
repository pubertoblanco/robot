# Robot Framework Accessibility Testing

Automated accessibility testing framework using Robot Framework, Selenium, and axe-core for testing multiple websites.

## Features

- ✅ **Keyword-driven testing** with Robot Framework
- ✅ **axe-core integration** for comprehensive accessibility analysis
- ✅ **URL list support** - test multiple websites from a file
- ✅ **Optional impact filtering** - filter by critical, serious, moderate, or minor violations
- ✅ **GitHub Actions integration** - automated testing in CI/CD
- ✅ **HTML reports** - detailed test reports and logs
- ✅ **Latest libraries** - using the most recent stable versions
- ✅ **Clean, maintainable code** - following best practices

## Prerequisites

- Python 3.8 or higher
- Chrome/Chromium browser (for local testing)

## Installation

1. Clone the repository:
```bash
git clone https://github.com/pubertoblanco/robot.git
cd robot
```

2. Install dependencies:
```bash
pip install -r requirements.txt
```

## Usage

### Basic Usage

Run tests with default settings (all violations, URLs from urls.txt):
```bash
robot --outputdir results tests/accessibility_tests.robot
```

### Filter by Impact Level

Test only for critical violations:
```bash
robot --variable IMPACT:critical --outputdir results tests/accessibility_tests.robot
```

Available impact levels:
- `critical` - Critical accessibility issues
- `serious` - Serious accessibility issues
- `moderate` - Moderate accessibility issues
- `minor` - Minor accessibility issues
- (empty) - All violations (default)

### Custom URLs File

Use a different URLs file:
```bash
robot --variable URLS_FILE:my-urls.txt --outputdir results tests/accessibility_tests.robot
```

### View HTML Reports

After running tests, open the generated HTML reports:
- `results/report.html` - Test execution report
- `results/log.html` - Detailed test log

## URL File Format

Create a text file with one URL per line:

```text
https://www.example.com
https://www.w3.org/WAI/demos/bad/
https://www.google.com

# Lines starting with # are ignored
# Blank lines are also ignored
```

## GitHub Actions

The workflow runs automatically on:
- Push to main/master branch
- Pull requests to main/master branch
- Manual trigger with optional parameters

### Manual Workflow Trigger

1. Go to **Actions** tab in GitHub
2. Select **Accessibility Tests** workflow
3. Click **Run workflow**
4. (Optional) Set impact level filter
5. (Optional) Specify custom URLs file path

### Workflow Inputs

- `impact`: Impact level filter (optional)
- `urls_file`: Path to URLs file (default: urls.txt)

## Project Structure

```
.
├── .github/
│   └── workflows/
│       └── accessibility-tests.yml    # GitHub Actions workflow
├── keywords/
│   └── AxeLibrary.py                  # Custom Robot Framework library for axe
├── tests/
│   └── accessibility_tests.robot      # Main test suite
├── urls.txt                            # Default URLs to test
├── requirements.txt                    # Python dependencies
└── README.md                           # This file
```

## Custom Keywords

### AxeLibrary Keywords

**Run Axe Analysis**
- Runs axe-core analysis on the current page
- Parameters: `impact_level` (optional)
- Returns: List of violations

```robot
${violations}=    Run Axe Analysis
${violations}=    Run Axe Analysis    serious
```

**Get Axe Results**
- Returns complete axe-core results object
- Includes violations, passes, incomplete, and inapplicable checks

```robot
${results}=    Get Axe Results
```

## Dependencies

- **robotframework** (7.1.1) - Test automation framework
- **robotframework-seleniumlibrary** (6.6.1) - Selenium integration for Robot Framework
- **robotframework-browser** (18.8.0) - Modern browser automation
- **axe-selenium-python** (2.1.6) - axe-core accessibility testing
- **selenium** (4.26.1) - Browser automation

## Best Practices

1. **Keep URLs file updated** - Regularly review and update the list of URLs to test
2. **Start with critical issues** - Use impact filtering to prioritize high-impact violations
3. **Review reports regularly** - Check HTML reports for detailed violation information
4. **Integrate early** - Run accessibility tests in CI/CD pipeline
5. **Fix violations promptly** - Address accessibility issues as they are discovered

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Run tests locally
5. Submit a pull request

## License

This project is open source and available under the MIT License.

## Resources

- [Robot Framework Documentation](https://robotframework.org/robotframework/)
- [axe-core Documentation](https://github.com/dequelabs/axe-core)
- [WCAG Guidelines](https://www.w3.org/WAI/WCAG21/quickref/)
- [Selenium Documentation](https://www.selenium.dev/documentation/)