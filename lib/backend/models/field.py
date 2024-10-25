from dataclasses import dataclass, field
from typing import List

@dataclass
class Field:
    n: int = 0
    p: int = 0
    k: int = 0
    temp: float = 0.0
    hum: float = 0.0
    rain: float = 0.0
    ph : float = 0.0
    crops: List[str] = field(default_factory=list)
    history: List[str] = field(default_factory=list)
