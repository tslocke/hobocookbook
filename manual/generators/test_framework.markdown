Generators -- manual/generators/test\_framework.markdown
{: .document-title}


## Usage

    

    rails generate hobo:test_framework NAME [options]


## Options

    

    -t, [--test-framework=TEST_FRAMEWORK]            # Use a specific test framework
                                                     # Default: test_unit
        [--skip-namespace]                           # Skip namespace (affects only isolated applications)
        [--fixture-replacement=FIXTURE_REPLACEMENT]  # Use a specific fixture replacement
        [--old-style-hash]                           # Force using old style hash (:foo => 'bar') on Ruby >= 1.9
        [--fixtures]                                 # Add the fixture option to the test framework
                                                     # Default: true
        [--update]                                   # Run bundle update to install the missing gems


## Runtime options

    

    -q, [--quiet]    # Suppress status output
    -s, [--skip]     # Skip files that already exist
    -f, [--force]    # Overwrite files that already exist
    -p, [--pretend]  # Run but do not make any changes


## Description

    

      Create hobo files for test_framework generator.
