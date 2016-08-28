<?php

$header = <<<'EOF'
This file is part of PHP CS Fixer.

(c) Fabien Potencier <fabien@symfony.com>
    Dariusz Rumiński <dariusz.ruminski@gmail.com>

This source file is subject to the MIT license that is bundled
with this source code in the file LICENSE.
EOF;

Symfony\CS\Fixer\Contrib\HeaderCommentFixer::setHeader($header);

$fixers = [
    'blankline_after_open_tag',
    //'braces',
    'concat_with_spaces',
    '-concat_without_spaces',
    'double_arrow_multiline_whitespaces',
    'duplicate_semicolon',
    'empty_enclosing_lines',
    'encoding',
    'extra_empty_lines',
    'include',
    'function_declaration',
    'list_commas',
    'multiline_array_trailing_comma',
    'namespace_no_leading_whitespace',
    'new_with_braces',
    'object_operator',
    'operator_spaces',
    '-phpdoc_params',
    'phpdoc_no_access',
    'phpdoc_no_package',
    'phpdoc_order',
    'phpdoc_scalar',
    'phpdoc_separation',
    'phpdoc_to_comment',
    'phpdoc_trim',
    'phpdoc_type_to_var',
    'phpdoc_var_without_name',
    'psr0',
    'remove_leading_slash_use',
    '-ordered_use',
    'remove_lines_between_uses',
    'return',
    'self_accessor',
    'single_array_no_trailing_comma',
    'single_line_before_namespace',
    'single_quote',
    'short_array_syntax',
    'short_tag',
    'spaces_before_semicolon',
    'spaces_cast',
    'standardize_not_equal',
    'ternary_spaces',
    'trim_array_spaces',
    'unalign_double_arrow',
    'unalign_equals',
    'unary_operators_spaces',
    'unused_use',
    'whitespacy_lines',
];

$finder = Symfony\CS\Finder::create()
    ->exclude('Symfony/CS/Tests/Fixtures')
    ->files('*.php')
    ->in(__DIR__ . '/src')
;

return Symfony\CS\Config::create()
    // use default SYMFONY_LEVEL and extra fixers:
    ->fixers($fixers)
    ->level(\Symfony\CS\FixerInterface::PSR2_LEVEL)
    ->finder($finder)
;
