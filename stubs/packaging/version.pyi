from typing import Any


class Version:
    major: int
    minor: int
    patch: int

    def __init__(self: Version, version_string: str, partial: bool = False):
        ...

    def __eq__(self, other: object) -> bool:
        ...

    def __ne__(self, other: object) -> bool:
        ...

    def __lt__(self, other: "Version") -> bool:
        ...

    def __le__(self, other: "Version") -> bool:
        ...

    def __gt__(self, other: "Version") -> bool:
        ...

    def __ge__(self, other: "Version") -> bool:
        ...

    def __hash__(self) -> int:
        ...

    def __cmp__(self, other: Any) -> bool:
        ...

    def __str__(self) -> str:
        ...

    def __repr__(self) -> str:
        ...

    @classmethod
    def parse(cls, version: str) -> Version:
        ...


class InvalidVersion(ValueError):
    ...
