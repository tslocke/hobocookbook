Generators -- manual/generators/test\_framework.markdown
{: .document-title}


## Usage

    

    rails generate hobo:test_framework NAME [options]


## Options

    

        [--old-style-hash]                           # Force using old style hash (:foo => 'bar') on Ruby >= 1.9
        [--fixture-replacement=FIXTURE_REPLACEMENT]  # Use a specific fixture replacement
        [--fixtures]                                 # Add the fixture option to the test framework
                                                     # Default: true
    -t, [--test-framework=TEST_FRAMEWORK]            # Use a specific test framework
                                                     # Default: test_unit
        [--update]                                   # Run bundle update to install the missing gems
        [--skip-namespace]                           # Skip namespace (affects only isolated applications)


## Runtime options

    

    -s, [--skip]     # Skip files that already exist
    -p, [--pretend]  # Run but do not make any changes
    -f, [--force]    # Overwrite files that already exist
    -q, [--quiet]    # Supress status output


## Description

    

      Create hobo files for test_framework generator.
