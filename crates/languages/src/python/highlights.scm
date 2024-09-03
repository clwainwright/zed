(parameter (identifier) @variable)
(attribute attribute: (identifier) @property)
(type (identifier) @type)

; Identifier naming conventions

((identifier) @type.class
 (#match? @type.class "^[A-Z]"))

((identifier) @constant
 (#match? @constant "^_*[A-Z][A-Z\\d_]*$"))

; Module imports

(import_statement
  (dotted_name (identifier) @type.import))

(import_statement
  (aliased_import
    name: (dotted_name (identifier) @type.import)
    alias: (identifier) @type.import))

(import_from_statement
  (dotted_name (identifier) @type.import))

(import_from_statement
  (aliased_import
    name: (dotted_name (identifier) @type.import)
    alias: (identifier) @type.import))

; Function calls

(decorator
  "@" @punctuation.special
  (identifier) @function.decorator)

(call
  function: (attribute attribute: (identifier) @function.method.call))
(call
  function: (identifier) @function.call)

; Function and class definitions

(function_definition
  name: (identifier) @function.definition)

; Class definitions and calling: needs to come after the regex matching above

(class_definition
  name: (identifier) @type.class.definition)

(call
  function: (identifier) @type.class.call
  (#match? @type.class.call "^[A-Z][A-Z0-9_]*[a-z]"))

; Builtin functions

((call
  function: (identifier) @function.builtin)
 (#match?
   @function.builtin
   "^(abs|all|any|ascii|bin|bool|breakpoint|bytearray|bytes|callable|chr|classmethod|compile|complex|delattr|dict|dir|divmod|enumerate|eval|exec|filter|float|format|frozenset|getattr|globals|hasattr|hash|help|hex|id|input|int|isinstance|issubclass|iter|len|list|locals|map|max|memoryview|min|next|object|oct|open|ord|pow|print|property|range|repr|reversed|round|set|setattr|slice|sorted|staticmethod|str|sum|super|tuple|type|vars|zip|__import__)$"))

; Literals

[
  (none)
  (true)
  (false)
  (ellipsis)
] @constant.builtin

[
  (integer)
  (float)
] @number

; Self references

[
  (parameters (identifier) @variable.special)
  (attribute (identifier) @variable.special)
  (#match? @variable.special "^self|cls$")
]

(comment) @comment
(string) @string
(escape_sequence) @escape

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
] @punctuation.bracket

(interpolation
  "{" @punctuation.special
  "}" @punctuation.special) @embedded

; Docstrings.
(function_definition
  "async"?
  "def"
  name: (_)
  (parameters)?
  body: (block . (expression_statement (string) @string.doc)))

(class_definition
  body: (block
    . (comment) @comment*
    . (expression_statement (string) @string.doc)))

(module
  . (comment) @comment*
  . (expression_statement (string) @string.doc))

[
  "-"
  "-="
  "!="
  "*"
  "**"
  "**="
  "*="
  "/"
  "//"
  "//="
  "/="
  "&"
  "%"
  "%="
  "^"
  "+"
  "->"
  "+="
  "<"
  "<<"
  "<="
  "<>"
  "="
  ":="
  "=="
  ">"
  ">="
  ">>"
  "|"
  "~"
  "and"
  "in"
  "is"
  "not"
  "or"
  "is not"
  "not in"
] @operator

[
  "as"
  "assert"
  "async"
  "await"
  "break"
  "class"
  "continue"
  "def"
  "del"
  "elif"
  "else"
  "except"
  "exec"
  "finally"
  "for"
  "from"
  "global"
  "if"
  "import"
  "lambda"
  "nonlocal"
  "pass"
  "print"
  "raise"
  "return"
  "try"
  "while"
  "with"
  "yield"
  "match"
  "case"
] @keyword
