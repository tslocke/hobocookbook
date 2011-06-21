Generators -- test\_framework
{: .document-title}


## Usage

    

  rails generate hobo:test_framework NAME [options]


## Options

    

      [--fixture-replacement=FIXTURE_REPLACEMENT]  # Use a specific fixture replacement
      [--update]                                   # Run bundle update to install the missing gems
      [--fixtures]                                 # Add the fixture option to the test framework
                                                   # Default: true
  -t, [--test-framework=TEST_FRAMEWORK]            # Use a specific test framework
                                                   # Default: test_unit


## Runtime options

    

  -s, [--skip]     # Skip files that already exist
  -p, [--pretend]  # Run but do not make any changes
  -q, [--quiet]    # Supress status output
  -f, [--force]    # Overwrite files that already exist


## Description

    

    Create hobo files for test_framework generator.
