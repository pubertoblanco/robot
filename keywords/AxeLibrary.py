"""
AxeLibrary - Robot Framework library for accessibility testing with axe-core

This library provides keywords for running axe-core accessibility analysis
on web pages using Selenium WebDriver.
"""

from axe_selenium_python import Axe
from robot.api import logger
from robot.api.deco import keyword
from SeleniumLibrary import SeleniumLibrary


class AxeLibrary:
    """
    Robot Framework library for accessibility testing using axe-core.

    This library integrates axe-core accessibility testing into Robot Framework
    test suites, allowing for automated detection of accessibility violations.
    """

    ROBOT_LIBRARY_SCOPE = 'GLOBAL'
    ROBOT_LIBRARY_VERSION = '1.0.0'

    def __init__(self):
        """Initialize the AxeLibrary."""
        self.selenium_lib = None

    def _get_driver(self):
        """Get the Selenium WebDriver instance from SeleniumLibrary."""
        if self.selenium_lib is None:
            self.selenium_lib = SeleniumLibrary()
        return self.selenium_lib.driver

    @keyword("Run Axe Analysis")
    def run_axe_analysis(self, impact_level=None):
        """
        Run axe accessibility analysis on the current page.

        Args:
            impact_level: Optional impact level filter (critical, serious, moderate, minor)
                         If not provided or empty, all violations are returned.

        Returns:
            List of accessibility violations found on the page.

        Example:
            | ${violations}= | Run Axe Analysis |
            | ${violations}= | Run Axe Analysis | serious |
        """
        driver = self._get_driver()
        axe = Axe(driver)

        # Inject axe-core JavaScript
        axe.inject()

        # Run axe analysis
        results = axe.run()

        # Get violations
        violations = results.get('violations', [])

        # Filter by impact level if specified
        if impact_level and impact_level.strip():
            impact_level = impact_level.strip().lower()
            violations = [v for v in violations if v.get('impact', '').lower() == impact_level]
            logger.info(f"Filtered violations by impact level: {impact_level}")

        # Log summary
        logger.info(f"Found {len(violations)} accessibility violations")

        # Log detailed violation information
        for violation in violations:
            violation_id = violation.get('id', 'unknown')
            impact = violation.get('impact', 'unknown')
            description = violation.get('description', 'No description')
            help_url = violation.get('helpUrl', '')
            nodes_count = len(violation.get('nodes', []))

            logger.warn(
                f"Violation: {violation_id} | "
                f"Impact: {impact} | "
                f"Affected elements: {nodes_count} | "
                f"Description: {description} | "
                f"Help: {help_url}"
            )

        return violations

    @keyword("Get Axe Results")
    def get_axe_results(self):
        """
        Run axe analysis and return full results object.

        Returns:
            Complete axe-core results object including violations, passes,
            incomplete, and inapplicable.

        Example:
            | ${results}= | Get Axe Results |
        """
        driver = self._get_driver()
        axe = Axe(driver)
        axe.inject()
        results = axe.run()

        logger.info(f"Violations: {len(results.get('violations', []))}")
        logger.info(f"Passes: {len(results.get('passes', []))}")
        logger.info(f"Incomplete: {len(results.get('incomplete', []))}")
        logger.info(f"Inapplicable: {len(results.get('inapplicable', []))}")

        return results
