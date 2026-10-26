"""Portable publication regressions; synthetic XML only, no local audit inputs."""
import unittest
import xml.etree.ElementTree as ET

from sanitize_xml import sanitize_xml


def aliases(value):
    return value.replace("/synthetic/private", "<USER_HOME>").replace("/synthetic/audit", "<AUDIT_ROOT>")


class XmlPublicationTests(unittest.TestCase):
    def test_text_tail_and_attributes_are_values_not_markup(self):
        source = ('<testsuites><testsuite tests="2" failures="1" errors="0" skipped="1">'
                  '<testcase name="failed_case" classname="suite.module" time="0.5">'
                  '<failure message="/synthetic/private/runner &amp; detail">'
                  '/synthetic/audit/log &lt;trace&gt;</failure>/synthetic/private/tail'
                  '</testcase><testcase name="skipped_case" classname="suite.module">'
                  '<skipped message="retained"/></testcase></testsuite></testsuites>')
        result = sanitize_xml(source, aliases)
        root = ET.fromstring(result)
        failure = root.find(".//failure")
        self.assertEqual(failure.text, "<AUDIT_ROOT>/log <trace>")
        self.assertEqual(failure.tail, "<USER_HOME>/tail")
        self.assertEqual(failure.attrib["message"], "<USER_HOME>/runner & detail")
        self.assertNotIn("<AUDIT_ROOT>", result)
        self.assertNotIn("<USER_HOME>", result)
        self.assertIn("&lt;AUDIT_ROOT&gt;", result)
        self.assertIn("&lt;USER_HOME&gt;", result)
        self.assertEqual(root.find("testsuite").attrib,
                         {"tests": "2", "failures": "1", "errors": "0", "skipped": "1"})
        self.assertEqual([case.attrib for case in root.findall(".//testcase")],
                         [case.attrib for case in ET.fromstring(source).findall(".//testcase")])
        self.assertEqual(len(root.findall(".//failure")), 1)
        self.assertEqual(len(root.findall(".//skipped")), 1)

    def test_previous_raw_replacement_is_rejected_by_parser(self):
        source = '<testcase><failure>/synthetic/audit/log</failure></testcase>'
        with self.assertRaises(ET.ParseError):
            ET.fromstring(aliases(source))
        self.assertEqual(ET.fromstring(sanitize_xml(source, aliases)).find("failure").text,
                         "<AUDIT_ROOT>/log")

    def test_preexisting_entities_and_repeat_are_preserved(self):
        source = '<testcase name="a &amp; b"><system-out>&lt;USER_HOME&gt; &amp; &quot;quoted&quot;</system-out></testcase>'
        once = sanitize_xml(source, aliases)
        self.assertEqual(sanitize_xml(once, aliases), once)
        self.assertEqual(ET.fromstring(once).find("system-out").text, '<USER_HOME> & "quoted"')

    def test_invalid_original_fails_before_sanitizing(self):
        calls = []
        with self.assertRaises(ET.ParseError):
            sanitize_xml("<testcase><failure></testcase>", lambda value: calls.append(value) or value)
        self.assertEqual(calls, [])

    def test_carriage_return_entities_keep_exact_log_text(self):
        source = '<testcase><failure>before&#13;\nafter /synthetic/private/file&#13;end </failure></testcase>'
        result = sanitize_xml(source, aliases)
        self.assertNotIn("\r", result)
        self.assertEqual(ET.fromstring(result).find("failure").text,
                         "before\r\nafter <USER_HOME>/file\rend ")


if __name__ == "__main__":
    unittest.main()
