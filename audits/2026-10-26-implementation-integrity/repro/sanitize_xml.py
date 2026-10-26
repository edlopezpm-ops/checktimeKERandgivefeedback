"""Deidentify XML values while retaining a well-formed derived document."""
from collections.abc import Callable
import xml.etree.ElementTree as ET


def sanitize_xml(source: str, clean: Callable[[str], str]) -> str:
    """Apply the publication sanitizer only to text, tails and attribute values."""
    root = ET.fromstring(source)
    for element in root.iter():
        if element.text is not None:
            element.text = clean(element.text)
        if element.tail is not None:
            element.tail = clean(element.tail)
        for name, value in element.attrib.items():
            element.set(name, clean(value))
    # Literal carriage returns are normalized by XML parsers. Preserve decoded
    # log characters as character references, including CRs from JUnit entities.
    result = ET.tostring(root, encoding="unicode").replace("\r", "&#13;")
    ET.fromstring(result)
    return result
