; ----------------------------------------------------------------------------
; Literals and comments

 (integer) @constant.numeric.integer
 (exp_negation) @constant.numeric.integer
 (exp_literal (number)) @constant.numeric.float
 (char) @constant.character

 [
   (string)
   (triple_quote_string)
 ] @string

 (comment) @comment

; ----------------------------------------------------------------------------
; Punctuation

 [
   "("
   ")"
   "{"
   "}"
   "["
   "]"
 ] @punctuation.bracket

 (comma) @punctuation.delimiter

; ----------------------------------------------------------------------------
; Types

 (type) @type

 (constructor) @constructor

; ----------------------------------------------------------------------------
; Keywords, operators, includes

 (module) @namespace

 [
   "if"
   "then"
   "else"
   "case"
   "of"
 ] @keyword.control.conditional

 [
   "import"
   "module"
 ] @keyword.control.import

 [
   (operator)
   (type_operator)
   (qualified_module)  ; grabs the `.` (dot), ex: import System.IO
   (all_names)

   ; `_` wildcards in if-then-else and case-of expressions,
   ; as well as record updates and operator sections
   (wildcard)
   "="
   "|"
   "::"
   "∷"
   "=>"
   "⇒"
   "<="
   "⇐"
   "->"
   "→"
   "<-"
   "←"
   "\\"
   "`"
   "@"
 ] @operator

 (qualified_module (module) @constructor)
 (qualified_type (module) @namespace)
 (qualified_variable (module) @namespace)
 (import (module) @namespace)

 [
   (where)
   "let"
   "in"
   "class"
   "instance"
   "derive"
   "foreign"
   "data"
   "newtype"
   "type"
   "as"
   "hiding"
   "do"
   "ado"
   "forall"
   "∀"
   "infix"
   "infixl"
   "infixr"
 ] @keyword

 ; NOTE
 ; Needs to come after the other `else` in
 ; order to be highlighted correctly
 (class_instance "else" @keyword)

 (type_role_declaration
   "role" @keyword
   role: (type_role) @keyword)

 (hole) @label

; ----------------------------------------------------------------------------
; Functions and variables

 (variable) @variable

 (row_field (field_name) @variable.other.member)
 (record_field (field_name) @variable.other.member)
 (record_field (field_pun) @variable.other.member)

 ; NOTE
 ; Record fields must come after literal strings and
 ; plain variables in order to be highlighted correctly
 (record_accessor
    field: [ (variable)
             (string)
             (triple_quote_string)
           ] @variable.other.member)

 (exp_record_access
    field: [ (variable)
             (string)
             (triple_quote_string)
           ] @variable.other.member)

 (signature name: (variable) @type)
 (function name: (variable) @function)
 (class_instance (instance_name) @function)
 (derive_declaration (instance_name) @function)

 ; true or false
 ((variable) @constant.builtin.boolean
  (#match? @constant.builtin.boolean "^(true|false)$"))

 ; The former one works for `tree-sitter highlight` but not in Helix/Kakoune.
 ; The latter two work in Helix (but not Kakoune) and are a good compromise between not highlighting anything at all
 ; as an operator and leaving it to the child nodes, and highlighting everything as an operator.
 (exp_ticked (_) @operator)
 (exp_ticked (exp_name (variable) @operator))
 (exp_ticked (exp_name (qualified_variable (variable) @operator)))

 (patterns (pat_as "@" @namespace))

