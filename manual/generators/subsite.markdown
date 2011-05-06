Generators -- subsite
{: .document-title}


## Usage

    

  rails generate hobo:subsite NAME [options]


## Options

    

  -i, [--invite-only]                            # Add features for an invite only website
      [--user-resource-name=USER_RESOURCE_NAME]  # User Resource Name
                                                 # Default: user
      [--make-front-site]                        # Rename application.dryml to front_site.dryml
  -t, [--test-framework=NAME]                    # Test framework to be invoked
                                                 # Default: test_unit


## Runtime options

    

  -f, [--force]    # Overwrite files that already exist
  -p, [--pretend]  # Run but do not make any changes
  -q, [--quiet]    # Supress status output
  -s, [--skip]     # Skip files that already exist


## Description

    

    Create hobo files for subsite generator.
