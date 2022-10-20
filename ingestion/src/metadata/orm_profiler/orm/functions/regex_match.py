"""
Define match regular expression fucntion
Given a value(usually a stirng) and a regex
Return true if the value contains part that matches the regex
"""

from sqlalchemy.ext.compiler import compiles
from sqlalchemy.sql.functions import ClauseElement

from metadata.orm_profiler.metrics.core import CACHE
from metadata.orm_profiler.orm.registry import Dialects
from metadata.utils.logger import profiler_logger

logger = profiler_logger()

class MatchRegexFn(FunctionElement):
    inherit_cache = CACHE
    def __init__(self, value, regex):
        self.value = value
        self.regex = regex
        
        
"""
matching [regex] colum [namew]
"""
@compiles(MatchRegexFn, Dialects.BigQuery)
def _(element, compiler, **kw):
    return "REGEXP_CONTAINS(%s, r'%s')" %(
        compiler.process(element.value, **kw),
        compiler.process(element.regex, **kw)
        )
    