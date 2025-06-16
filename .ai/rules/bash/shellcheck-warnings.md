---
description:
globs: *.sh,*.bash
alwaysApply: false
---

# ShellCheck Comprehensive Warning Reference

Complete coverage of all ShellCheck warnings with concise explanations and
examples.

---

## SC1000 Series - Parsing/Syntax Errors

### SC1000

**What it does**: Flags unescaped `$` in contexts where it's not special **Why
is this bad?**: May be interpreted as variable expansion unexpectedly
**Example**: `echo "Cost is $5"` → `echo "Cost is \$5"`

### SC1001

**What it does**: Flags literal backslash sequences that don't create escape
sequences **Why is this bad?**: Confusing and may not behave as expected
**Example**: `echo "\\o"` → `echo "\\\\o"` or `echo '\o'`

### SC1003

**What it does**: Flags incorrect single quote escaping **Why is this bad?**:
Single quotes can't be escaped inside single quotes **Example**: `echo 'can't'`
→ `echo 'can'\''t'`

### SC1004

**What it does**: Flags literal backslash+newline in single quotes **Why is this
bad?**: Line continuation doesn't work inside single quotes **Example**:
`echo 'line1\\\nline2'` → `echo 'line1' \\` + newline + `'line2'`

### SC1007

**What it does**: Flags space after `=` in assignments **Why is this bad?**:
Creates command instead of assignment **Example**: `var= value` → `var=value` or
`var=""`

### SC1008

**What it does**: Flags unrecognized shebangs **Why is this bad?**: Script may
not run with intended interpreter **Example**: `#!/usr/bin/python` →
`#!/bin/bash` or add `# shellcheck shell=bash`

### SC1009

**What it does**: Points to location of parser errors **Why is this bad?**:
Syntax errors prevent script execution **Example**: Fix the specific syntax
error indicated

### SC1010

**What it does**: Flags missing semicolon/newline before `done` **Why is this
bad?**: Syntax error in loop structure **Example**:
`while true; do echo "hi" done` → `while true; do echo "hi"; done`

### SC1011

**What it does**: Flags unterminated single quoted strings **Why is this bad?**:
Syntax error, script won't parse **Example**: `echo 'hello` → `echo 'hello'`

### SC1012

**What it does**: Flags literal `\t` instead of tab character **Why is this
bad?**: Won't produce actual tab character **Example**: `echo "\\t"` →
`echo "$(printf '\t')"`

### SC1014

**What it does**: Flags incorrect command/output checking **Why is this bad?**:
Confuses exit code checking with output comparison **Example**:
`if grep pattern file` → `if grep -q pattern file`

### SC1015

**What it does**: Flags Unicode double quotes **Why is this bad?**: Not
recognized as shell quotes **Example**: `echo "hello"` → `echo "hello"`

### SC1016

**What it does**: Flags Unicode single quotes **Why is this bad?**: Not
recognized as shell quotes **Example**: `echo 'hello'` → `echo 'hello'`

### SC1017

**What it does**: Flags literal carriage returns **Why is this bad?**: Causes
parsing issues on Unix systems **Example**: Run `tr -d '\r' < file > fixed_file`

### SC1018

**What it does**: Flags Unicode non-breaking spaces **Why is this bad?**: Not
recognized as regular spaces **Example**: Replace with regular ASCII space
character

### SC1019

**What it does**: Flags missing argument to unary operators **Why is this
bad?**: Syntax error in test conditions **Example**: `[[ -z ]]` →
`[[ -z "$var" ]]`

### SC1020

**What it does**: Flags missing space before `]` or `]]` **Why is this bad?**:
Syntax error in test expressions **Example**: `[[ condition]]` →
`[[ condition ]]`

### SC1026

**What it does**: Flags incorrect grouping in `[[...]]` **Why is this bad?**:
Syntax error, wrong grouping operator **Example**: `[[ \\( expr \\) ]]` →
`[[ ( expr ) ]]`

### SC1027

**What it does**: Flags missing second argument to binary operators **Why is
this bad?**: Syntax error in test expressions **Example**: `[[ "$var" = ]]` →
`[[ "$var" = "value" ]]`

### SC1028

**What it does**: Flags unescaped parentheses in `[...]` **Why is this bad?**:
Syntax error, wrong test syntax **Example**: `[ ( expr ) ]` → `[ \\( expr \\) ]`
or `[[ ( expr ) ]]`

### SC1029

**What it does**: Flags escaped parentheses in `[[...]]` **Why is this bad?**:
Unnecessary escaping in `[[...]]` **Example**: `[[ \\( expr \\) ]]` →
`[[ ( expr ) ]]`

### SC1033

**What it does**: Flags mismatched `[[` and `]` **Why is this bad?**: Syntax
error, brackets don't match **Example**: `[[ condition ]` → `[[ condition ]]`

### SC1034

**What it does**: Flags mismatched `[` and `]]` **Why is this bad?**: Syntax
error, brackets don't match **Example**: `[ condition ]]` → `[ condition ]`

### SC1035

**What it does**: Flags missing required spaces **Why is this bad?**: Syntax
error, tokens need separation **Example**: Add space where indicated

### SC1036

**What it does**: Flags invalid parentheses usage **Why is this bad?**: Syntax
error in context **Example**: Escape parentheses or fix syntax

### SC1037

**What it does**: Flags positional parameters >9 without braces **Why is this
bad?**: `$10` is interpreted as `$1` + `0` **Example**: `$10` → `${10}`

### SC1038

**What it does**: Flags incorrect process substitution spacing **Why is this
bad?**: Creates here-document instead of process substitution **Example**:
`cmd <<(other)` → `cmd < <(other)`

### SC1039

**What it does**: Flags improper here-document indentation **Why is this bad?**:
Syntax error with indented here-docs **Example**: Use `<<-` and indent with tabs
only

### SC1040

**What it does**: Flags space indentation with `<<-` **Why is this bad?**: `<<-`
only strips tab indentation **Example**: Use tabs instead of spaces for
indentation

### SC1041

**What it does**: Flags here-document end token not on separate line **Why is
this bad?**: End token must be alone on line **Example**: Put end token on its
own line

### SC1043

**What it does**: Flags here-document end token with wrong case **Why is this
bad?**: Case must match exactly **Example**: `cat <<EOF` ... `eof` → `cat <<EOF`
... `EOF`

### SC1044

**What it does**: Flags missing here-document end token **Why is this bad?**:
Syntax error, unterminated here-document **Example**: Add matching end token

### SC1045

**What it does**: Flags incorrect background process syntax **Why is this
bad?**: Wrong syntax for background commands **Example**: `foo &; bar` →
`foo & bar`

### SC1046

**What it does**: Flags missing `fi` for `if` statement **Why is this bad?**:
Syntax error, unterminated conditional **Example**: Add missing `fi`

### SC1047

**What it does**: Flags mismatched `if`/`fi` **Why is this bad?**: Syntax error,
structure mismatch **Example**: Ensure each `if` has matching `fi`

### SC1048

**What it does**: Flags empty `then` clauses **Why is this bad?**: Syntax error,
`then` needs content **Example**: `if cond; then; fi` → `if cond; then true; fi`

### SC1049

**What it does**: Flags missing `then` for `if` statement **Why is this bad?**:
Syntax error, `if` requires `then` **Example**: `if condition; echo "hi"; fi` →
`if condition; then echo "hi"; fi`

### SC1050

**What it does**: Flags missing `then` keyword **Why is this bad?**: Syntax
error, expected `then` **Example**: Add missing `then` keyword

### SC1051

**What it does**: Flags semicolon directly after `then` **Why is this bad?**:
Invalid syntax **Example**: `if cond; then; echo "hi"` →
`if cond; then echo "hi"`

### SC1052

**What it does**: Flags semicolon directly after `then` **Why is this bad?**:
Invalid syntax, redundant semicolon **Example**: Remove semicolon after `then`

### SC1053

**What it does**: Flags semicolon directly after `else` **Why is this bad?**:
Invalid syntax **Example**: `if cond; then echo "hi"; else; echo "bye"` →
`if cond; then echo "hi"; else echo "bye"`

### SC1054

**What it does**: Flags missing space after `{` **Why is this bad?**: Syntax
error in function/command group **Example**: `{echo "hi"}` → `{ echo "hi"; }`

### SC1055

**What it does**: Flags empty command groups **Why is this bad?**: Syntax error,
need at least one command **Example**: `{ }` → `{ true; }`

### SC1056

**What it does**: Flags missing `}` or missing separator before `}` **Why is
this bad?**: Syntax error in command group **Example**: `{ echo "hi" }` →
`{ echo "hi"; }`

### SC1057

**What it does**: Flags missing `do` for loop **Why is this bad?**: Syntax
error, loop requires `do` **Example**: `for i in *; echo $i; done` →
`for i in *; do echo $i; done`

### SC1058

**What it does**: Flags missing `do` keyword **Why is this bad?**: Syntax error,
expected `do` **Example**: Add missing `do` keyword

### SC1059

**What it does**: Flags semicolon directly after `do` **Why is this bad?**:
Invalid syntax **Example**: `while true; do; echo "hi"; done` →
`while true; do echo "hi"; done`

### SC1060

**What it does**: Flags empty `do` clauses **Why is this bad?**: Syntax error,
`do` needs content **Example**: `while true; do; done` →
`while true; do true; done`

### SC1061

**What it does**: Flags missing `done` for loop **Why is this bad?**: Syntax
error, unterminated loop **Example**: Add missing `done`

### SC1062

**What it does**: Flags mismatched `do`/`done` **Why is this bad?**: Syntax
error, structure mismatch **Example**: Ensure each `do` has matching `done`

### SC1063

**What it does**: Flags missing line feed or semicolon before `do` **Why is this
bad?**: Syntax error, missing separator **Example**: `for i in * do` →
`for i in *; do`

### SC1064

**What it does**: Flags missing `{` in function definition **Why is this bad?**:
Syntax error in function syntax **Example**: `func() echo "hi"` →
`func() { echo "hi"; }`

### SC1065

**What it does**: Flags parameter declaration in function definition **Why is
this bad?**: Functions don't declare parameters, use `$1`, `$2`, etc.
**Example**: `func(param) { }` → `func() { local param=$1; }`

### SC1066

**What it does**: Flags `$` on left side of assignments **Why is this bad?**:
Assignment syntax doesn't use `$` **Example**: `$var=value` → `var=value`

### SC1067

**What it does**: Flags variable indirection attempts **Why is this bad?**: Use
proper indirection methods **Example**: `${$var}` → `${!var}` or use arrays

### SC1068

**What it does**: Flags spaces around `=` in assignments **Why is this bad?**:
Creates command with arguments instead of assignment **Example**: `var = value`
→ `var=value`

### SC1069

**What it does**: Flags missing space before `[` **Why is this bad?**: Syntax
error, `[` is a command **Example**: `if[condition]` → `if [ condition ]`

### SC1070

**What it does**: Flags parsing errors with mismatched keywords/parentheses
**Why is this bad?**: Syntax error prevents script execution **Example**: Fix
mismatched brackets or keywords

### SC1071

**What it does**: Flags unsupported shell types **Why is this bad?**: ShellCheck
only supports sh/bash/dash/ksh **Example**: Use supported shell or add
appropriate directive

### SC1072

**What it does**: Flags unexpected tokens **Why is this bad?**: Syntax error,
unexpected character/token **Example**: Fix the unexpected token

### SC1073

**What it does**: Flags unparseable constructs **Why is this bad?**: Prevents
further analysis **Example**: Fix syntax to allow more checks

### SC1074

**What it does**: Flags missing `;;` after case item **Why is this bad?**:
Syntax error in case statement **Example**: `case $var in pattern) cmd esac` →
`case $var in pattern) cmd ;; esac`

### SC1075

**What it does**: Flags `else if` instead of `elif` **Why is this bad?**: Wrong
syntax for shell conditionals **Example**: `if cond; then cmd; else if cond2` →
`if cond; then cmd; elif cond2`

### SC1076

**What it does**: Flags arithmetic outside proper context **Why is this bad?**:
Use proper arithmetic syntax **Example**: `if i/2+7 -ge 18` →
`if [ $((i/2+7)) -ge 18 ]`

### SC1077

**What it does**: Flags wrong direction backtick **Why is this bad?**: Command
substitution uses `` ` ``, not `´` **Example**: Replace `´` with `` ` ``

### SC1078

**What it does**: Flags unterminated double-quoted string **Why is this bad?**:
Syntax error, missing closing quote **Example**: Add missing closing quote

### SC1079

**What it does**: Flags suspicious quote usage **Why is this bad?**: Quote
appears to be end quote but syntax suggests otherwise **Example**: Check quote
pairing

### SC1080

**What it does**: Flags missing `\` before line feeds in `[ ]` **Why is this
bad?**: Line continuation needed in test expressions **Example**: Add `\` before
newline

### SC1081

**What it does**: Flags incorrect case in keywords **Why is this bad?**: Shell
keywords are case-sensitive **Example**: `If condition` → `if condition`

### SC1082

**What it does**: Flags UTF-8 BOM in script **Why is this bad?**: BOM causes
parsing issues **Example**: Remove BOM with
`LC_CTYPE=C sed '1s/^...//' < script`

### SC1083

**What it does**: Flags literal `{`/`}` that might need escaping **Why is this
bad?**: May be interpreted as brace expansion **Example**: Escape braces or add
missing semicolon

### SC1084

**What it does**: Flags incorrect shebang order **Why is this bad?**: Shebang
must start with `#!` **Example**: `!#/bin/bash` → `#!/bin/bash`

### SC1086

**What it does**: Flags `$` on iterator name in for loops **Why is this bad?**:
Iterator name shouldn't have `$` **Example**: `for $i in list` → `for i in list`

### SC1087

**What it does**: Flags missing braces in array expansion **Why is this bad?**:
Ambiguous syntax without braces **Example**: `$array[0]` → `${array[0]}`

### SC1088

**What it does**: Flags invalid parentheses usage **Why is this bad?**: Syntax
error, parsing stopped **Example**: Fix parentheses or escape them

### SC1089

**What it does**: Flags unmatched keywords **Why is this bad?**: Syntax error,
control structure mismatch **Example**: Ensure keywords properly matched

### SC1090

**What it does**: Flags non-constant source paths **Why is this bad?**:
ShellCheck can't follow dynamic paths **Example**: Add
`# shellcheck source=path` directive

### SC1091

**What it does**: Flags unfollowed source files **Why is this bad?**: ShellCheck
can't analyze sourced content **Example**: Ensure file exists or add source
directive

### SC1092

**What it does**: Flags excessive source nesting (>100 levels) **Why is this
bad?**: Likely infinite recursion **Example**: Check for circular sourcing

### SC1094

**What it does**: Flags unparseable sourced files **Why is this bad?**: Syntax
errors in sourced file **Example**: Fix syntax in sourced file

### SC1095

**What it does**: Flags missing space in function definition **Why is this
bad?**: Syntax error in function syntax **Example**: `func(){ code; }` →
`func() { code; }`

### SC1097

**What it does**: Flags `==` in assignment context **Why is this bad?**: Wrong
operator for assignment vs comparison **Example**: `var == value` → `var=value`
or `[[ $var == value ]]`

### SC1098

**What it does**: Flags unquoted special chars in `eval` **Why is this bad?**:
May cause parsing errors **Example**: `eval $cmd` → `eval "$cmd"`

### SC1099

**What it does**: Flags missing space before `#` **Why is this bad?**: Comment
not recognized **Example**: `cmd#comment` → `cmd # comment`

### SC1100

**What it does**: Flags Unicode dash characters **Why is this bad?**: Not
recognized as ASCII minus **Example**: Replace with ASCII `-`

### SC1101

**What it does**: Flags trailing spaces after line continuation **Why is this
bad?**: Breaks line continuation **Example**: Remove trailing spaces after `\\`

### SC1102

**What it does**: Flags ambiguous `$((` usage **Why is this bad?**: Could be
command substitution or arithmetic **Example**: `$(( command))` →
`$( (command) )` or `$((arithmetic))`

### SC1103

**What it does**: Flags unknown shell type **Why is this bad?**: ShellCheck
can't apply appropriate rules **Example**: Use recognized shell type or add
directive

### SC1104

**What it does**: Flags incomplete shebang **Why is this bad?**: Not recognized
as shebang **Example**: `!bin/bash` → `#!/bin/bash`

### SC1105

**What it does**: Flags ambiguous `((` usage **Why is this bad?**: Could be
subshell or arithmetic **Example**: `(( command))` → `( (command) )` or
`((arithmetic))`

### SC1106

**What it does**: Flags `-lt` in arithmetic context **Why is this bad?**: Use
arithmetic operators in arithmetic **Example**: `(( var -lt 5 ))` →
`(( var < 5 ))`

### SC1107

**What it does**: Flags unknown ShellCheck directive **Why is this bad?**:
Directive will be ignored **Example**: Check directive spelling

### SC1108

**What it does**: Flags missing spaces around `=` in conditions **Why is this
bad?**: Syntax error in test expressions **Example**: `[[ var=value ]]` →
`[[ var = value ]]`

### SC1109

**What it does**: Flags unquoted HTML entities **Why is this bad?**: May not be
interpreted as intended **Example**: `&amp;` → `&`

### SC1110-SC1112

**What it does**: Flags Unicode quote characters **Why is this bad?**: Not
recognized as shell quotes **Example**: Replace with ASCII quotes

### SC1113

**What it does**: Flags incomplete shebang **Why is this bad?**: Not recognized
as shebang **Example**: `#bin/bash` → `#!/bin/bash`

### SC1114

**What it does**: Flags leading spaces before shebang **Why is this bad?**:
Shebang must be first characters **Example**: Remove leading spaces

### SC1115

**What it does**: Flags spaces in shebang **Why is this bad?**: Invalid shebang
format **Example**: `# !/bin/bash` → `#!/bin/bash`

### SC1116

**What it does**: Flags missing `$` on arithmetic expansion **Why is this
bad?**: Creates array instead of arithmetic **Example**: `((expr))` →
`$((expr))` or `( (array) )`

### SC1117

**What it does**: Flags literal backslashes in double quotes **Why is this
bad?**: May not create intended escape sequence **Example**: `"\\n"` → `"\\\\n"`
or `'\n'`

### SC1118

**What it does**: Flags whitespace after here-doc token **Why is this bad?**:
Breaks here-document **Example**: Remove trailing whitespace

### SC1119

**What it does**: Flags missing newline before `)` **Why is this bad?**: Syntax
error in here-document **Example**: Add newline between token and `)`

### SC1120

**What it does**: Flags comments after here-doc token **Why is this bad?**:
Breaks here-document parsing **Example**: Move comment to next line

### SC1121

**What it does**: Flags syntax on wrong line in here-documents **Why is this
bad?**: Commands must be on line with `<<` **Example**: Move terminators to `<<`
line

### SC1122

**What it does**: Flags content after here-doc end token **Why is this bad?**:
End token must be alone **Example**: Move commands to `<<` line

### SC1123-SC1124

**What it does**: Flags ShellCheck directives in wrong position **Why is this
bad?**: Directives only work on complete commands **Example**: Move directive
before complete command

### SC1125

**What it does**: Flags invalid directive syntax **Why is this bad?**: Directive
won't be recognized **Example**: Use correct `key=value` format

### SC1126

**What it does**: Flags misplaced ShellCheck directive **Why is this bad?**:
Directives must precede commands **Example**: Move directive before command

### SC1127

**What it does**: Flags possible comment without `#` **Why is this bad?**: Text
may be treated as command **Example**: Add `#` for comments

### SC1128

**What it does**: Flags shebang not on first line **Why is this bad?**: Shebang
only works on first line **Example**: Move shebang to first line

### SC1129

**What it does**: Flags missing space before `!` **Why is this bad?**: Syntax
error in condition **Example**: `[[ !condition]]` → `[[ ! condition ]]`

### SC1130

**What it does**: Flags missing space before `:` **Why is this bad?**: Syntax
error **Example**: Add required space

### SC1131

**What it does**: Flags incorrect `else if` syntax **Why is this bad?**: Should
use `elif` **Example**: `else if` → `elif`

### SC1132

**What it does**: Flags background operator in wrong context **Why is this
bad?**: `&` terminates command unexpectedly **Example**: Escape `&` or add space

### SC1133

**What it does**: Flags operators on wrong line **Why is this bad?**: Operators
should end previous line **Example**: Move `||`/`&&` to end of previous line

### SC1135

**What it does**: Flags inefficient quote escaping **Why is this bad?**: Ending
and restarting quotes is unclear **Example**: `"cost $"5` → `"cost \\$5"`

### SC1136

**What it does**: Flags unexpected characters after `]` **Why is this bad?**:
Syntax error, missing separator **Example**: Add `;` or newline

### SC1137

**What it does**: Flags incomplete arithmetic for loop **Why is this bad?**:
Missing opening parenthesis **Example**: `for ((i=0; i<10; i++)` →
`for ((i=0; i<10; i++))`

### SC1138

**What it does**: Flags incorrect process substitution spacing **Why is this
bad?**: Creates here-document instead **Example**: `<< (cmd)` → `< <(cmd)`

### SC1139

**What it does**: Flags old test syntax with `-o` **Why is this bad?**: Use `||`
for clarity **Example**: `[ cond1 -o cond2 ]` → `[ cond1 ] || [ cond2 ]`

### SC1140

**What it does**: Flags unexpected parameters after condition **Why is this
bad?**: Syntax error, missing operator **Example**: Add missing `&&` or `||`

### SC1141

**What it does**: Flags unexpected tokens after compound command **Why is this
bad?**: Syntax error, missing separator **Example**: Add `;`, `&&`, `||`, or `|`

### SC1142

**What it does**: Flags missing `<` in process substitution **Why is this
bad?**: Incomplete redirection syntax **Example**: `done <(cmd)` →
`done < <(cmd)`

### SC1143

**What it does**: Flags backslash in comment **Why is this bad?**: Backslash
doesn't continue line in comments **Example**: Remove backslash or move outside
comment

### SC1144

**What it does**: Flags inline `external-sources` directive **Why is this
bad?**: Only allowed in `.shellcheckrc` **Example**: Move to `.shellcheckrc`
file

### SC1145

**What it does**: Flags invalid `external-sources` value **Why is this bad?**:
Must be `true` or `false` **Example**: Use `external-sources=true`

---

## SC2000 Series - Best Practices and Logic

### SC2000

**What it does**: Suggests using `${#var}` instead of `expr` **Why is this
bad?**: `expr` is slow and external dependency **Example**: `expr length "$var"`
→ `${#var}`

### SC2001

**What it does**: Suggests parameter expansion instead of `sed` **Why is this
bad?**: More efficient for simple substitutions **Example**:
`echo "$var" | sed 's/old/new/'` → `${var//old/new}`

### SC2002

**What it does**: Flags useless use of `cat` **Why is this bad?**: Inefficient,
creates unnecessary process **Example**: `cat file | grep pattern` →
`grep pattern file`

### SC2003

**What it does**: Flags antiquated `expr` usage **Why is this bad?**: Slow and
has better modern alternatives **Example**: `expr $a + $b` → `$((a + b))`

### SC2004

**What it does**: Flags unnecessary `$` in arithmetic **Why is this bad?**:
Redundant, variables don't need `$` in arithmetic **Example**: `$(($var + 1))` →
`$((var + 1))`

### SC2006

**What it does**: Flags backtick command substitution **Why is this bad?**: Hard
to read, doesn't nest, legacy syntax **Example**:
`result=\`command\``→`result="$(command)"`

### SC2007

**What it does**: Flags deprecated `$[...]` arithmetic **Why is this bad?**:
Deprecated syntax, use `$((...))` instead **Example**: `$[1 + 1]` → `$((1 + 1))`

### SC2008

**What it does**: Flags piping to `echo` **Why is this bad?**: `echo` doesn't
read stdin **Example**: `cmd | echo` → `cmd` or `cmd | cat`

### SC2009

**What it does**: Suggests `pgrep` instead of `ps | grep` **Why is this bad?**:
More efficient and handles edge cases better **Example**:
`ps aux | grep process` → `pgrep process`

### SC2010

**What it does**: Flags `ls | grep` usage **Why is this bad?**: Breaks with
special filenames **Example**: `ls | grep pattern` → `for f in *pattern*; do`

### SC2011

**What it does**: Suggests better file handling with `find` **Why is this
bad?**: Handles special filenames correctly **Example**: Use `find -print0` or
`find -exec`

### SC2012

**What it does**: Flags parsing `ls` output **Why is this bad?**: Breaks with
special filenames, unreliable **Example**: `ls -l | awk` →
`find . -type f -exec stat {} +`

### SC2013

**What it does**: Flags word-based instead of line-based reading **Why is this
bad?**: Splits on all whitespace, not just newlines **Example**:
`for line in $(cat file)` → `while IFS= read -r line; do ... done < file`

### SC2014

**What it does**: Flags variable expansion in `find -exec` **Why is this bad?**:
Expands once, not per file **Example**: `find . -exec echo $PWD {} \;` →
`find . -exec echo "$PWD" {} \;`

### SC2015

**What it does**: Flags `A && B || C` pattern **Why is this bad?**: C runs if A
is true but B fails **Example**: `[[ cond ]] && success || failure` →
`if [[ cond ]]; then success; else failure; fi`

### SC2016

**What it does**: Flags variables in single quotes **Why is this bad?**:
Variables don't expand in single quotes **Example**: `echo 'Hello $USER'` →
`echo "Hello $USER"`

### SC2017

**What it does**: Suggests arithmetic reordering for precision **Why is this
bad?**: Integer division truncates early **Example**: `$((a / b * c))` →
`$((a * c / b))`

### SC2018-SC2019

**What it does**: Suggests POSIX character classes **Why is this bad?**: `a-z`
may not match accented characters **Example**: `tr 'a-z' 'A-Z'` →
`tr '[:lower:]' '[:upper:]'`

### SC2020

**What it does**: Flags `tr` character class confusion **Why is this bad?**:
`tr` replaces characters, not words **Example**: `tr 'word1' 'word2'` replaces
w→w, o→o, r→r, d→d, 1→2

### SC2021

**What it does**: Flags brackets in `tr` ranges **Why is this bad?**: Brackets
are literal in `tr` **Example**: `tr '[a-z]' '[A-Z]'` → `tr 'a-z' 'A-Z'`

### SC2022

**What it does**: Flags regex misunderstanding in `tr` **Why is this bad?**:
`tr` uses character sets, not regex **Example**: `tr 'o*' 'x'` replaces o→x, *→x
(not regex)

### SC2023

**What it does**: Flags potential `time` command override **Why is this bad?**:
Shell builtin may differ from `/usr/bin/time` **Example**: `time command` →
`command time command` or `/usr/bin/time`

### SC2024

**What it does**: Flags incorrect `sudo` with redirection **Why is this bad?**:
`sudo` doesn't affect shell redirections **Example**: `sudo echo data > file` →
`echo data | sudo tee file`

### SC2025

**What it does**: Flags improper escape sequences in prompts **Why is this
bad?**: May cause line wrapping issues **Example**: Enclose sequences in
`\\[...\\]`

### SC2026

**What it does**: Flags word outside quotes **Why is this bad?**: May be
interpreted incorrectly **Example**: Use proper quoting for nested quotes

### SC2034

**What it does**: Flags variables that appear unused **Why is this bad?**: May
indicate typos or dead code **Example**: Use the variable or prefix with `_` if
intentionally unused

### SC2035

**What it does**: Flags use of globs that could match unexpected files **Why is
this bad?**: Dangerous with filenames starting with dashes **Example**: `rm *` →
`rm ./*`

### SC2038

**What it does**: Flags find with unquoted substitution **Why is this bad?**:
Breaks with filenames containing whitespace **Example**: `find . -exec rm {} \;`
→ `find . -exec rm {} +`

### SC2039

**What it does**: Flags features not available in POSIX sh **Why is this bad?**:
May not work in all environments **Example**: Use POSIX-compatible alternatives
or specify bash

### SC2046

**What it does**: Flags unquoted command substitution **Why is this bad?**: Word
splitting and pathname expansion **Example**: `rm $(find .)` → `find . -delete`

### SC2053

**What it does**: Flags quoted right-hand side of comparison **Why is this
bad?**: Disables pattern matching **Example**: `[[ $var = "pat*" ]]` →
`[[ $var = pat* ]]`

### SC2059

**What it does**: Flags variables in printf format strings **Why is this bad?**:
Format string injection vulnerability **Example**: `printf $format args` →
`printf '%s' "$format"`

### SC2064

**What it does**: Flags improper trap command quoting **Why is this bad?**:
Variables expand at trap time, not when executed **Example**:
`trap "rm $temp" EXIT` → `trap 'rm "$temp"' EXIT`

### SC2068

**What it does**: Flags unquoted array expansion **Why is this bad?**: Array
elements containing spaces will split **Example**: `cmd ${array[@]}` →
`cmd "${array[@]}"`

### SC2086

**What it does**: Flags unquoted variables **Why is this bad?**: Word splitting
and pathname expansion **Example**: `cp $file $dest` → `cp "$file" "$dest"`

### SC2155

**What it does**: Flags declare and assign on same line **Why is this bad?**:
Masks return value of assignment **Example**: `local var=$(cmd)` →
`local var; var=$(cmd)`

### SC2162

**What it does**: Flags read without -r **Why is this bad?**: Backslashes will
be interpreted **Example**: `read line` → `read -r line`

### SC2164

**What it does**: Flags cd without error checking **Why is this bad?**: Script
continues in wrong directory if cd fails **Example**: `cd dir` →
`cd dir || exit`

### SC2027

**What it does**: Flags quotes that unquote themselves **Why is this bad?**:
Surrounding quotes disable inner quotes **Example**: Fix quote nesting or escape
inner quotes

### SC2028

**What it does**: Flags `echo` with escape sequences **Why is this bad?**:
`echo` behavior varies, use `printf` **Example**: `echo "line1\nline2"` →
`printf "line1\nline2\n"`

### SC2029

**What it does**: Flags client-side expansion in ssh commands **Why is this
bad?**: Variables expand before ssh, not on remote **Example**:
`ssh host "echo $HOME"` → `ssh host 'echo $HOME'`

### SC2030-SC2031

**What it does**: Flags variable modifications in subshells/pipelines **Why is
this bad?**: Changes are lost when subshell exits **Example**:
`echo data | read var` → `read var < <(echo data)`

### SC2032-SC2033

**What it does**: Flags functions passed to external commands **Why is this
bad?**: External commands can't see shell functions **Example**: Use script file
or `sh -c 'function_definition; function_call'`

### SC2036-SC2037

**What it does**: Flags incorrect command output assignment **Why is this
bad?**: Wrong syntax for capturing command output **Example**: `var=cmd` →
`var=$(cmd)`

### SC2040

**What it does**: Flags non-POSIX features in `#!/bin/sh` **Why is this bad?**:
May not work in all sh implementations **Example**: Use bash shebang or POSIX
alternatives

### SC2041

**What it does**: Flags literal strings as commands **Why is this bad?**: String
won't be executed as command **Example**: `'echo hello'` → `echo hello` or
`$(echo hello)`

### SC2042

**What it does**: Flags commas in for loop elements **Why is this bad?**: Use
spaces to separate elements **Example**: `for i in a,b,c` → `for i in a b c`

### SC2043

**What it does**: Flags for loop with single constant value **Why is this
bad?**: Loop will only run once **Example**: `for i in "constant"` → probably
intended `for i in $var` or glob

### SC2044

**What it does**: Flags for loops over find output **Why is this bad?**: Breaks
with filenames containing whitespace **Example**: `for f in $(find .)` →
`find . -exec cmd {} \;` or `while read -r`

### SC2045

**What it does**: Flags for loops over ls output **Why is this bad?**:
Unreliable with special filenames **Example**: `for f in $(ls)` → `for f in *`

### SC2047

**What it does**: Flags missing quotes in array assignment **Why is this bad?**:
Word splitting affects assignment **Example**: `array=($var)` → `array=("$var")`

### SC2048

**What it does**: Flags unquoted `$@` **Why is this bad?**: Loses argument
boundaries **Example**: `cmd $@` → `cmd "$@"`

### SC2049

**What it does**: Flags regex syntax in glob context **Why is this bad?**: `=~`
is for regex, `=` for globs **Example**: `[[ $var =~ *.txt ]]` →
`[[ $var = *.txt ]]`

### SC2050

**What it does**: Flags constant expressions **Why is this bad?**: Missing
variable expansion **Example**: `[[ foo = bar ]]` → `[[ $foo = bar ]]`

### SC2051

**What it does**: Flags variables in brace expansions **Why is this bad?**: Bash
doesn't support variable brace ranges **Example**: `{1..$n}` → `seq 1 $n` or
array

### SC2052

**What it does**: Flags unquoted array elements **Why is this bad?**: May cause
word splitting **Example**: `array=(a b c)` is fine, but `array=($var)` →
`array=("$var")`

### SC2054

**What it does**: Flags commas in array elements **Why is this bad?**: Use
spaces to separate array elements **Example**: `array=(a,b,c)` → `array=(a b c)`

### SC2055-SC2056

**What it does**: Flags `&&` where `||` is needed **Why is this bad?**: Logic
error in conditional **Example**: `[[ condition ]] && false` →
`[[ condition ]] || false`

### SC2057-SC2058

**What it does**: Flags unknown operators **Why is this bad?**: Invalid operator
syntax **Example**: Check operator spelling and syntax

### SC2060

**What it does**: Flags unquoted parameters to `tr` **Why is this bad?**: Glob
expansion affects `tr` **Example**: `tr a-z A-Z` → `tr 'a-z' 'A-Z'`

### SC2061

**What it does**: Flags unquoted parameters to find `-name` **Why is this
bad?**: Shell interprets patterns before find **Example**: `find . -name *.txt`
→ `find . -name '*.txt'`

### SC2062

**What it does**: Flags unquoted grep patterns **Why is this bad?**: Shell
expands patterns before grep **Example**: `grep $pattern file` →
`grep "$pattern" file`

### SC2063

**What it does**: Flags glob in regex context **Why is this bad?**: Grep uses
regex, this looks like glob **Example**: Check if pattern should be regex or
glob

### SC2065

**What it does**: Flags redirection that looks like comparison **Why is this
bad?**: `>` and `<` are redirections, not comparisons **Example**:
`[[ $a > $b ]]` → `[[ $a \> $b ]]` or use `-gt`

### SC2066

**What it does**: Flags double-quoted for loop variable **Why is this bad?**:
Won't word split, loop runs once **Example**: `for i in "$list"` →
`for i in $list` (if splitting intended)

### SC2067

**What it does**: Flags missing terminator in find `-exec` **Why is this bad?**:
`-exec` needs `;` or `+` terminator **Example**: `find . -exec rm {}` →
`find . -exec rm {} \;`

### SC2069

**What it does**: Flags incorrect redirection order **Why is this bad?**: `2>&1`
must be last for stdout+stderr **Example**: `cmd 2>&1 > file` →
`cmd > file 2>&1`

### SC2070

**What it does**: Flags `-n` with unquoted arguments **Why is this bad?**: Won't
work reliably without quotes **Example**: `[ -n $var ]` → `[ -n "$var" ]` or
`[[ -n $var ]]`

### SC2071

**What it does**: Flags `>` for numeric comparison **Why is this bad?**: `>` is
lexicographic, use `-gt` for numbers **Example**: `[ $a > $b ]` →
`[ $a -gt $b ]`

### SC2072

**What it does**: Flags decimal numbers in integer comparison **Why is this
bad?**: Shell arithmetic only supports integers **Example**: `[ 1.5 -gt 1 ]` →
use `bc` or `awk` for decimals

### SC2073

**What it does**: Flags unescaped `<` in `[ ]` **Why is this bad?**: `<` is
redirection, needs escaping for comparison **Example**: `[ $a < $b ]` →
`[ $a \< $b ]` or `[[ $a < $b ]]`

### SC2074

**What it does**: Flags `=~` in `[ ]` **Why is this bad?**: Regex matching only
works in `[[ ]]` **Example**: `[ $var =~ pattern ]` → `[[ $var =~ pattern ]]`

### SC2075

**What it does**: Flags escaping in `[[ ]]` where not needed **Why is this
bad?**: `[[ ]]` doesn't need escaping for `<`/`>` **Example**: `[[ $a \< $b ]]`
→ `[[ $a < $b ]]`

### SC2076

**What it does**: Flags quoted regex in `=~` **Why is this bad?**: Quotes make
regex literal **Example**: `[[ $var =~ "pattern" ]]` → `[[ $var =~ pattern ]]`

### SC2077

**What it does**: Flags missing spaces around operators **Why is this bad?**:
Operators need spaces for recognition **Example**: `[$a=$b]` → `[ $a = $b ]`

### SC2078

**What it does**: Flags constant expressions **Why is this bad?**: Missing
variable reference **Example**: `[[ foo = bar ]]` → `[[ $foo = bar ]]`

### SC2079

**What it does**: Flags decimals in `(( ))` **Why is this bad?**: Arithmetic
expansion only supports integers **Example**: Use `bc` or `awk` for decimal
arithmetic

### SC2080

**What it does**: Flags numbers with leading zeros **Why is this bad?**:
Interpreted as octal **Example**: `echo $((010))` → `echo $((10))` or `8` (if
octal intended)

### SC2081

**What it does**: Flags globs in `[ ]` **Why is this bad?**: `[ ]` can't match
globs, use `[[ ]]` or `case` **Example**: `[ $var = *.txt ]` →
`[[ $var = *.txt ]]`

### SC2082

**What it does**: Flags incorrect indirection syntax **Why is this bad?**: Wrong
syntax for variable indirection **Example**: `echo ${$var}` → `echo ${!var}`

### SC2083

**What it does**: Flags spaces in file paths **Why is this bad?**: Space breaks
path interpretation **Example**: `./my file` → `"./my file"` or `./my\ file`

### SC2084

**What it does**: Flags `$` before arithmetic expression **Why is this bad?**:
May cause command execution of result **Example**: `$((expr))` in command
context → assign to variable first

### SC2087

**What it does**: Flags unquoted here-document delimiter **Why is this bad?**:
Variables expand on client vs server side **Example**: `ssh host <<EOF` →
`ssh host <<'EOF'`

### SC2088

**What it does**: Flags tilde in quotes **Why is this bad?**: Tilde doesn't
expand in quotes **Example**: `"~/file"` → `"$HOME/file"`

### SC2089-SC2090

**What it does**: Flags problematic variable assignment/usage with quotes **Why
is this bad?**: Quotes/backslashes not preserved properly **Example**: Use
arrays for complex values

### SC2091

**What it does**: Flags command substitution that gets executed **Why is this
bad?**: Output is being executed as command **Example**: `$(cmd)` → `"$(cmd)"`
or use `eval` if intended

### SC2092

**What it does**: Flags backticks that execute output **Why is this bad?**:
Command output being executed **Example**: Remove backticks or use assignment

### SC2093

**What it does**: Flags `exec` preventing script continuation **Why is this
bad?**: `exec` replaces current process **Example**: Remove `exec` if script
should continue

### SC2094

**What it does**: Flags reading and writing same file in pipeline **Why is this
bad?**: Creates race condition, file may be truncated **Example**: Use temporary
file or `sponge`

### SC2095

**What it does**: Flags ssh without `-n` **Why is this bad?**: ssh may consume
stdin meant for script **Example**: `ssh host cmd` → `ssh -n host cmd`

### SC2096

**What it does**: Flags shebang with multiple parameters **Why is this bad?**:
Most systems only support one parameter **Example**: `#!/bin/sh -eu` →
`#!/bin/sh` and `set -eu` in script

### SC2097-SC2098

**What it does**: Flags assignments in subshells/command substitutions **Why is
this bad?**: Assignment won't affect parent shell **Example**: Move assignment
outside or use different approach

### SC2099-SC2100

**What it does**: Flags non-arithmetic expressions in arithmetic context **Why
is this bad?**: Use proper arithmetic syntax **Example**: `i=i+1` →
`i=$((i + 1))` or `((i++))`

### SC2101

**What it does**: Flags named character classes without brackets **Why is this
bad?**: Named classes need `[[:class:]]` format **Example**: `:digit:` →
`[[:digit:]]`

### SC2102

**What it does**: Flags character ranges that match single chars **Why is this
bad?**: Range syntax issue **Example**: Check character range definition

### SC2103

**What it does**: Flags `cd` without returning to original directory **Why is
this bad?**: Script changes working directory permanently **Example**: Use
subshell `( cd dir; cmd )` or save/restore PWD

### SC2104-SC2105

**What it does**: Flags `break`/`return` in wrong context **Why is this bad?**:
`break` only works in loops, `return` in functions **Example**: Use appropriate
control flow command

### SC2106

**What it does**: Flags exit in subshell caused by pipeline **Why is this
bad?**: Only exits subshell, not main script **Example**: Check if exit is
intended or use different approach

### SC2107-SC2110

**What it does**: Flags incorrect logical operators **Why is this bad?**: Use
shell logical operators, not test operators **Example**: `[ a -a b ]` →
`[ a ] && [ b ]`

### SC2111-SC2113

**What it does**: Flags function keyword issues **Why is this bad?**:
Inconsistent or non-standard function syntax **Example**: Use `func() { }` or
`function func { }`

### SC2114-SC2115

**What it does**: Flags dangerous directory operations **Why is this bad?**: May
delete system directories **Example**: `rm -rf $var/` → `rm -rf "${var:?}/"`

### SC2116

**What it does**: Flags useless echo in command substitution **Why is this
bad?**: Unnecessary process creation **Example**: `cmd $(echo foo)` → `cmd foo`

### SC2117

**What it does**: Flags incorrect `su`/`sudo` usage **Why is this bad?**:
Commands run with wrong privileges **Example**: Use proper privilege escalation
syntax

### SC2118

**What it does**: Flags ksh-specific syntax in other shells **Why is this
bad?**: `|&` not supported in all shells **Example**: `cmd |& other` →
`cmd 2>&1 | other`

### SC2119-SC2120

**What it does**: Flags function argument mismatch **Why is this bad?**:
Function expects/doesn't expect arguments **Example**: Check function definition
and calls

### SC2121

**What it does**: Flags assignment syntax in set command **Why is this bad?**:
Use assignment syntax, not `set` **Example**: `set var=value` → `var=value`

### SC2122

**What it does**: Flags invalid comparison operator **Why is this bad?**: `>=`
doesn't exist, use appropriate operator **Example**: `[ $a >= $b ]` →
`[ $a -ge $b ]`

### SC2123

**What it does**: Flags assignment to PATH in function **Why is this bad?**:
Overrides system search path **Example**: Use different variable name

### SC2124

**What it does**: Flags array assignment to string variable **Why is this
bad?**: Arrays need proper syntax **Example**: `var=array[@]` →
`var=("${array[@]}")` or `var="${array[*]}"`

### SC2125

**What it does**: Flags brace expansion in assignment **Why is this bad?**:
Brace expansion is literal in assignments **Example**: Quote or use array if
expansion intended

### SC2126

**What it does**: Flags `grep | wc` when `grep -c` would work **Why is this
bad?**: More efficient to use `grep -c` **Example**: `grep pattern file | wc -l`
→ `grep -c pattern file`

### SC2127

**What it does**: Flags ksh-specific syntax without ksh shebang **Why is this
bad?**: `${ ..; }` only works in ksh **Example**: Use `#!/usr/bin/env ksh` or
different syntax

### SC2128

**What it does**: Flags array expansion without index **Why is this bad?**: Only
gives first element **Example**: `echo $array` → `echo "${array[@]}"`

### SC2129

**What it does**: Flags multiple redirections to same file **Why is this bad?**:
Inefficient, use command grouping **Example**: `cmd1 >> file; cmd2 >> file` →
`{ cmd1; cmd2; } >> file`

### SC2130

**What it does**: Flags `-eq` for string comparison **Why is this bad?**: `-eq`
is for integers, use `=` for strings **Example**: `[ "$str" -eq "value" ]` →
`[ "$str" = "value" ]`

### SC2131-SC2145

**What it does**: Various issues with aliases, arrays, and argument handling
**Why is this bad?**: Specific issues with syntax or logic **Example**: Follow
specific guidance for each warning

### SC2146-SC2154

**What it does**: Various issues with command syntax and variable usage **Why is
this bad?**: Syntax errors or problematic patterns **Example**: Follow specific
guidance for each warning

### SC2156-SC2164

**What it does**: Additional best practices and syntax issues **Why is this
bad?**: Various problems with shell script patterns **Example**: Follow specific
guidance for each warning

---

## SC3000 Series - POSIX Compliance

### SC3001

**What it does**: Flags process substitution in POSIX sh **Why is this bad?**:
`<(cmd)` not available in POSIX sh **Example**: Use temporary files or different
approach

### SC3002

**What it does**: Flags extended globbing in POSIX sh **Why is this bad?**:
`*(pattern)` not available in POSIX sh **Example**: Use basic globs or case
statements

### SC3003

**What it does**: Flags `$'...'` quoting in POSIX sh **Why is this bad?**:
ANSI-C quoting not in POSIX sh **Example**: Use `printf` for escape sequences

### SC3004

**What it does**: Flags `$"..."` in POSIX sh **Why is this bad?**:
Locale-specific translation not in POSIX sh **Example**: Use regular double
quotes

### SC3005

**What it does**: Flags arithmetic for loops in POSIX sh **Why is this bad?**:
`for ((;;))` not available in POSIX sh **Example**: Use `while` loop with
counter

### SC3006

**What it does**: Flags standalone `(( ))` in POSIX sh **Why is this bad?**:
Arithmetic evaluation not in POSIX sh **Example**: Use `[ $((expr)) -ne 0 ]`

### SC3007

**What it does**: Flags `$[..]` in POSIX sh **Why is this bad?**: Deprecated
even in bash **Example**: Use `$((...))`

### SC3008

**What it does**: Flags select loops in POSIX sh **Why is this bad?**: `select`
not available in POSIX sh **Example**: Use `while` loop with `read`

### SC3009

**What it does**: Flags brace expansion in POSIX sh **Why is this bad?**:
`{a,b}` not available in POSIX sh **Example**: Use explicit alternatives

### SC3010

**What it does**: Flags `[[ ]]` in POSIX sh **Why is this bad?**: Extended test
not in POSIX sh **Example**: Use `[ ]` with appropriate syntax

### SC3011

**What it does**: Flags here-strings in POSIX sh **Why is this bad?**: `<<<` not
available in POSIX sh **Example**: Use here-documents or pipes

### SC3012

**What it does**: Flags lexicographical comparison in POSIX sh **Why is this
bad?**: `\<` and `\>` not defined in POSIX sh **Example**: Use standard string
comparisons

### SC3013

**What it does**: Flags `-nt` (newer than) in POSIX sh **Why is this bad?**:
File comparison operator not in POSIX sh **Example**: Use `find` or `stat` for
file age comparison

### SC3014

**What it does**: Flags `==` in POSIX sh **Why is this bad?**: Use `=` for POSIX
compatibility **Example**: `[ "$a" == "$b" ]` → `[ "$a" = "$b" ]`

### SC3015

**What it does**: Flags regex matching in POSIX sh **Why is this bad?**: `=~`
not available in POSIX sh **Example**: Use `case` or external tools like `grep`

### SC3016

**What it does**: Flags `-v` test in POSIX sh **Why is this bad?**: Variable
existence test not in POSIX sh **Example**: `[ -v var ]` → `[ -n "${var+x}" ]`

### SC3017

**What it does**: Flags `-a` for file existence in POSIX sh **Why is this
bad?**: Use `-e` instead **Example**: `[ -a file ]` → `[ -e file ]`

### SC3018-SC3019

**What it does**: Flags `++` and exponentials in POSIX sh **Why is this bad?**:
Advanced arithmetic not in POSIX sh **Example**: Use basic arithmetic operations

### SC3020-SC3026

**What it does**: Flags various redirection and expansion features **Why is this
bad?**: Advanced bash features not in POSIX sh **Example**: Use POSIX-compatible
alternatives

### SC3028-SC3060

**What it does**: Flags numerous bash-specific features **Why is this bad?**:
Features not available in POSIX sh **Example**: Use POSIX-compatible syntax or
change shebang to bash

---

## Usage Guidelines

### Quick Fix Priority

1. **Security issues** (SC2086, SC2035, SC2059): Fix immediately
2. **Syntax errors** (SC1xxx): Required for script to run
3. **Logic errors** (SC2015, SC2164): May cause unexpected behavior
4. **Performance** (SC2002, SC2003): Optimize when noticed

### Suppression Format

```bash
# shellcheck disable=SC2034  # Variable used in sourced script
readonly CONFIG_FILE="/etc/app/config"
```

**Remember**: Fix the issue rather than suppress the warning 95% of the time.
Each warning represents accumulated shell scripting wisdom and best practices.
